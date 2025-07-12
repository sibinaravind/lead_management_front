package com.example.affinix_overseas

import io.flutter.embedding.android.FlutterActivity
import android.content.IntentFilter
import android.telephony.TelephonyManager
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

import android.content.Intent
import android.os.Build
import android.content.Context
import android.net.Uri
import android.provider.Settings
import android.os.PowerManager

import androidx.annotation.NonNull
import androidx.core.content.ContextCompat
import android.content.pm.PackageManager
import android.Manifest


class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.affinix_overseas/native_call_handler"
    private var callMonitoringService: Intent? = null

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "startCallMonitoring" -> {
                    startCallMonitoring()
                    result.success("Call monitoring started")
                }
                "stopCallMonitoring" -> {
                    stopCallMonitoring()
                    result.success("Call monitoring stopped")
                }
                "isIgnoringBatteryOptimizations" -> {
                    result.success(isIgnoringBatteryOptimizations())
                }
                "requestIgnoreBatteryOptimizations" -> {
                    requestIgnoreBatteryOptimizations()
                    result.success("Battery optimization request sent")
                }
                "hasPermissions" -> {
                    result.success(hasRequiredPermissions())
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun startCallMonitoring() {
        if (callMonitoringService == null) {
            callMonitoringService = Intent(this, CallMonitoringService::class.java)
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                startForegroundService(callMonitoringService)
            } else {
                startService(callMonitoringService)
            }
        }
    }

    private fun stopCallMonitoring() {
        callMonitoringService?.let {
            stopService(it)
            callMonitoringService = null
        }
    }

    private fun isIgnoringBatteryOptimizations(): Boolean {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            val powerManager = getSystemService(Context.POWER_SERVICE) as PowerManager
            return powerManager.isIgnoringBatteryOptimizations(packageName)
        }
        return true
    }

    private fun requestIgnoreBatteryOptimizations() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            val intent = Intent(Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS)
            intent.data = Uri.parse("package:$packageName")
            startActivity(intent)
        }
    }

    private fun hasRequiredPermissions(): Boolean {
        return ContextCompat.checkSelfPermission(this, Manifest.permission.READ_PHONE_STATE) == PackageManager.PERMISSION_GRANTED &&
               ContextCompat.checkSelfPermission(this, Manifest.permission.PROCESS_OUTGOING_CALLS) == PackageManager.PERMISSION_GRANTED &&
               ContextCompat.checkSelfPermission(this, Manifest.permission.READ_CALL_LOG) == PackageManager.PERMISSION_GRANTED
    }
}

