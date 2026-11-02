//
//  QuoteLibrary.swift
//  HerStory
//
//  Created by Zi Xia on 11/2/26.
//

import Foundation

enum QuoteLibrary {
    static let all: [Quote] = [
        Quote(id: 1,
              text: "You must do the thing you think you cannot do.",
              author: "Eleanor Roosevelt",
              role: "First Lady & human rights advocate",
              source: "You Learn by Living (1960)",
              topics: [.courage, .confidence]),
        Quote(id: 2,
              text: "One child, one teacher, one book, one pen can change the world.",
              author: "Malala Yousafzai",
              role: "Nobel Peace Prize laureate",
              source: "Speech at the UN Youth Assembly (2013)",
              topics: [.study, .courage]),
        Quote(id: 3,
              text: "Fight for the things that you care about, but do it in a way that will lead others to join you.",
              author: "Ruth Bader Ginsburg",
              role: "U.S. Supreme Court Justice",
              source: "Radcliffe Day, Harvard (2015)",
              topics: [.career, .courage]),
        Quote(id: 4,
              text: "Pressure is a privilege.",
              author: "Billie Jean King",
              role: "Tennis champion & equality advocate",
              source: "Pressure Is a Privilege (2008)",
              topics: [.resilience, .confidence]),
    ]
    
    static func today(_ date: Date = .now, topics: Set<Topic> = []) -> Quote {
        let matching = all.filter { !topics.isDisjoint(with: $0.topics) }
        let pool = matching.isEmpty ? all : matching
        let day = Calendar.current.ordinality(of: .day, in: .era, for: date) ?? 0
        return pool[day % pool.count]
    }
    
}

