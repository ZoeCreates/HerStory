//
//  QuoteCard.swift
//  HerStory
//
//  Created by Zi Xia on 11/2/26.
//

import SwiftUI

struct QuoteCard: View {
    let quote: Quote          // ← 这就是 props
    @State private var showStory = false

    /// 这位作者有没有写好的故事
    private var woman: Woman? { WomenLibrary.find(quote.author) }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Image(systemName: "quote.opening")
                .font(.title)
                .foregroundStyle(Theme.accent)
            Text(quote.text)
                .font(.system(size: 28, weight: .medium, design: .serif))
            VStack(alignment: .leading, spacing: 4) {
                Text(quote.author).font(.headline)
                Text(quote.role).font(.subheadline).foregroundStyle(.secondary)
                Text(quote.source).font(.caption).foregroundStyle(.tertiary)
            }
            if woman != nil {
                Label("Read her story", systemImage: "book")
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(Theme.accent)
            }
        }
        .padding(28)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Theme.card, in: RoundedRectangle(cornerRadius: 24))
        .overlay(RoundedRectangle(cornerRadius: 24).stroke(.primary.opacity(0.08)))   // 细边框，比阴影更适合黑底
        .contentShape(Rectangle())                 // 整张卡片都能点
        .onTapGesture {
            if woman != nil { showStory = true }
        }
        .sheet(isPresented: $showStory) {
            if let woman {
                HerStoryView(woman: woman, quote: quote)
            }
        }
    }
}

#Preview {
    QuoteCard(quote: QuoteLibrary.all[2])
        .padding()
}
