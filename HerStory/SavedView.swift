//
//  SavedView.swift
//  HerStory
//
//  Created by Zi Xia on 11/2/26.
//

import SwiftUI

struct SavedView: View {
    @Environment(FavoritesStore.self) private var favorites
    @Environment(\.dismiss) private var dismiss    // 用来关掉这个弹出页

    var body: some View {
        NavigationStack {
            Group {
                if favorites.quotes.isEmpty {
                    ContentUnavailableView("No saved quotes yet",
                                           systemImage: "heart",
                                           description: Text("Tap the heart on a quote to keep it here."))
                } else {
                    ScrollView {
                        LazyVStack(spacing: 20) {
                            ForEach(favorites.quotes) { quote in
                                VStack(spacing: 12) {
                                    QuoteCard(quote: quote)
                                    QuoteActions(quote: quote)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Theme.background.ignoresSafeArea())      // 背景铺满，包括标题栏
            .toolbarBackground(.hidden, for: .navigationBar)      // 标题栏透明，不再是一块灰色
            .navigationTitle("Saved")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    SavedView().environment(FavoritesStore())
}
