package com.inoser.adan

import android.annotation.TargetApi
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build
import android.os.PowerManager
import android.provider.Settings
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

    private val CHANNEL = "adan/battery"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // Note: this method is invoked on the main thread.
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->


            if (call.method == "isPowerSaveMode") {
                val powerMode = isPowerSaveMode(context)
                result.success(powerMode)
            } else if (call.method == "getBatteryLevel") {
                val batteryLevel = getBatteryLevel()

                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    fun isPowerSaveMode(context: Context?): Boolean {
        return if (Build.MANUFACTURER.equals("Huawei", ignoreCase = true)) {
            isPowerSaveModeHuawei(context!!)
        } else {
            isPowerSaveModeAndroid(context!!)
        }
    }

    @TargetApi(21)
    private fun isPowerSaveModeAndroid(context: Context): Boolean {
        var isPowerSaveMode = false
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val pm = context.getSystemService(POWER_SERVICE) as PowerManager
            if (pm != null) isPowerSaveMode = pm.isPowerSaveMode
        }
        return isPowerSaveMode
    }

    private fun isPowerSaveModeHuawei(context: Context): Boolean {
        return try {
            val value = Settings.System.getInt(context.contentResolver, "SmartModeStatus")
            value == 4
        } catch (e: Settings.SettingNotFoundException) {
            // Setting not found?  Return standard android mechanism and hope for the best...
            isPowerSaveModeAndroid(context)
        }
    }


    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(
                Intent.ACTION_BATTERY_CHANGED))
            batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }

        return batteryLevel
    }
}
