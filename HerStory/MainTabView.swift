//
//  MainTabView.swift
//  HerStory
//
//  主界面：学 I am 的做法，不用底部 Tab 栏。
//  一整屏就是今日语录，右上角两个小图标打开"收藏"和"设置"（从底部弹出的 sheet）。
//

import SwiftUI

struct MainTabView: View {
    @Environment(FavoritesStore.self) private var favorites
    @State private var showSaved = false
    @State private var showSettings = false

    var body: some View {
        IssuePager()          // 左右滑翻期
            .overlay(alignment: .topTrailing) {
                HStack(spacing: 22) {
                    Button { showSaved = true } label: {
                        Image(systemName: "heart.text.square")
                    }
                    Button { showSettings = true } label: {
                        Image(systemName: "gearshape")
                    }
                }
                .font(.title3)
                .tint(Theme.text)
                .padding(.horizontal, 28)
                .padding(.top, 8)
            }
            .sheet(isPresented: $showSaved) {
                SavedView().environment(favorites)
            }
            .sheet(isPresented: $showSettings) {
                SettingsView()
            }
    }
}

#Preview {
    MainTabView().environment(FavoritesStore())
}
