//
//  SettingsView.swift
//  HerStory
//
//  Created by Zi Xia on 11/2/26.
//

import SwiftUI
import WidgetKit

struct SettingsView: View {
    @AppStorage("onboardingStep") private var step = 0
    @AppStorage(ReminderManager.enabledKey, store: Shared.defaults) private var reminderOn = false
    @AppStorage(ReminderManager.hourKey, store: Shared.defaults) private var hour = 8
    @AppStorage(ReminderManager.minuteKey, store: Shared.defaults) private var minute = 0
    @State private var showTopics = false
    @AppStorage(QuoteKind.storageKey, store: Shared.defaults) private var kindsRaw = ""
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

    /// 用户现在开着的分类。什么都没存过 = 全部开着
    private var activeKinds: Set<QuoteKind> {
        let saved = QuoteKind.parse(kindsRaw)
        return saved.isEmpty ? Set(QuoteKind.allCases) : saved
    }

    /// 每个分类开关的 Binding：读的时候看在不在集合里，改的时候更新集合并存回去
    private func kindBinding(_ kind: QuoteKind) -> Binding<Bool> {
        Binding(
            get: { activeKinds.contains(kind) },
            set: { isOn in
                var kinds = activeKinds
                if isOn { kinds.insert(kind) } else { kinds.remove(kind) }
                guard !kinds.isEmpty else { return }          // 至少留一个，不然没有 quote 可显示
                kindsRaw = QuoteKind.allCases                 // 按固定顺序存，像 "person,book"
                    .filter { kinds.contains($0) }
                    .map(\.rawValue)
                    .joined(separator: ",")
                WidgetCenter.shared.reloadAllTimelines()      // widget 马上换
                ReminderManager.reschedule()                  // 推送内容也跟着换
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

                Section {
                    ForEach(QuoteKind.allCases) { kind in
                        Toggle(isOn: kindBinding(kind)) {
                            Label(kind.label, systemImage: kind.icon)
                        }
                        .disabled(activeKinds == [kind])      // 最后一个开着的不能关
                    }
                } header: {
                    Text("Quotes from")
                } footer: {
                    Text("Books, films and plays by women writers, directors and playwrights.")
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
