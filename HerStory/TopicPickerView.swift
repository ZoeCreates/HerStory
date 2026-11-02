//
//  TopicPickerView.swift
//  HerStory
//
//  Created by Zi Xia on 11/2/26.
//

import SwiftUI
import WidgetKit

struct TopicPickerView: View {
    @AppStorage("selectedTopics", store: Shared.defaults) private var selectedRaw = ""
    var onDone: () -> Void

    private var selected: Set<Topic> {
        Topic.parse(selectedRaw)
    }

    private func toggle(_ topic: Topic) {
        var s = selected
        if s.contains(topic) { s.remove(topic) } else { s.insert(topic) }
        selectedRaw = s.map(\.rawValue).joined(separator: ",")
        WidgetCenter.shared.reloadAllTimelines()   // 通知 widget 马上刷新
    }

    var body: some View {
        ZStack {
            Color(red: 0.96, green: 0.93, blue: 0.88).ignoresSafeArea()
            VStack(alignment: .leading, spacing: 24) {
                Text("What do you need\nmore of right now?")
                    .font(.system(size: 32, weight: .medium, design: .serif))
                Text("Pick a few. We'll tailor your daily quotes.")
                    .foregroundStyle(.secondary)

                ForEach(Topic.allCases, id: \.self) { topic in
                    let isOn = selected.contains(topic)
                    Button { toggle(topic) } label: {
                        HStack {
                            Text(topic.rawValue.capitalized)
                            Spacer()
                            Image(systemName: isOn ? "checkmark.circle.fill" : "circle")
                        }
                        .padding()
                        .background(isOn ? Color.pink.opacity(0.15) : .white,
                                    in: RoundedRectangle(cornerRadius: 16))
                    }
                    .buttonStyle(.plain)
                }

                Spacer()
                Button(action: onDone) {
                    Text("Continue").font(.headline).foregroundStyle(.white)
                        .frame(maxWidth: .infinity).padding()
                        .background(.black, in: Capsule())
                }
                .disabled(selected.isEmpty)
                .opacity(selected.isEmpty ? 0.4 : 1)
            }
            .padding(28)
        }
    }
}

#Preview { TopicPickerView(onDone: {}) }
