//
//  FavoritesStore.swift
//  HerStory
//
//  Created by Zi Xia on 11/2/26.
//

import Foundation
import Observation

@Observable
final class FavoritesStore {
    private(set) var ids: [Int]

    init() {
        ids = Shared.defaults.array(forKey: "favoriteIDs") as? [Int] ?? []
    }

    func isSaved(_ quote: Quote) -> Bool {
        ids.contains(quote.id)
    }

    func toggle(_ quote: Quote) {
        if let index = ids.firstIndex(of: quote.id) {
            ids.remove(at: index)
        } else {
            ids.insert(quote.id, at: 0)       // 新收藏的排在最前面
        }
        Shared.defaults.set(ids, forKey: "favoriteIDs")
    }

    var quotes: [Quote] {
        ids.compactMap { id in QuoteLibrary.all.first { $0.id == id } }
    }
}
