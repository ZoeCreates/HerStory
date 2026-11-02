//
//  SavedView.swift
//  HerStory
//
//  Created by Zi Xia on 11/2/26.
//

import SwiftUI

struct SavedView: View {
    var body: some View {
        ContentUnavailableView("No saved quotes yet",
                               systemImage: "heart",
                               description: Text("Tap the heart on a quote to keep it here."))
    }
}
