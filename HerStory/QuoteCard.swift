//
//  QuoteCard.swift
//  HerStory
//
//  Created by Zi Xia on 11/2/26.
//

import SwiftUI

struct QuoteCard: View {
    let quote: Quote          // ← 这就是 props

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Image(systemName: "quote.opening")
                .font(.title)
                .foregroundStyle(.pink)
            Text(quote.text)
                .font(.system(size: 28, weight: .medium, design: .serif))
            VStack(alignment: .leading, spacing: 4) {
                Text(quote.author).font(.headline)
                Text(quote.role).font(.subheadline).foregroundStyle(.secondary)
                Text(quote.source).font(.caption).foregroundStyle(.tertiary)
            }
        }
        .padding(28)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white, in: RoundedRectangle(cornerRadius: 24))
        .shadow(color: .black.opacity(0.06), radius: 16, y: 8)
    }
}

#Preview {
    QuoteCard(quote: QuoteLibrary.all[2])
        .padding()
}
