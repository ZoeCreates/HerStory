import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack {
            Theme.background
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Text("HER STORY")
                    .font(.caption)
                    .tracking(4)

                Spacer()

                Text("Meet her story.\nOne minute a day.")
                    .font(
                        .system(
                            size: 38,
                            weight: .medium,
                            design: .serif
                        )
                    )
                    .multilineTextAlignment(.center)

                Text("Discover the women who inspire what's possible.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)

                Spacer()

                Text("A moment just for you")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            .padding(32)
        }
    }
}

#Preview {
    WelcomeView()
}
//
//  WelcomeView.swift
//  HerStory
//
//  Created by Zi Xia on 10/1/26.
//

