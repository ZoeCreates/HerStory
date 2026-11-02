//
//  SettingsView.swift
//  HerStory
//
//  Created by Zi Xia on 11/2/26.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("onboardingStep") private var step = 0
    @State private var showTopics = false

    var body: some View {
        NavigationStack {
            List {
                Button("Change my topics") { showTopics = true }
                Button("Replay onboarding", role: .destructive) { step = 0 }
            }
            .navigationTitle("Settings")
            .sheet(isPresented: $showTopics) {
                TopicPickerView { showTopics = false }
            }
        }
    }
}
