package com.inoser.adan

import com.baseflow.permissionhandler.PermissionHandlerPlugin
import com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin
import io.flutter.app.FlutterApplication
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.GeneratedPluginRegistrant
//import io.flutter.plugins.androidalarmmanager.AlarmService
//import io.flutter.plugins.androidalarmmanager.AndroidAlarmManagerPlugin
import io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin
//import me.carda.awesome_notifications.AwesomeNotificationsPlugin

class Application : FlutterApplication(), PluginRegistry.PluginRegistrantCallback {

    @Override
    override fun onCreate() {
        super.onCreate()
        //AlarmService.setPluginRegistrant(this)
    }

    @Override
    override fun registerWith(registry: PluginRegistry?) {
        //GeneratedPluginRegistrant.registerWith(registry)
//        AndroidAlarmManagerPlugin.registerWith(registry?.registrarFor("io.flutter.plugins.androidalarmmanager.AndroidAlarmManagerPlugin"));
//        AwesomeNotificationsPlugin.registerWith(registry?.registrarFor("me.carda.awesome_notifications.AwesomeNotificationsPlugin"));
        FlutterLocalNotificationsPlugin.registerWith(registry?.registrarFor("com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin"));
        SharedPreferencesPlugin.registerWith(registry?.registrarFor("io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin"));
        PermissionHandlerPlugin.registerWith(registry?.registrarFor("com.baseflow.permissionhandler.PermissionHandlerPlugin"));
//        FlutterLocalNotificationsPlugin.registerWith(registry!!.registrarFor("com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin"));
        GeneratedPluginRegistrant.registerWith(FlutterEngine(applicationContext))
    }
}