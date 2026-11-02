import WidgetKit
import SwiftUI

// ① Entry：某一个时间点要显示的数据
struct QuoteEntry: TimelineEntry {
    let date: Date
    let quote: Quote
}

// ② Provider：告诉系统什么时候显示什么
struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> QuoteEntry {
        QuoteEntry(date: .now, quote: QuoteLibrary.all[0])
    }

    func getSnapshot(in context: Context, completion: @escaping (QuoteEntry) -> Void) {
        let raw = Shared.defaults.string(forKey: "selectedTopics") ?? ""
        completion(QuoteEntry(date: .now, quote: QuoteLibrary.today(topics: Topic.parse(raw))))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<QuoteEntry>) -> Void) {
        let now = Date.now
        let raw = Shared.defaults.string(forKey: "selectedTopics") ?? ""
        let entry = QuoteEntry(date: now, quote: QuoteLibrary.today(now, topics: Topic.parse(raw)))
        let tomorrow = Calendar.current.startOfDay(for: now.addingTimeInterval(86400))
        completion(Timeline(entries: [entry], policy: .after(tomorrow)))
    }
}

// ③ View：widget 长什么样，根据尺寸显示不同布局
struct HerStoryWidgetView: View {
    @Environment(\.widgetFamily) private var family
    let entry: QuoteEntry

    var body: some View {
        switch family {
        case .accessoryRectangular:          // 锁屏：长方形
            VStack(alignment: .leading, spacing: 2) {
                Text(entry.quote.text)
                    .font(.headline)
                    .lineLimit(3)
                    .minimumScaleFactor(0.7)
                Text("— \(entry.quote.author)")
                    .font(.caption2)
            }
        case .accessoryInline:               // 锁屏：时间上方的一行字
            Text("“\(entry.quote.text)”")
        default:                             // 主屏幕：小方块和中长条
            VStack(alignment: .leading, spacing: 8) {
                Text(entry.quote.text)
                    .font(.system(.body, design: .serif))
                    .minimumScaleFactor(0.6)
                Spacer(minLength: 0)
                Text("— \(entry.quote.author)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

// ④ Widget 本体：把以上三部分组装起来
struct HerStoryWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "HerStoryWidget", provider: Provider()) { entry in
            HerStoryWidgetView(entry: entry)
                .containerBackground(Color(red: 0.96, green: 0.93, blue: 0.88), for: .widget)
        }
        .configurationDisplayName("Daily Quote")
        .description("A quote from an inspiring woman, every day.")
        .supportedFamilies([.accessoryRectangular, .accessoryInline, .systemSmall, .systemMedium])
    }
}

#Preview("Lock Screen", as: .accessoryRectangular) {
    HerStoryWidget()
} timeline: {
    QuoteEntry(date: .now, quote: QuoteLibrary.all[0])
}

#Preview("Home", as: .systemSmall) {
    HerStoryWidget()
} timeline: {
    QuoteEntry(date: .now, quote: QuoteLibrary.all[3])
}
