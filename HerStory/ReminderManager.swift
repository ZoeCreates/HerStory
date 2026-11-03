//
//  ReminderManager.swift
//  HerStory
//

import SwiftUI
import UserNotifications

/// 负责"每日语录提醒"：本地通知，不需要服务器
enum ReminderManager {
    // 存在 App Group 里的设置项的 key
    static let enabledKey = "reminderEnabled"
    static let hourKey = "reminderHour"
    static let minuteKey = "reminderMinute"

    /// iOS 最多同时预约 64 条通知，我们一次排 30 天
    private static let daysAhead = 30

    /// 第一次打开提醒时，弹出系统的权限请求
    static func requestPermission() async -> Bool {
        do {
            return try await UNUserNotificationCenter.current()
                .requestAuthorization(options: [.alert, .sound])
        } catch {
            return false
        }
    }

    /// 清空旧的提醒，按当前设置重新排未来 30 天
    /// 在这些时候调用：打开/关闭提醒、改时间、改主题、App 回到前台
    static func reschedule() {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()

        let defaults = Shared.defaults
        guard defaults.bool(forKey: enabledKey) else { return }   // 没开提醒就到此为止

        let hour = defaults.object(forKey: hourKey) as? Int ?? 8
        let minute = defaults.object(forKey: minuteKey) as? Int ?? 0
        let topics = Topic.parse(defaults.string(forKey: "selectedTopics") ?? "")

        let calendar = Calendar.current
        let today = calendar.startOfDay(for: .now)

        for offset in 0..<daysAhead {
            guard let day = calendar.date(byAdding: .day, value: offset, to: today) else { continue }

            var components = calendar.dateComponents([.year, .month, .day], from: day)
            components.hour = hour
            components.minute = minute

            // 今天的提醒时间如果已经过了，就跳过今天
            guard let fireDate = calendar.date(from: components), fireDate > .now else { continue }

            // 和今日页、widget 用同一个函数挑句子，所以那天推送的就是那天的语录
            let quote = QuoteLibrary.today(day, topics: topics)

            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            let request = UNNotificationRequest(identifier: "daily-\(offset)",
                                                content: content(for: quote),
                                                trigger: trigger)
            center.add(request, withCompletionHandler: nil)
        }
    }

    /// 5 秒后发一条测试通知，方便在模拟器里看效果
    static func sendTest() {
        let topics = Topic.parse(Shared.defaults.string(forKey: "selectedTopics") ?? "")
        let quote = QuoteLibrary.today(.now, topics: topics)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "test",
                                            content: content(for: quote),
                                            trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

    /// 通知长什么样
    private static func content(for quote: Quote) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "Today's quote · \(quote.author)"
        content.body = quote.text
        content.sound = .default
        return content
    }
}

/// iOS 默认在 App 打开时不显示通知横幅；这个 delegate 让 App 在前台时也能看到
final class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        [.banner, .sound]
    }
}
