//
//  MainTabView.swift
//  HerStory
//
//  Created by Zi Xia on 11/2/26.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            Tab("Today", systemImage: "sun.max") { TodayView() }
            Tab("Saved", systemImage: "heart") { SavedView() }
            Tab("Settings", systemImage: "gearshape") { SettingsView() }
        }
        .tint(.pink)
    }
}
