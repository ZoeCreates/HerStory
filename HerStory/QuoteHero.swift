//
//  QuoteHero.swift
//  HerStory
//
//  全屏大字的语录排版。今日页（Classic 以外的主题）、壁纸、主题预览都用它。
//  theme 和 scale 都是 props：壁纸传 scale: 2.4，主题缩略图传 scale: 0.5
//

import SwiftUI

struct QuoteHero: View {
    let quote: Quote
    var theme: AppTheme = Theme.current
    var scale: CGFloat = 1
    var showSource = true

    private var alignment: HorizontalAlignment { theme.isCentered ? .center : .leading }

    var body: some View {
        VStack(alignment: alignment, spacing: 22 * scale) {
            if theme == .film {                       // 胶片风格的小红点
                Circle()
                    .fill(theme.accent)
                    .frame(width: 8 * scale, height: 8 * scale)
            }

            quoteText
                .font(theme.quoteFont(size: 32 * scale))
                .lineSpacing(theme == .poster ? 0 : 4 * scale)
                .multilineTextAlignment(theme.isCentered ? .center : .leading)
                .foregroundStyle(theme.text)
                .minimumScaleFactor(0.5)

            authorBlock
        }
        .frame(maxWidth: .infinity, alignment: theme.isCentered ? .center : .leading)
    }

    /// 语录本身：纸质风格加引号，海报风格把最长的单词高亮
    private var quoteText: Text {
        switch theme {
        case .paper:  Text("“\(quote.text)”")
        case .poster: Text(Self.highlightLongestWord(in: quote.text, color: theme.accent))
        default:      Text(quote.text)
        }
    }

    /// 作者那一行：每种风格长得不一样
    @ViewBuilder private var authorBlock: some View {
        switch theme {
        case .paper:
            VStack(alignment: .leading, spacing: 4 * scale) {
                Text(quote.author.uppercased())
                    .font(.system(size: 12 * scale, weight: .semibold))
                    .tracking(2.5 * scale)
                    .foregroundStyle(theme.text)
                if showSource { sourceText }
            }
        case .poster:
            HStack(spacing: 10 * scale) {
                Rectangle()
                    .fill(theme.accent)
                    .frame(width: 22 * scale, height: 2 * scale)
                Text(quote.author)
                    .font(.system(size: 14 * scale, weight: .semibold))
                    .foregroundStyle(theme.text)
            }
        case .lilac:
            Text(quote.author)
                .font(.system(size: 13 * scale))
                .foregroundStyle(theme.text)
                .padding(.horizontal, 14 * scale)
                .padding(.vertical, 6 * scale)
                .background(.white.opacity(0.45), in: Capsule())
        case .noir:
            Text("— \(quote.author)")
                .font(.system(size: 14 * scale))
                .foregroundStyle(theme.muted)
        default:   // cobalt, sunset, film
            VStack(alignment: alignment, spacing: 4 * scale) {
                Text(quote.author)
                    .font(.system(size: 15 * scale, weight: .semibold))
                    .foregroundStyle(theme.muted)
                if showSource && theme != .sunset { sourceText }
            }
        }
    }

    private var sourceText: some View {
        Text(quote.source)
            .font(.system(size: 13 * scale, design: .serif).italic())
            .foregroundStyle(theme.muted.opacity(0.8))
    }

    /// 找出最长的单词，给它上色（AttributedString 相当于带样式的字符串）
    static func highlightLongestWord(in text: String, color: Color) -> AttributedString {
        var result = AttributedString(text)
        let words = text.split(separator: " ")
            .map { $0.trimmingCharacters(in: .punctuationCharacters) }
        if let longest = words.max(by: { $0.count < $1.count }),
           let range = result.range(of: longest) {
            result[range].foregroundColor = color
        }
        return result
    }
}

#Preview("All themes") {
    ScrollView {
        VStack(spacing: 12) {
            ForEach(AppTheme.allCases) { theme in
                QuoteHero(quote: QuoteLibrary.all[0], theme: theme)
                    .padding(28)
                    .background(theme.backgroundStyle)
            }
        }
    }
}
