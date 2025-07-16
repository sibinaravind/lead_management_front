// import android.Manifest
// import android.content.Context
// import android.content.pm.PackageManager
// import android.database.Cursor
// import android.os.Build
// import android.provider.CallLog
// import android.telephony.SubscriptionManager
// import android.telephony.TelephonyManager
// import androidx.core.app.ActivityCompat
// import androidx.core.content.ContextCompat
// import java.text.SimpleDateFormat
// import java.util.*

// class LastCallSimHelper(private val context: Context) {
    
//     data class LastCallSimInfo(
//         val calledNumber: String?,
//         val simPhoneNumber: String?,
//         val simSlotIndex: Int,
//         val subscriptionId: Int,
//         val networkOperatorName: String?,
//         val callType: String,
//         val callDate: String,
//         val callDuration: String
//     )
    
//     fun getLastCallSimNumber(): String? {
//         if (!hasRequiredPermissions()) {
//             return null
//         }
        
//         val lastCallSimInfo = getLastCallSimInfo()
//         return lastCallSimInfo?.simPhoneNumber
//     }
    
//     fun getLastCallSimInfo(): LastCallSimInfo? {
//         if (!hasRequiredPermissions()) {
//             return null
//         }
        
//         // Get the last call information
//         val cursor: Cursor? = context.contentResolver.query(
//             CallLog.Calls.CONTENT_URI,
//             arrayOf(
//                 CallLog.Calls.NUMBER,
//                 CallLog.Calls.TYPE,
//                 CallLog.Calls.DATE,
//                 CallLog.Calls.DURATION,
//                 CallLog.Calls.PHONE_ACCOUNT_ID // This helps identify which SIM was used
//             ),
//             null,
//             null,
//             "${CallLog.Calls.DATE} DESC LIMIT 1"
//         )
        
//         cursor?.use {
//             if (it.moveToFirst()) {
//                 val calledNumber = it.getString(it.getColumnIndexOrThrow(CallLog.Calls.NUMBER))
//                 val callType = when (it.getInt(it.getColumnIndexOrThrow(CallLog.Calls.TYPE))) {
//                     CallLog.Calls.INCOMING_TYPE -> "Incoming"
//                     CallLog.Calls.OUTGOING_TYPE -> "Outgoing"
//                     CallLog.Calls.MISSED_TYPE -> "Missed"
//                     else -> "Unknown"
//                 }
//                 val callDate = it.getLong(it.getColumnIndexOrThrow(CallLog.Calls.DATE))
//                 val callDuration = it.getString(it.getColumnIndexOrThrow(CallLog.Calls.DURATION))
                
//                 val phoneAccountId = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
//                     it.getString(it.getColumnIndexOrThrow(CallLog.Calls.PHONE_ACCOUNT_ID))
//                 } else {
//                     null
//                 }
                
//                 val dateFormat = SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault())
//                 val formattedDate = dateFormat.format(Date(callDate))
                
//                 // Get SIM info for the call
//                 val simInfo = getSimInfoForCall(phoneAccountId)
                
//                 return LastCallSimInfo(
//                     calledNumber = calledNumber,
//                     simPhoneNumber = simInfo?.phoneNumber,
//                     simSlotIndex = simInfo?.slotIndex ?: -1,
//                     subscriptionId = simInfo?.subscriptionId ?: -1,
//                     networkOperatorName = simInfo?.networkOperatorName,
//                     callType = callType,
//                     callDate = formattedDate,
//                     callDuration = callDuration
//                 )
//             }
//         }
        
//         return null
//     }
    
//     private data class SimDetails(
//         val phoneNumber: String?,
//         val slotIndex: Int,
//         val subscriptionId: Int,
//         val networkOperatorName: String?
//     )
    
//     private fun getSimInfoForCall(phoneAccountId: String?): SimDetails? {
//         if (Build.VERSION.SDK_INT < Build.VERSION_CODES.LOLLIPOP_MR1) {
//             // For older versions, get default SIM info
//             return getDefaultSimInfo()
//         }
        
