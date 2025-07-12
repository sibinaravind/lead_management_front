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



class PhoneCallReceiver : BroadcastReceiver() {
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
            }
            TelephonyManager.ACTION_PHONE_STATE_CHANGED -> {
                number = intent.getStringExtra(TelephonyManager.EXTRA_INCOMING_NUMBER)
            }
        }

        val state = when (stateStr) {
            TelephonyManager.EXTRA_STATE_RINGING -> TelephonyManager.CALL_STATE_RINGING
            TelephonyManager.EXTRA_STATE_OFFHOOK -> TelephonyManager.CALL_STATE_OFFHOOK
            TelephonyManager.EXTRA_STATE_IDLE -> TelephonyManager.CALL_STATE_IDLE
            else -> return
        }

        val prefs = context.getSharedPreferences("call_receiver", Context.MODE_PRIVATE)
        
        when (state) {
            TelephonyManager.CALL_STATE_RINGING -> {
                isIncoming = true
                callStartTime = System.currentTimeMillis()
                savedNumber = number
                
                prefs.edit().apply {
                    putBoolean("is_incoming", true)
                    putLong("call_start_time", callStartTime)
                    putString("saved_number", savedNumber)
                    putInt("last_state", state)
                    apply()
                }
            }

            TelephonyManager.CALL_STATE_OFFHOOK -> {
                val prevState = prefs.getInt("last_state", TelephonyManager.CALL_STATE_IDLE)
                if (prevState != TelephonyManager.CALL_STATE_RINGING) {
                    isIncoming = false
                    callStartTime = System.currentTimeMillis()
                    savedNumber = number
                    
                    prefs.edit().apply {
                        putBoolean("is_incoming", false)
                        putLong("call_start_time", callStartTime)
                        putString("saved_number", savedNumber)
                        apply()
                    }
                } else {
                    isIncoming = prefs.getBoolean("is_incoming", true)
                    callStartTime = prefs.getLong("call_start_time", System.currentTimeMillis())
                    savedNumber = prefs.getString("saved_number", number)
                }
            }

            TelephonyManager.CALL_STATE_IDLE -> {
                val prevState = prefs.getInt("last_state", TelephonyManager.CALL_STATE_IDLE)
                isIncoming = prefs.getBoolean("is_incoming", false)
                callStartTime = prefs.getLong("call_start_time", 0)
                savedNumber = prefs.getString("saved_number", null)
                
                if (prevState == TelephonyManager.CALL_STATE_RINGING) {
                    Log.d("CallReceiver", "Missed call: $savedNumber")
                    // Send missed call to Flutter
                    CallMonitoringService.sendCallDataToFlutter(savedNumber, "MISSED", 0)
                } else if (prevState == TelephonyManager.CALL_STATE_OFFHOOK) {
                    onCallEnded(context, savedNumber, isIncoming, callStartTime)
                }
                
                prefs.edit().clear().apply()
            }
        }
        
        prefs.edit().putInt("last_state", state).apply()
        lastState = state
    }

    private fun onCallEnded(context: Context, number: String?, isIncoming: Boolean, startTime: Long) {
        val duration: Int = getLastCallDuration(context)
        val callType = if (isIncoming) "INCOMING" else "OUTGOING"
        
        Log.e("CallReceiver", "Number: $number, Type: $callType, Duration: $duration")
        
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
                
                Log.e("CallReceiver", "Sending to API: officerId=$officerId, phone=$phone, duration=$duration")
                
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
}
