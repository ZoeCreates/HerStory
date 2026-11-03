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
        let theme = Theme.current   // 读了主题，换主题时整个 App 自动重画

        Group {
            switch step {
            case 0:  WelcomeView().onTapGesture { step = 1 }
            case 1:  TopicPickerView { step = 2 }
            default: MainTabView()
            }
        }
        .foregroundStyle(theme.text)                               // 默认文字颜色
        .tint(theme.accent)                                        // 默认按钮颜色
        .preferredColorScheme(theme.isLight ? .light : .dark)      // 浅色主题用浅色模式
    }
}
