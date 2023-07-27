package com.example.privacy_screen
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.view.WindowManager

class MainActivity: FlutterActivity() {
    private val CHANNEL = "security"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        enableAppSecurity();
        setupMethodChannel(flutterEngine)
    }

    private fun setupMethodChannel(flutterEngine: FlutterEngine) {
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "enableAppSecurity" -> {
                    enableAppSecurity()
                    result.success(null)
                }
                "disableAppSecurity" -> {
                    disableAppSecurity()
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun enableAppSecurity() {
        window.setFlags(WindowManager.LayoutParams.FLAG_SECURE
            , WindowManager.LayoutParams.FLAG_SECURE)
    }

    private fun disableAppSecurity() {
        window.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
    }
}