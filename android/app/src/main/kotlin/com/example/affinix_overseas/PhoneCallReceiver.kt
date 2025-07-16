package com.example.affinix_overseas

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.telephony.TelephonyManager
import android.util.Log
import androidx.work.*

import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.RequestBody.Companion.toRequestBody
import okhttp3.MediaType.Companion.toMediaType
import java.util.concurrent.TimeUnit
import com.google.gson.Gson
import androidx.core.content.ContextCompat
import android.database.Cursor
import android.provider.CallLog
import android.os.Build
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale
import android.telephony.SubscriptionManager



class PhoneCallReceiver : BroadcastReceiver() {

     data class LastCallSimInfo(
        val calledNumber: String?,
        val simPhoneNumber: String?,
        val simSlotIndex: Int,
        val subscriptionId: Int,
        val networkOperatorName: String?,
        val callType: String,
        val callDate: String,
        val callDuration: String
    )
    
    private data class SimDetails(
        val phoneNumber: String?,
        val slotIndex: Int,
        val subscriptionId: Int,
        val networkOperatorName: String?
    )

    private var lastState = TelephonyManager.CALL_STATE_IDLE
    private var callStartTime: Long = 0
    private var isIncoming = false
    private var savedNumber: String? = null

    override fun onReceive(context: Context, intent: Intent) {
    val stateStr = intent.getStringExtra(TelephonyManager.EXTRA_STATE)
    val action = intent.action
    var number: String? = null

    when (action) {
        Intent.ACTION_NEW_OUTGOING_CALL -> {
            number = intent.getStringExtra(Intent.EXTRA_PHONE_NUMBER)
            Log.d("CallReceiver", "NEW_OUTGOING_CALL: $number")

        }
        TelephonyManager.ACTION_PHONE_STATE_CHANGED -> {
            number = intent.getStringExtra(TelephonyManager.EXTRA_INCOMING_NUMBER)
            Log.d("CallReceiver", "PHONE_STATE_CHANGED: $number, state: $stateStr")

        }
    }
    if (!number.isNullOrEmpty()) {
        val prefs = context.getSharedPreferences("call_receiver", Context.MODE_PRIVATE)
        // savedNumber = number
            Log.d("CallReceiver", "New number received: $number")

        prefs.edit().apply {
                putString("saved_number", number)
                apply()
            }
    }

    val state = when (stateStr) {
        TelephonyManager.EXTRA_STATE_RINGING -> TelephonyManager.CALL_STATE_RINGING
        TelephonyManager.EXTRA_STATE_OFFHOOK -> TelephonyManager.CALL_STATE_OFFHOOK
        TelephonyManager.EXTRA_STATE_IDLE -> TelephonyManager.CALL_STATE_IDLE
        else -> return
    }

    val prefs = context.getSharedPreferences("call_receiver", Context.MODE_PRIVATE)
    val currentLastState = prefs.getInt("last_state", TelephonyManager.CALL_STATE_IDLE)
    
    Log.d("CallReceiver", "State transition: $currentLastState -> $state")
    
    when (state) {
        TelephonyManager.CALL_STATE_RINGING -> {
            val prevState = prefs.getInt("last_state", TelephonyManager.CALL_STATE_IDLE)
            
            // Ignore duplicate RINGING calls
            if (prevState == TelephonyManager.CALL_STATE_RINGING) {
                Log.d("CallReceiver", "Ignoring duplicate RINGING state")
                return
            }
            
            // This is always an incoming call
            isIncoming = true
            callStartTime = System.currentTimeMillis()
            // savedNumber = number
            
            prefs.edit().apply {
                putBoolean("is_incoming", true)
                putLong("call_start_time", callStartTime)
                // putString("saved_number", savedNumber)
                putInt("last_state", state)
                apply()
            }
            
            Log.d("CallReceiver", "Incoming call ringing: $savedNumber")
        }

        TelephonyManager.CALL_STATE_OFFHOOK -> {
            val prevState = prefs.getInt("last_state", TelephonyManager.CALL_STATE_IDLE)
            
            Log.d("CallReceiver", "OFFHOOK - prevState: $prevState")
            
            // Ignore duplicate OFFHOOK calls (Android sends multiple broadcasts)
            if (prevState == TelephonyManager.CALL_STATE_OFFHOOK) {
                Log.d("CallReceiver", "Ignoring duplicate OFFHOOK state")
                return
            }
            
            if (prevState == TelephonyManager.CALL_STATE_RINGING) {
                // Incoming call was answered - maintain the incoming status
                isIncoming = prefs.getBoolean("is_incoming", true)
                callStartTime = prefs.getLong("call_start_time", System.currentTimeMillis())
                savedNumber = prefs.getString("saved_number", number)
                
                Log.d("CallReceiver", "Incoming call answered: $savedNumber, isIncoming: $isIncoming")
            } else {
                // This is an outgoing call (no ringing state before offhook)
                isIncoming = false
                // callStartTime = System.currentTimeMillis()
                callStartTime = prefs.getLong("call_start_time", System.currentTimeMillis())

                // savedNumber = number
                
                prefs.edit().apply {
                    putBoolean("is_incoming", false)
                    putLong("call_start_time", callStartTime)
                    // putString("saved_number", savedNumber)
                    apply()
                }
                
                Log.d("CallReceiver", "Outgoing call started: $savedNumber, isIncoming: $isIncoming")
            }
        }

        TelephonyManager.CALL_STATE_IDLE -> {
            val prevState = prefs.getInt("last_state", TelephonyManager.CALL_STATE_IDLE)
            
            // Ignore duplicate IDLE calls
            if (prevState == TelephonyManager.CALL_STATE_IDLE) {
                Log.d("CallReceiver", "Ignoring duplicate IDLE state")
                return
            }
            
            isIncoming = prefs.getBoolean("is_incoming", false)
            callStartTime = prefs.getLong("call_start_time", 0)
            savedNumber = prefs.getString("saved_number", null)
            
            Log.d("CallReceiver", "IDLE - prevState: $prevState, isIncoming: $isIncoming, savedNumber: $savedNumber")
            
            if (prevState == TelephonyManager.CALL_STATE_RINGING) {
                val phoneNumber = getLastCallSimNumber(context);
                Log.d("CallReceiver", "Missed call: $savedNumber deviceNumber: $phoneNumber")
                CallMonitoringService.sendCallDataToFlutter(savedNumber, "MISSED", 0)
                onCallEnded(context, savedNumber, isIncoming, callStartTime, true)

            } else if (prevState == TelephonyManager.CALL_STATE_OFFHOOK) {
                val phoneNumber = getLastCallSimNumber(context);
                Log.d("CallReceiver", "Call ended - calling onCallEnded with isIncoming: $isIncoming deviceNumber: $phoneNumber")
                onCallEnded(context, savedNumber, isIncoming, callStartTime)
            }
            
            // Clear preferences after call ends
            prefs.edit().clear().apply()
        }
    }
    
    // Always update the last state
    prefs.edit().putInt("last_state", state).apply()
    lastState = state
    
    Log.d("CallReceiver", "Updated last_state to: $state")
}

