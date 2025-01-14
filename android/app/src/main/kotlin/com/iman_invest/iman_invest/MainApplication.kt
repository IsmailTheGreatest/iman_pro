package com.iman_invest.iman_invest
import android.app.Application

import com.yandex.mapkit.MapKitFactory

class MainApplication: Application() {
    override fun onCreate() {
        super.onCreate()
        MapKitFactory.setApiKey("api_key_here") // Your generated API key
    }
}