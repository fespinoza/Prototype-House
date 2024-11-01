//
//  Prototype_House_Widgets.swift
//  Prototype House Widgets
//
//  Created by Felipe Espinoza on 03/10/2024.
//

import WidgetKit
import SwiftUI

struct HelloProvider: TimelineProvider {
    func placeholder(in context: Context) -> HelloSimpleEntry {
        HelloSimpleEntry(date: Date(), emoji: "😀")
    }

    func getSnapshot(in context: Context, completion: @escaping (HelloSimpleEntry) -> ()) {
        let entry = HelloSimpleEntry(date: Date(), emoji: "😀")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [HelloSimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = HelloSimpleEntry(date: entryDate, emoji: "😀")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct HelloSimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

struct HelloWidgetEntryView : View {
    var entry: HelloProvider.Entry

    var body: some View {
        VStack {
            Text("Time:")
            Text(entry.date, style: .time)

            Text("Emoji:")
            Text(entry.emoji)
        }
    }
}

struct HelloWidget: Widget {
    let kind: String = "HelloWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: HelloProvider()) { entry in
            if #available(iOS 17.0, *) {
                HelloWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                HelloWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    HelloWidget()
} timeline: {
    HelloSimpleEntry(date: .now, emoji: "😀")
    HelloSimpleEntry(date: .now, emoji: "🤩")
}
