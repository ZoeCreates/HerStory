//
//  Quote.swift
//  HerStory
//
//  Created by Zi Xia on 11/2/26.
//

import Foundation

enum Topic: String, CaseIterable {
    case confidence, career, study, courage, resilience
}

/// 语录来自哪里：人物名言，还是女性创作者的书 / 影视 / 剧场作品
enum QuoteKind: String, CaseIterable, Identifiable {
    case person, book, film, theatre

    var id: String { rawValue }

    /// 设置页开关上显示的名字
    var label: String {
        switch self {
        case .person:  "People"
        case .book:    "Books"
        case .film:    "Film & TV"
        case .theatre: "Theatre"
        }
    }

    /// 卡片顶部的小标签；人物名言不显示
    var badge: String? {
        switch self {
        case .person:  nil
        case .book:    "BOOK"
        case .film:    "FILM & TV"
        case .theatre: "THEATRE"
        }
    }

    /// SF Symbols 图标名
    var icon: String {
        switch self {
        case .person:  "person"
        case .book:    "books.vertical"
        case .film:    "film"
        case .theatre: "theatermasks"
        }
    }

    /// 用户选的分类存在 App Group 里，key 是 "selectedKinds"，值像 "person,book"
    static let storageKey = "selectedKinds"

    static func parse(_ raw: String) -> Set<QuoteKind> {
        Set(raw.split(separator: ",").compactMap { QuoteKind(rawValue: String($0)) })
    }

    /// 直接从存储里读出用户选的分类（widget 和推送用它）。空 = 全部
    static var saved: Set<QuoteKind> {
        parse(Shared.defaults.string(forKey: storageKey) ?? "")
    }
}

struct Quote: Identifiable {
    let id: Int
    let text: String
    let author: String
    let role: String
    let source: String
    let topics: [Topic]
    // 下面三个有默认值，所以原来的 55 条人物名言不用改
    var kind: QuoteKind = .person
    var work: String? = nil       // 作品名，如 "Jane Eyre"
    var speaker: String? = nil    // 说这句话的角色，如 "Jo March"
}

extension Topic {
    static func parse(_ raw: String) -> Set<Topic> {
        Set(raw.split(separator: ",").compactMap { Topic(rawValue: String($0)) })
    }
}

/// App 和 widget 共用的存储（App Group 里的"公共储物柜"）
enum Shared {
    static let groupID = "group.com.zoe.HerStory"
    static let defaults = UserDefaults(suiteName: groupID)!
}

extension Quote {
    var shareText: String {
        "“\(text)”\n— \(author), \(source)\n\nvia HerStory"
    }

    /// 作者下面那行小字：作品 quote 显示 "from Jane Eyre" 或 "Jo March, in Little Women"
    var displaySource: String {
        guard let work else { return source }
        if let speaker { return "\(speaker), in \(work)" }
        return "from \(work)"
    }

    /// 只有一行位置时用（widget、部分主题）："Charlotte Brontë, Jane Eyre"
    var credit: String {
        guard let work else { return author }
        return "\(author), \(work)"
    }

    /// Read / Watch 按钮的链接：根据作品名现算出来，不用每条手写
    var readLink: URL? {
        guard let work else { return nil }
        var components: URLComponents?
        switch kind {
        case .person:
            return nil
        case .film:     // Rotten Tomatoes：影评和评分
            components = URLComponents(string: "https://www.rottentomatoes.com/search")
            components?.queryItems = [URLQueryItem(name: "search", value: work)]
        case .book, .theatre:   // Goodreads：书评和评分；很多剧本也出版成书
            components = URLComponents(string: "https://www.goodreads.com/search")
            components?.queryItems = [URLQueryItem(name: "q", value: "\(work) \(author)")]
        }
        return components?.url
    }

    var readLabel: String { kind == .film ? "Watch" : "Read" }
}
