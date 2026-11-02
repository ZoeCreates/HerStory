//
//  ContentView.swift
//  HerStory
//
//  Created by Zi Xia on 11/2/26.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("onboardingStep") private var step = 0

    var body: some View {
        switch step {
        case 0:  WelcomeView().onTapGesture { step = 1 }
        case 1:  TopicPickerView { step = 2 }
        default: MainTabView()
        }
    }
}
