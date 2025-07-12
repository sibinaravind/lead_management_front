package com.example.affinix_overseas

// Android core
import android.app.Service
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Build
import android.os.IBinder
import android.telephony.TelephonyManager
import android.util.Log

// Notification support library
import androidx.core.app.NotificationCompat

// Flutter integration
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel



class CallMonitoringService : Service() {
    private lateinit var phoneCallReceiver: PhoneCallReceiver
    private val NOTIFICATION_ID = 1001


 


    companion object {

        private const val CHANNEL_ID = "com.example.affinix_overseas/native_call_handler"  // Move here
        private const val CHANNEL_NAME = "Call Monitoring"
        private const val NOTIFICATION_ID = 1

        private var flutterEngine: FlutterEngine? = null
        private var methodChannel: MethodChannel? = null

        fun initializeFlutterEngine(context: Context) {
            if (flutterEngine == null) {
                flutterEngine = FlutterEngine(context)
                flutterEngine?.dartExecutor?.executeDartEntrypoint(
                    DartExecutor.DartEntrypoint.createDefault()
                )
                methodChannel = MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL_ID)
            }
        }

        fun sendCallDataToFlutter(phoneNumber: String?, callType: String, duration: Int) {
            methodChannel?.invokeMethod("onCallEnded", mapOf(
                "phoneNumber" to phoneNumber,
                "callType" to callType,
                "duration" to duration,
                "timestamp" to System.currentTimeMillis()
            ))
        }
    }

    override fun onCreate() {
        super.onCreate()
        phoneCallReceiver = PhoneCallReceiver()
        createNotificationChannel()
        startForeground(NOTIFICATION_ID, createNotification())
        registerReceiver()
        initializeFlutterEngine(this)
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        return START_STICKY
    }

    private fun registerReceiver() {
        val filter = IntentFilter().apply {
            addAction(TelephonyManager.ACTION_PHONE_STATE_CHANGED)
            addAction(Intent.ACTION_NEW_OUTGOING_CALL)
        }
        registerReceiver(phoneCallReceiver, filter)
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                "CALL_MONITORING_CHANNEL",
                "Call Monitoring",
                NotificationManager.IMPORTANCE_LOW
            ).apply {
                description = "Monitoring phone calls"
                setShowBadge(false)
            }
            val notificationManager = getSystemService(NotificationManager::class.java)
            notificationManager.createNotificationChannel(channel)
        }
    }

    private fun createNotification(): Notification {
        return NotificationCompat.Builder(this, "CALL_MONITORING_CHANNEL")
            .setContentTitle("Call Monitoring Active")
            .setContentText("Monitoring phone calls in background")
            .setSmallIcon(android.R.drawable.ic_menu_call)
            .setOngoing(true)
            .setPriority(NotificationCompat.PRIORITY_LOW)
            .build()
    }

    override fun onDestroy() {
        super.onDestroy()
        try {
            unregisterReceiver(phoneCallReceiver)
        } catch (e: Exception) {
            Log.e("CallMonitoringService", "Error unregistering receiver", e)
        }
    }

    override fun onBind(intent: Intent?): IBinder? = null
}