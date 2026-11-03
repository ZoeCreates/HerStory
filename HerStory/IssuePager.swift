//
//  IssuePager.swift
//  HerStory
//
//  像翻杂志一样左右滑：最右边是今天，往右滑翻到以前的期。
//  React 类比：一个横向的 carousel，selection 就是当前页的 index（useState）
//

import SwiftUI

struct IssuePager: View {
    /// 0 = 今天，-1 = 昨天，-2 = 前天……
    @State private var offset = 0
    /// 最多能往回翻多少期
    static let backIssues = 30

    var body: some View {
        ZStack {
            // 背景只画一次，翻页时只有文字在动，不会出现渐变接缝
            Theme.background.ignoresSafeArea()

            TabView(selection: $offset) {
                ForEach(-(Self.backIssues - 1)...0, id: \.self) { i in
                    TodayView(date: day(at: i), showsBackground: false)
                        .tag(i)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))   // 翻页样式，不显示小圆点
        }
        // 翻到以前的期时，左上角出现"回到今天"
        .overlay(alignment: .topLeading) {
            if offset != 0 {
                Button {
                    withAnimation { offset = 0 }
                } label: {
                    HStack(spacing: 4) {
                        Text("Today")
                        Image(systemName: "arrow.right")
                    }
                    .font(.subheadline.weight(.semibold))
                }
                .tint(Theme.text)
                .padding(.horizontal, 28)
                .padding(.top, 10)
                .transition(.opacity)
            }
        }
    }

    private func day(at offset: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: offset, to: .now) ?? .now
    }
}

#Preview {
    IssuePager().environment(FavoritesStore())
}