    private fun onCallEnded(context: Context, number: String?, isIncoming: Boolean, startTime: Long, isMissed: Boolean = false) {
        val duration: Int = getLastCallDuration(context)
        var callType = if (isIncoming) "INCOMING" else "OUTGOING"
        callType = if (isMissed) "MISSED" else callType
        
        Log.e("CallReceiver", "Call ended - Number: $number, Type: $callType, Duration: $duration")
        
        // Send data to Flutter (if app is open)
        CallMonitoringService.sendCallDataToFlutter(number, callType, duration)
        
        // Always send to API (works even when app is closed)
        sendToAPI(context, number, callType, duration)
    }

    private fun sendToAPI(context: Context, phone: String?, callType: String, duration: Int) {
        // Use a separate thread for API call
        Thread {
            try {
                val sharedPref = context.getSharedPreferences(
                    "FlutterSharedPreferences", Context.MODE_PRIVATE
                )
                val officerId = sharedPref.getString("flutter.officer_id", null)
                
                val data = mapOf(
                    "officer_id" to officerId,
                    "phone" to phone,
                    "duration" to duration,
                    "call_type" to callType
                )
                
                Log.e("CallReceiver", "Sending to API: officerId=$officerId, phone=$phone, duration=$duration, callType=$callType")
                
                val jsonMediaType = "application/json".toMediaType()
                val jsonString = Gson().toJson(data)
                val reqBody = jsonString.toRequestBody(jsonMediaType)
                
                val client = OkHttpClient.Builder()
                    .connectTimeout(30, TimeUnit.SECONDS)
                    .readTimeout(30, TimeUnit.SECONDS)
                    .build()
                
                val request = Request.Builder()
                    .url("http://52.66.252.146:3000/lead/add_mobile_call_log")
                    .post(reqBody)
                    .addHeader("Content-Type", "application/json")
                    .build()
                
                val response = client.newCall(request).execute()
                val body = response.body?.string()
                Log.e("CallReceiver", "API Response: $body")
                
            } catch (e: Exception) {
                Log.e("CallReceiver", "API request failed", e)
                // Store failed request for retry
                storeFailedRequest(context, phone, callType, duration)
            }
        }.start()
    }

