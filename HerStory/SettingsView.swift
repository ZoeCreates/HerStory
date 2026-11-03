//
//  SettingsView.swift
//  HerStory
//
//  Created by Zi Xia on 11/2/26.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("onboardingStep") private var step = 0
    @AppStorage(ReminderManager.enabledKey, store: Shared.defaults) private var reminderOn = false
    @AppStorage(ReminderManager.hourKey, store: Shared.defaults) private var hour = 8
    @AppStorage(ReminderManager.minuteKey, store: Shared.defaults) private var minute = 0
    @State private var showTopics = false
    @Environment(\.dismiss) private var dismiss
    @State private var permissionDenied = false

    /// DatePicker 需要一个 Date，但我们存的是 hour 和 minute 两个数字
    /// 这个自定义 Binding 负责在两者之间转换
    private var reminderTime: Binding<Date> {
        Binding(
            get: {
                Calendar.current.date(from: DateComponents(hour: hour, minute: minute)) ?? .now
            },
            set: { newValue in
                let parts = Calendar.current.dateComponents([.hour, .minute], from: newValue)
                hour = parts.hour ?? 8
                minute = parts.minute ?? 0
                ReminderManager.reschedule()
            }
        )
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    Toggle("Daily quote reminder", isOn: $reminderOn)
                    if reminderOn {
                        DatePicker("Time", selection: reminderTime, displayedComponents: .hourAndMinute)
                        Button("Send a test notification") { ReminderManager.sendTest() }
                    }
                } header: {
                    Text("Reminder")
                } footer: {
                    Text(permissionDenied
                         ? "Notifications are off for HerStory. Turn them on in the Settings app."
                         : "One quote a day, picked from your topics.")
                }

                Section("Appearance") {
                    NavigationLink {
                        ThemePickerView()
                    } label: {
                        LabeledContent("Theme", value: Theme.current.name)
                    }
                }

                Section {
                    Button("Change my topics") { showTopics = true }
                    Button("Replay onboarding", role: .destructive) { step = 0 }
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
            .sheet(isPresented: $showTopics) {
                TopicPickerView { showTopics = false }
            }
            .onChange(of: reminderOn) { _, isOn in
                Task {
                    if isOn {
                        let granted = await ReminderManager.requestPermission()
                        if !granted {
                            permissionDenied = true
                            reminderOn = false
                            return
                        }
                        permissionDenied = false
                    }
                    ReminderManager.reschedule()
                }
            }
        }
    }
}
