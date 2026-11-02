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

struct Quote: Identifiable {
    let id: Int
    let text: String
    let author: String
    let role: String
    let source: String
    let topics: [Topic]
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
