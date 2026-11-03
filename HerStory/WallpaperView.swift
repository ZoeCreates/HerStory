//
//  WallpaperView.swift
//  HerStory
//

import SwiftUI

/// 壁纸的样子：按 iPhone 屏幕的像素尺寸设计（1179 × 2556）
/// 上面留出空间给锁屏的时间，语录放在中下部
struct WallpaperView: View {
    let quote: Quote
    var theme: AppTheme = Theme.current   // 壁纸跟着当前主题

    var body: some View {
        ZStack {
            Rectangle().fill(theme.backgroundStyle)

            // 和今日页同一个排版组件，放大 2.4 倍
            QuoteHero(quote: quote, theme: theme, scale: 2.4, showSource: false)
                .padding(.horizontal, 110)
                .padding(.top, 500)          // 给锁屏时间让出位置

            VStack {
                Spacer()
                Text("HER STORY")
                    .font(.system(size: 28, weight: .medium))
                    .tracking(10)
                    .foregroundStyle(theme.text.opacity(0.35))
                    .padding(.bottom, 260)
            }
        }
        .frame(width: 1179, height: 2556)
    }
}

/// 把 WallpaperView "拍照"成一张图片
@MainActor
func renderWallpaper(for quote: Quote) -> UIImage? {
    let renderer = ImageRenderer(content: WallpaperView(quote: quote))
    renderer.scale = 1
    return renderer.uiImage
}

/// 从底部弹出的壁纸预览页：预览 + 保存到相册
struct WallpaperSheet: View {
    let quote: Quote
    @State private var image: UIImage?
    @State private var saved = false
    @Environment(\.dismiss) private var dismiss    // 用来关闭这个 sheet

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                if let image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 28))
                        .overlay(RoundedRectangle(cornerRadius: 28).stroke(.white.opacity(0.15)))
                } else {
                    ProgressView()
                }

                Button {
                    if let image {
                        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                        saved = true
                    }
                } label: {
                    Label(saved ? "Saved to Photos" : "Save to Photos",
                          systemImage: saved ? "checkmark" : "arrow.down.to.line")
                        .font(.headline)
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(saved ? Color.green : Color.white, in: Capsule())
                }
                .disabled(image == nil || saved)
            }
            .padding(24)
            .navigationTitle("Wallpaper")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
            .onAppear {
                image = renderWallpaper(for: quote)
            }
        }
    }
}

#Preview("Wallpaper sheet") {
    WallpaperSheet(quote: QuoteLibrary.all[0])
}
