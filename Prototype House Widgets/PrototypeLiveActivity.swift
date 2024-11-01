//
//  Prototype_House_WidgetsLiveActivity.swift
//  Prototype House Widgets
//
//  Created by Felipe Espinoza on 03/10/2024.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct PrototypeActivity: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct PrototypeLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: PrototypeActivity.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension PrototypeActivity {
    fileprivate static var preview: PrototypeActivity {
        PrototypeActivity(name: "World")
    }
}

extension PrototypeActivity.ContentState {
    fileprivate static var smiley: PrototypeActivity.ContentState {
        PrototypeActivity.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: PrototypeActivity.ContentState {
         PrototypeActivity.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: PrototypeActivity.preview) {
   PrototypeLiveActivity()
} contentStates: {
    PrototypeActivity.ContentState.smiley
    PrototypeActivity.ContentState.starEyes
}
