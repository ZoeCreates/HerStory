//
//  HerStoryApp.swift
//  HerStory
//
//  Created by Zi Xia on 9/30/26.
//

import SwiftUI

@main
struct HerStoryApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    @Environment(\.scenePhase) private var scenePhase
    @State private var favorites = FavoritesStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(favorites)
        }
        .onChange(of: scenePhase) { _, phase in
            // 每次 App 回到前台，就把提醒往后补齐 30 天
            if phase == .active { ReminderManager.reschedule() }
        }
    }
}
