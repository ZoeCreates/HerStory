//
//  ThemePickerView.swift
//  HerStory
//
//  Settings → Theme：两列缩略图，点一下马上换主题（widget 也一起换）
//

import SwiftUI
import WidgetKit

struct ThemePickerView: View {
    private let store = ThemeStore.shared
    private let columns = [GridItem(.flexible(), spacing: 16),
                           GridItem(.flexible(), spacing: 16)]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(AppTheme.allCases) { theme in
                    Button {
                        store.select(theme)
                        WidgetCenter.shared.reloadAllTimelines()   // widget 跟着换
                    } label: {
                        VStack(spacing: 8) {
                            ThemeTile(theme: theme, isSelected: store.theme == theme)
                            Text(theme.name)
                                .font(.subheadline.weight(.medium))
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
        }
        .background(Theme.background)
        .navigationTitle("Theme")
        .navigationBarTitleDisplayMode(.inline)
    }
}

/// 一个主题的缩略图：就是缩小版的今日页
struct ThemeTile: View {
    let theme: AppTheme
    let isSelected: Bool

    var body: some View {
        ZStack(alignment: .topTrailing) {
            QuoteHero(quote: QuoteLibrary.all[0], theme: theme, scale: 0.5, showSource: false)
                .padding(14)
                .frame(maxWidth: .infinity, minHeight: 210, maxHeight: 210)
                .background(theme.backgroundStyle,
                            in: RoundedRectangle(cornerRadius: 20))

            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .font(.title3)
                    .foregroundStyle(theme.text)
                    .padding(10)
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(isSelected ? Color.primary : Color.primary.opacity(0.12),
                        lineWidth: isSelected ? 2.5 : 1)
        )
    }
}

#Preview {
    NavigationStack { ThemePickerView() }
}
