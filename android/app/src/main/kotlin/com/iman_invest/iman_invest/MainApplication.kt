package com.iman_invest.iman_invest
import android.app.Application

import com.yandex.mapkit.MapKitFactory

class MainApplication: Application() {
    override fun onCreate() {
        super.onCreate()
        MapKitFactory.setApiKey("a1ebe68a-a5db-4f28-878f-c62d393cd0e8") // Your generated API key
    }
}