//         val subscriptionManager = context.getSystemService(Context.TELEPHONY_SUBSCRIPTION_SERVICE) as SubscriptionManager
//         val telephonyManager = context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
        
//         try {
//             val subscriptionInfoList = subscriptionManager.activeSubscriptionInfoList
            
//             subscriptionInfoList?.forEach { subscriptionInfo ->
//                 // Try to match the phone account ID with subscription
//                 if (phoneAccountId != null) {
//                     val subId = subscriptionInfo.subscriptionId.toString()
//                     if (phoneAccountId.contains(subId)) {
//                         return getSimDetailsForSubscription(subscriptionInfo.subscriptionId)
//                     }
//                 }
//             }
            
//             // If no match found, return the default/first active SIM
//             return subscriptionInfoList?.firstOrNull()?.let { 
//                 getSimDetailsForSubscription(it.subscriptionId) 
//             }
            
//         } catch (e: SecurityException) {
//             return getDefaultSimInfo()
//         }
//     }
    
//     private fun getSimDetailsForSubscription(subscriptionId: Int): SimDetails? {
//         val telephonyManager = context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
        
//         try {
//             val simSpecificTelephonyManager = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
//                 telephonyManager.createForSubscriptionId(subscriptionId)
//             } else {
//                 telephonyManager
//             }
            
//             val subscriptionManager = context.getSystemService(Context.TELEPHONY_SUBSCRIPTION_SERVICE) as SubscriptionManager
//             val subscriptionInfo = subscriptionManager.getActiveSubscriptionInfo(subscriptionId)
            
//             val phoneNumber = simSpecificTelephonyManager.line1Number
//             val networkOperatorName = simSpecificTelephonyManager.networkOperatorName
//             val slotIndex = subscriptionInfo?.simSlotIndex ?: -1
            
//             return SimDetails(phoneNumber, slotIndex, subscriptionId, networkOperatorName)
//         } catch (e: SecurityException) {
//             return null
//         }
//     }
    
//     private fun getDefaultSimInfo(): SimDetails? {
//         val telephonyManager = context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
        
//         try {
//             val phoneNumber = telephonyManager.line1Number
//             val networkOperatorName = telephonyManager.networkOperatorName
            
//             return SimDetails(phoneNumber, 0, -1, networkOperatorName)
//         } catch (e: SecurityException) {
//             return null
//         }
//     }
    
//     fun getAllSimNumbers(): List<SimDetails> {
//         val simList = mutableListOf<SimDetails>()
        
//         if (!hasRequiredPermissions()) {
//             return simList
//         }
        
//         if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP_MR1) {
//             val subscriptionManager = context.getSystemService(Context.TELEPHONY_SUBSCRIPTION_SERVICE) as SubscriptionManager
            
//             try {
//                 val subscriptionInfoList = subscriptionManager.activeSubscriptionInfoList
                
//                 subscriptionInfoList?.forEach { subscriptionInfo ->
//                     getSimDetailsForSubscription(subscriptionInfo.subscriptionId)?.let {
//                         simList.add(it)
//                     }
//                 }
//             } catch (e: SecurityException) {
//                 getDefaultSimInfo()?.let { simList.add(it) }
//             }
//         } else {
//             getDefaultSimInfo()?.let { simList.add(it) }
//         }
        
//         return simList
//     }
    
//     private fun hasRequiredPermissions(): Boolean {
//         val phonePermission = ContextCompat.checkSelfPermission(
//             context,
//             Manifest.permission.READ_PHONE_STATE
//         ) == PackageManager.PERMISSION_GRANTED
        
//         val callLogPermission = ContextCompat.checkSelfPermission(
//             context,
//             Manifest.permission.READ_CALL_LOG
//         ) == PackageManager.PERMISSION_GRANTED
        
//         val phoneNumberPermission = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
//             ContextCompat.checkSelfPermission(
//                 context,
//                 Manifest.permission.READ_PHONE_NUMBERS
//             ) == PackageManager.PERMISSION_GRANTED
//         } else {
//             true
//         }
        
