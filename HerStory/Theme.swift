//
//  Theme.swift
//  HerStory
//
//  整个 App（和 widget）的颜色、字体都从这里取。
//  现在有 7 套主题，用户在 Settings → Theme 里切换。
//
//  React 类比：
//  - AppTheme 像一份 themes = { paper: {...}, cobalt: {...} } 配置表
//  - ThemeStore 像一个全局 Zustand store，存"当前选的是哪套"
//  - Theme.accent 这些就像 CSS 变量 var(--accent)，永远指向当前主题
//

import SwiftUI
import Observation

// MARK: - 7 套主题

enum AppTheme: String, CaseIterable, Identifiable {
    case paper, cobalt, noir, sunset, poster, lilac, film   // 第一个就是默认主题

    var id: String { rawValue }

    /// 显示在设置页里的名字
    var name: String {
        switch self {
        case .cobalt:  "Cobalt"
        case .paper:   "Paper"
        case .noir:    "Noir"
        case .sunset:  "Sunset"
        case .poster:  "Poster"
        case .lilac:   "Lilac Mist"
        case .film:    "Film"
        }
    }

    /// 浅色背景的主题，系统控件（Tab 栏、列表）要切到浅色模式
    var isLight: Bool { self == .paper || self == .lilac }

    /// 背景：有的是纯色，有的是渐变，所以用 AnyShapeStyle 装起来
    /// （AnyShapeStyle 相当于"颜色或渐变都行"的通用类型）
    var backgroundStyle: AnyShapeStyle {
        switch self {
        case .noir:           AnyShapeStyle(Color.black)
        case .cobalt:
            AnyShapeStyle(LinearGradient(
                colors: [Color(hex: 0x2A4BE6), Color(hex: 0x1630B5)],   // 克莱因蓝
                startPoint: .top, endPoint: .bottom))
        case .paper:          AnyShapeStyle(Color(hex: 0xF2EDE3))
        case .poster:         AnyShapeStyle(Color(hex: 0x0E0E0E))
        case .sunset:
            AnyShapeStyle(LinearGradient(
                colors: [Color(hex: 0x2B1B3D), Color(hex: 0x7A2E4A), Color(hex: 0xE0734A), Color(hex: 0xF2A65A)],
                startPoint: .top, endPoint: .bottom))
        case .lilac:
            AnyShapeStyle(RadialGradient(
                colors: [Color(hex: 0xE9E4F5), Color(hex: 0xC9C3E3), Color(hex: 0x9FA7CF)],
                center: UnitPoint(x: 0.3, y: 0.15), startRadius: 0, endRadius: 700))
        case .film:
            AnyShapeStyle(RadialGradient(
                colors: [Color(hex: 0x2A2420), Color(hex: 0x14110F)],
                center: UnitPoint(x: 0.5, y: 0.4), startRadius: 0, endRadius: 500))
        }
    }

    /// 主文字颜色
    var text: Color {
        switch self {
        case .paper: Color(hex: 0x1B1A17)
        case .lilac: Color(hex: 0x23213A)
        case .film:  Color(hex: 0xEDE6DA)
        default:     .white
        }
    }

    /// 点缀色：按钮、作者名、Tab 选中色
    var accent: Color {
        switch self {
        case .cobalt:  Color(hex: 0xF4F1EA)   // 奶油白
        case .paper:   Color(hex: 0x1B1A17)   // 墨黑
        case .noir:    .white
        case .sunset:  .white
        case .poster:  Color(hex: 0xC6FF3D)   // 荧光绿
        case .lilac:   Color(hex: 0x5B4F9A)   // 深紫
        case .film:    Color(hex: 0xD2452C)   // 胶片红
        }
    }

    /// 次要文字
    var muted: Color {
        switch self {
        case .paper:  Color(hex: 0x6F6A60)
        case .lilac:  Color(hex: 0x23213A).opacity(0.6)
        case .film:   Color(hex: 0xA39886)
        case .sunset: .white.opacity(0.8)
        case .cobalt: .white.opacity(0.7)
        default:      Color(white: 0.6)
        }
    }

    /// 卡片 / 小方块的底色
    var card: Color {
        switch self {
        case .paper:  Color(hex: 0xE8E1D3)
        case .lilac:  .white.opacity(0.45)
        case .sunset: .white.opacity(0.12)
        case .film:   Color(hex: 0x241F1B)
        default:      Color(white: 0.11)
        }
    }


    /// 语录文字是否居中
    var isCentered: Bool { self == .noir || self == .sunset || self == .lilac }

    /// 当前存着的主题（widget 用：它是另一个进程，每次刷新都重新读一遍）
    static var saved: AppTheme {
        AppTheme(rawValue: Shared.defaults.string(forKey: ThemeStore.key) ?? "") ?? .paper   // 没选过就用 Paper
    }

    /// 语录字体。size 是基准字号，壁纸会传一个大很多的数
    func quoteFont(size: CGFloat) -> Font {
        switch self {
        case .paper:  .system(size: size, weight: .regular, design: .serif).italic()
        case .poster: .system(size: size * 1.1, weight: .heavy)
        default:      .system(size: size, weight: .regular, design: .serif)
        }
    }
}

// MARK: - 当前选中的主题（全局 store）

/// @Observable：任何 View 只要在 body 里读过 theme，主题一换就会自动重画
/// 相当于 Zustand 的 useStore(s => s.theme)
@Observable
final class ThemeStore {
    static let shared = ThemeStore()
    static let key = "appTheme"

    private(set) var theme: AppTheme = .saved

    func select(_ newTheme: AppTheme) {
        theme = newTheme
        Shared.defaults.set(newTheme.rawValue, forKey: Self.key)   // 存到 App Group，widget 也能读
    }
}

// MARK: - 快捷入口：其他文件继续写 Theme.accent，不用改

enum Theme {
    static var current: AppTheme { ThemeStore.shared.theme }

    /// 页面背景（是一个 View，可以 .ignoresSafeArea()）
    static var background: some View { Rectangle().fill(current.backgroundStyle) }
    static var card: Color { current.card }
    static var accent: Color { current.accent }
    static var muted: Color { current.muted }
    static var text: Color { current.text }
}

// MARK: - 小工具：用 0xRRGGBB 写颜色，和 CSS 的 #RRGGBB 一样

extension Color {
    init(hex: UInt32) {
        self.init(red:   Double((hex >> 16) & 0xFF) / 255,
                  green: Double((hex >> 8) & 0xFF) / 255,
                  blue:  Double(hex & 0xFF) / 255)
    }
}
