import SwiftUI

/// 某一天的那一"期"：期号 + 语录 + 按钮
struct TodayView: View {
    var date: Date = .now            // 有默认值的 prop，相当于可选 prop
    var showsBackground = true       // 放在翻页器里时，背景由翻页器统一画
    @AppStorage("selectedTopics", store: Shared.defaults) private var selectedRaw = ""

    var body: some View {
        let quote = QuoteLibrary.today(date, topics: Topic.parse(selectedRaw))
        let theme = Theme.current      // 读了它，主题一换这个页面就自动重画

        ZStack {
            if showsBackground {
                Theme.background.ignoresSafeArea()
            }

            // 全屏大字，一屏一句
            VStack(spacing: 0) {
                header(theme: theme)
                Spacer()
                QuoteHero(quote: quote, theme: theme)
                Spacer()
                if theme == .paper {
                    Rectangle().fill(theme.text).frame(height: 1).padding(.bottom, 16)
                }
                QuoteActions(quote: quote, compact: true)
                    .padding(.bottom, 20)
            }
            .padding(.horizontal, 28)
            .padding(.top, 52)      // 给右上角的图标留位置
        }
    }

    /// 顶部的期号行：NO. 307 ········ TODAY · NOV 3
    @ViewBuilder
    private func header(theme: AppTheme) -> some View {
        let day = date.formatted(.dateTime.month(.abbreviated).day()).uppercased()   // "NOV 3"
        let isToday = Calendar.current.isDateInToday(date)

        VStack(spacing: 10) {
            HStack {
                Text("NO. \(Issue.number(for: date))")
                Spacer()
                Text(isToday ? "TODAY · \(day)" : day)
            }
            .font(.system(size: 11, weight: theme == .poster ? .semibold : .regular))
            .tracking(2)
            .foregroundStyle(theme.muted)

            if theme == .paper {
                Rectangle().fill(theme.text).frame(height: 1)
            }
        }
    }
}

/// 期号：从 2026 年 1 月 1 日算起是第几天。所有用户同一天看到的是同一期，像真的杂志一样
enum Issue {
    static let firstDay = Calendar.current.date(from: DateComponents(year: 2026, month: 1, day: 1)) ?? .now

    static func number(for date: Date) -> Int {
        let cal = Calendar.current
        let days = cal.dateComponents([.day],
                                      from: cal.startOfDay(for: firstDay),
                                      to: cal.startOfDay(for: date)).day ?? 0
        return days + 1
    }
}

#Preview("Today") { TodayView().environment(FavoritesStore()) }
#Preview("Yesterday") { TodayView(date: .now.addingTimeInterval(-86400)).environment(FavoritesStore()) }