    private fun storeFailedRequest(context: Context, phone: String?, callType: String, duration: Int) {
        val sharedPref = context.getSharedPreferences("failed_requests", Context.MODE_PRIVATE)
        val existingRequests = sharedPref.getStringSet("requests", mutableSetOf()) ?: mutableSetOf()
        
        val requestData = mapOf(
            "phone" to phone,
            "call_type" to callType,
            "duration" to duration,
            "timestamp" to System.currentTimeMillis()
        )
        
        existingRequests.add(Gson().toJson(requestData))
        sharedPref.edit().putStringSet("requests", existingRequests).apply()
        
        Log.e("CallReceiver", "Stored failed request for retry")
    }

    private fun getLastCallDuration(context: Context): Int {
        val cursor = context.contentResolver.query(
            android.provider.CallLog.Calls.CONTENT_URI,
            arrayOf(android.provider.CallLog.Calls.DURATION),
            null, null,
            android.provider.CallLog.Calls.DATE + " DESC"
        )
        var duration = 0
        cursor?.use {
            if (it.moveToFirst()) {
                duration = it.getInt(it.getColumnIndexOrThrow(android.provider.CallLog.Calls.DURATION))
            }
        }
        return duration
    }

    // private fun handleGetLastCallSimNumber(result: MethodChannel.Result) {
    //     if (!hasRequiredPermissions()) {
    //         result.error("PERMISSION_DENIED", "Required permissions not granted", null)
    //         return
    //     }
        
    //     try {
    //         val simNumber = getLastCallSimNumber()
    //         result.success(simNumber)
    //     } catch (e: Exception) {
    //         result.error("ERROR", "Failed to get last call SIM number: ${e.message}", null)
    //     }
    // }

    // private fun hasRequiredPermissions(): Boolean {
    //     val phonePermission = ContextCompat.checkSelfPermission(
    //         this,
    //         Manifest.permission.READ_PHONE_STATE
    //     ) == PackageManager.PERMISSION_GRANTED
        
    //     val callLogPermission = ContextCompat.checkSelfPermission(
    //         this,
    //         Manifest.permission.READ_CALL_LOG
    //     ) == PackageManager.PERMISSION_GRANTED
        
    //     val phoneNumberPermission = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
    //         ContextCompat.checkSelfPermission(
    //             this,
    //             Manifest.permission.READ_PHONE_NUMBERS
    //         ) == PackageManager.PERMISSION_GRANTED
    //     } else {
    //         true
    //     }
        
    //     return phonePermission && callLogPermission && phoneNumberPermission
    // }
    
    // private fun getRequiredPermissions(): Array<String> {
    //     return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
    //         arrayOf(
    //             Manifest.permission.READ_PHONE_STATE,
    //             Manifest.permission.READ_CALL_LOG,
    //             Manifest.permission.READ_PHONE_NUMBERS
    //         )
    //     } else {
    //         arrayOf(
    //             Manifest.permission.READ_PHONE_STATE,
    //             Manifest.permission.READ_CALL_LOG
    //         )
    //     }
    // }

     private fun getLastCallSimNumber(context: Context ): String? {
        val lastCallSimInfo = getLastCallSimInfo(context)
        return lastCallSimInfo?.simPhoneNumber
    }

