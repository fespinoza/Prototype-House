import ActivityKit
import WidgetKit
import SwiftUI
import PrototypeActivities

struct GymClassLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: NeoPrototypeActivity.self) { context in
            VStack {
                Text("Hello \(context.state.participationState.description)")
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
                    Text("Bottom \(context.state.participationState.description)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.participationState.description)")
            } minimal: {
                Text(context.state.participationState.description)
            }
        }
    }
}
