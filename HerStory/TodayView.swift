import SwiftUI

struct TodayView: View {
    var date: Date = .now     // 有默认值的 prop，相当于可选 prop
    @AppStorage("selectedTopics", store: Shared.defaults) private var selectedRaw = ""
    
    var body: some View {
        ZStack {
            Color(red: 0.96, green: 0.93, blue: 0.88).ignoresSafeArea()
            VStack(spacing: 24) {
                Text("TODAY’S QUOTE").font(.caption).tracking(3)
                QuoteCard(quote: QuoteLibrary.today(date, topics: Topic.parse(selectedRaw)))
                                                        
            }
            .padding(24)
        }
    }
}

#Preview("Today") { TodayView() }
#Preview("Tomorrow") { TodayView(date: .now.addingTimeInterval(86400)) }
