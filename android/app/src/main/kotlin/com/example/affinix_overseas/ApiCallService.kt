
package com.example.affinix_overseas

import android.app.Service
import android.content.Intent
import android.os.IBinder
import android.util.Log
import android.content.Context
import okhttp3.MediaType.Companion.toMediaType
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.RequestBody
import okhttp3.RequestBody.Companion.toRequestBody
import okhttp3.Response
import okhttp3.Call
import okhttp3.Callback
import java.io.IOException
import java.util.concurrent.TimeUnit
import com.google.gson.Gson

import androidx.core.app.JobIntentService



import androidx.work.Worker
import androidx.work.WorkerParameters

class ApiCallWorker(context: Context, workerParams: WorkerParameters) : Worker(context, workerParams) {

    override fun doWork(): Result {
        val phone = inputData.getString("phone")
        val callType = inputData.getString("call_type")
        val duration = inputData.getInt("duration", 0)

        val sharedPref = applicationContext.getSharedPreferences(
            "FlutterSharedPreferences", Context.MODE_PRIVATE
        )
        val officerId = sharedPref.getString("flutter.officer_id", null)

        val data = mapOf(
            "officer_id" to officerId,
            "phone" to phone,
            "duration" to duration,
            "call_type" to callType
        )

        Log.e("ApiCallWorker", "officerId=$officerId, phone=$phone, duration=$duration")

        val jsonMediaType = "application/json".toMediaType()
        val jsonString = Gson().toJson(data)
        val reqBody = jsonString.toRequestBody(jsonMediaType)

        val client = OkHttpClient()
        val request = Request.Builder()
            .url("http://52.66.252.146:3000/lead/add_mobile_call_log")
            .post(reqBody)
            .addHeader("Content-Type", "application/json")
            .build()

        return try {
            val response = client.newCall(request).execute()
            val body = response.body?.string()
            Log.e("ApiCallWorker", "API Response: $body")
            Result.success()
        } catch (e: IOException) {
            Log.e("ApiCallWorker", "API request failed", e)
            Result.retry()
        }
    }
}