    private fun getSimDetailsForSubscription(context: Context,subscriptionId: Int): SimDetails? {
        val telephonyManager = context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
        
        try {
            val simSpecificTelephonyManager = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                telephonyManager.createForSubscriptionId(subscriptionId)
            } else {
                telephonyManager
            }
            
            val subscriptionManager = context.getSystemService(Context.TELEPHONY_SUBSCRIPTION_SERVICE) as SubscriptionManager
            val subscriptionInfo = subscriptionManager.getActiveSubscriptionInfo(subscriptionId)
            
            val phoneNumber = simSpecificTelephonyManager.line1Number
            val networkOperatorName = simSpecificTelephonyManager.networkOperatorName
            val slotIndex = subscriptionInfo?.simSlotIndex ?: -1
            
            return SimDetails(phoneNumber, slotIndex, subscriptionId, networkOperatorName)
        } catch (e: SecurityException) {
            return null
        }
    }
    
    private fun getDefaultSimInfo(context:Context): SimDetails? {
        val telephonyManager = context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
        
        try {
            val phoneNumber = telephonyManager.line1Number
            val networkOperatorName = telephonyManager.networkOperatorName
            
            return SimDetails(phoneNumber, 0, -1, networkOperatorName)
        } catch (e: SecurityException) {
            return null
        }
    }

        private fun getSimInfoForCall(context: Context,phoneAccountId: String?): SimDetails? {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.LOLLIPOP_MR1) {
            return getDefaultSimInfo(context)
        }
        
        val subscriptionManager = context.getSystemService(Context.TELEPHONY_SUBSCRIPTION_SERVICE) as SubscriptionManager
        
        try {
            val subscriptionInfoList = subscriptionManager.activeSubscriptionInfoList
            
            subscriptionInfoList?.forEach { subscriptionInfo ->
                if (phoneAccountId != null) {
                    val subId = subscriptionInfo.subscriptionId.toString()
                    if (phoneAccountId.contains(subId)) {
                        return getSimDetailsForSubscription(context,subscriptionInfo.subscriptionId)
                    }
                }
            }
            
            return subscriptionInfoList?.firstOrNull()?.let { 
                getSimDetailsForSubscription(context,it.subscriptionId) 
            }
            
        } catch (e: SecurityException) {
            return getDefaultSimInfo(context)
        }
    }
    
    private fun getLastCallSimInfo(context : Context): LastCallSimInfo? {
        val cursor: Cursor? = context.contentResolver.query(
            CallLog.Calls.CONTENT_URI,
            arrayOf(
                CallLog.Calls.NUMBER,
                CallLog.Calls.TYPE,
                CallLog.Calls.DATE,
                CallLog.Calls.DURATION,
                CallLog.Calls.PHONE_ACCOUNT_ID
            ),
            null,
            null,
            "${CallLog.Calls.DATE} DESC"
        )
        
        cursor?.use {
            if (it.moveToFirst()) {
                val calledNumber = it.getString(it.getColumnIndexOrThrow(CallLog.Calls.NUMBER))
                val callType = when (it.getInt(it.getColumnIndexOrThrow(CallLog.Calls.TYPE))) {
                    CallLog.Calls.INCOMING_TYPE -> "Incoming"
                    CallLog.Calls.OUTGOING_TYPE -> "Outgoing"
                    CallLog.Calls.MISSED_TYPE -> "Missed"
                    else -> "Unknown"
                }
                val callDate = it.getLong(it.getColumnIndexOrThrow(CallLog.Calls.DATE))
                val callDuration = it.getString(it.getColumnIndexOrThrow(CallLog.Calls.DURATION))
                
                val phoneAccountId = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                    it.getString(it.getColumnIndexOrThrow(CallLog.Calls.PHONE_ACCOUNT_ID))
                } else {
                    null
                }
                
                val dateFormat = SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault())
                val formattedDate = dateFormat.format(Date(callDate))
                
                val simInfo = getSimInfoForCall(context,phoneAccountId)
                
                return LastCallSimInfo(
                    calledNumber = calledNumber,
                    simPhoneNumber = simInfo?.phoneNumber,
                    simSlotIndex = simInfo?.slotIndex ?: -1,
                    subscriptionId = simInfo?.subscriptionId ?: -1,
                    networkOperatorName = simInfo?.networkOperatorName,
                    callType = callType,
                    callDate = formattedDate,
                    callDuration = callDuration
                )
            }
        }
        
        return null
    }

}