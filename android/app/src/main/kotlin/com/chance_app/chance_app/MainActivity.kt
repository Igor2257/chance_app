package com.chance_app.chance_app

import android.content.Intent
import android.net.Uri
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "caller"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "makeCall") {
                val phoneNumber = call.arguments?.toString()
                if (phoneNumber != null) {
                    makeCall(phoneNumber)
                    result.success(null)
                } else {
                    result.error("MISSING_PHONE_NUMBER", "Phone number is missing", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun makeCall(phoneNumber: String) {
        // Ваша логика для совершения звонка на переданный номер телефона
        // Например:
        val intent = Intent(Intent.ACTION_CALL)
        intent.data = Uri.parse("tel:$phoneNumber")
        startActivity(intent)
    }

}