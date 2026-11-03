//
//  HerStoryView.swift
//  HerStory
//

import SwiftUI

/// 点语录卡片后弹出的"她的故事"页面
struct HerStoryView: View {
    let woman: Woman
    let quote: Quote
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // 标题区
                    VStack(alignment: .leading, spacing: 6) {
                        Text("HER STORY")
                            .font(.caption).tracking(3)
                            .foregroundStyle(.secondary)
                        Text(woman.name)
                            .font(.system(size: 34, weight: .medium, design: .serif))
                        Text("\(woman.headline) · \(woman.years)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    // 故事
                    Text(woman.story)
                        .lineSpacing(5)

                    // 关键时刻
                    VStack(alignment: .leading, spacing: 8) {
                        Label("Key moment", systemImage: "sparkles")
                            .font(.headline)
                            .foregroundStyle(Theme.accent)
                        Text(woman.keyMoment)
                            .lineSpacing(5)
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Theme.card, in: RoundedRectangle(cornerRadius: 20))

                    // 语录
                    VStack(alignment: .leading, spacing: 6) {
                        Text("“\(quote.text)”")
                            .font(.system(.title3, design: .serif))
                        Text(quote.source)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(24)
            }
            .background(Theme.background)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    HerStoryView(woman: WomenLibrary.all[0], quote: QuoteLibrary.all[1])
}