//         return phonePermission && callLogPermission && phoneNumberPermission
//     }
    
//     fun getRequiredPermissions(): Array<String> {
//         return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
//             arrayOf(
//                 Manifest.permission.READ_PHONE_STATE,
//                 Manifest.permission.READ_CALL_LOG,
//                 Manifest.permission.READ_PHONE_NUMBERS
//             )
//         } else {
//             arrayOf(
//                 Manifest.permission.READ_PHONE_STATE,
//                 Manifest.permission.READ_CALL_LOG
//             )
//         }
//     }
// }

// // Usage example in Activity or Fragment
// class MainActivity : AppCompatActivity() {
    
//     private lateinit var lastCallSimHelper: LastCallSimHelper
    
//     override fun onCreate(savedInstanceState: Bundle?) {
//         super.onCreate(savedInstanceState)
        
//         lastCallSimHelper = LastCallSimHelper(this)
        
//         // Check and request permissions
//         if (!hasAllPermissions()) {
//             requestAllPermissions()
//         } else {
//             getLastCallSimNumber()
//         }
//     }
    
//     private fun hasAllPermissions(): Boolean {
//         val requiredPermissions = lastCallSimHelper.getRequiredPermissions()
//         return requiredPermissions.all {
//             ContextCompat.checkSelfPermission(this, it) == PackageManager.PERMISSION_GRANTED
//         }
//     }
    
//     private fun requestAllPermissions() {
//         ActivityCompat.requestPermissions(
//             this,
//             lastCallSimHelper.getRequiredPermissions(),
//             PERMISSIONS_REQUEST_CODE
//         )
//     }
    
//     private fun getLastCallSimNumber() {
//         // Get just the SIM number used for last call
//         val lastCallSimNumber = lastCallSimHelper.getLastCallSimNumber()
//         if (lastCallSimNumber != null) {
//             println("Last call was made from SIM: $lastCallSimNumber")
//         } else {
//             println("Unable to retrieve SIM number for last call")
//         }
        
//         // Get detailed information
//         val lastCallSimInfo = lastCallSimHelper.getLastCallSimInfo()
//         lastCallSimInfo?.let {
//             println("\n=== Last Call SIM Information ===")
//             println("Called Number: ${it.calledNumber ?: "Unknown"}")
//             println("SIM Phone Number: ${it.simPhoneNumber ?: "Not available"}")
//             println("SIM Slot Index: ${it.simSlotIndex}")
//             println("Subscription ID: ${it.subscriptionId}")
//             println("Network Operator: ${it.networkOperatorName ?: "Unknown"}")
//             println("Call Type: ${it.callType}")
//             println("Call Date: ${it.callDate}")
//             println("Call Duration: ${it.callDuration} seconds")
//         }
        
//         // Show all available SIM numbers
//         val allSimNumbers = lastCallSimHelper.getAllSimNumbers()
//         println("\n=== All Available SIM Numbers ===")
//         allSimNumbers.forEachIndexed { index, simDetails ->
//             println("SIM ${index + 1}:")
//             println("  Phone Number: ${simDetails.phoneNumber ?: "Not available"}")
//             println("  Slot Index: ${simDetails.slotIndex}")
//             println("  Subscription ID: ${simDetails.subscriptionId}")
//             println("  Network Operator: ${simDetails.networkOperatorName ?: "Unknown"}")
//         }
//     }
    
//     override fun onRequestPermissionsResult(
//         requestCode: Int,
//         permissions: Array<out String>,
//         grantResults: IntArray
//     ) {
//         super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        
//         if (requestCode == PERMISSIONS_REQUEST_CODE) {
//             if (grantResults.isNotEmpty() && grantResults.all { it == PackageManager.PERMISSION_GRANTED }) {
//                 getLastCallSimNumber()
//             } else {
//                 println("Required permissions denied - cannot access SIM and call log information")
//             }
//         }
//     }
    
//     companion object {
//         private const val PERMISSIONS_REQUEST_CODE = 1001
//     }
// }