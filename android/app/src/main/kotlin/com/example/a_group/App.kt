package com.example.a_group

import android.app.Application
import io.flutter.plugin.common.PluginRegistry
import com.yandex.mapkit.MapKitFactory

class App : Application() {
    override fun onCreate() {
        super.onCreate()
        MapKitFactory.setApiKey("3940300f-dbb6-4eee-9bb4-dbd17f98f3ac")
    }
}
