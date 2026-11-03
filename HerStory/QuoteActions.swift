//
//  QuoteActions.swift
//  HerStory
//

import SwiftUI

/// 收藏 + 分享 + 壁纸按钮，今日页和收藏页共用
/// compact = true 时只显示图标（全屏大字主题用），还会多一个"她的故事"按钮
struct QuoteActions: View {
    @Environment(FavoritesStore.self) private var favorites   // 相当于 useContext
    let quote: Quote
    var compact = false
    @State private var showWallpaper = false
    @State private var showStory = false

    private var woman: Woman? { WomenLibrary.find(quote.author) }

    var body: some View {
        Group {
            if compact {
                buttons
                    .labelStyle(.iconOnly)
                    .font(.title3)
                    .tint(Theme.text)
            } else {
                buttons
                    .font(.headline)
                    .tint(Theme.accent)
            }
        }
        .sheet(isPresented: $showWallpaper) {
            WallpaperSheet(quote: quote)
        }
        .sheet(isPresented: $showStory) {
            if let woman { HerStoryView(woman: woman, quote: quote) }
        }
    }

    private var buttons: some View {
        HStack(spacing: compact ? 40 : 24) {
            Button {
                favorites.toggle(quote)
            } label: {
                Label("Save", systemImage: favorites.isSaved(quote) ? "heart.fill" : "heart")
            }

            ShareLink(item: quote.shareText) {
                Label("Share", systemImage: "square.and.arrow.up")
            }

            Button {
                showWallpaper = true
            } label: {
                Label("Wallpaper", systemImage: "photo")
            }

            if compact && woman != nil {
                Button {
                    showStory = true
                } label: {
                    Label("Her story", systemImage: "book")
                }
            }
        }
    }
}

#Preview {
    VStack(spacing: 40) {
        QuoteActions(quote: QuoteLibrary.all[0])
        QuoteActions(quote: QuoteLibrary.all[0], compact: true)
    }
    .environment(FavoritesStore())
}
