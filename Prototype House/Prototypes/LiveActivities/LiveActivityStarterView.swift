import SwiftUI
import PrototypeActivities
import ActivityKit

struct LiveActivityStarterView: View {
    @State var activity: Activity<NeoPrototypeActivity>?

    var body: some View {
        VStack(spacing: 16) {
            Text("Live Activity").font(.largeTitle.bold())
                .padding(.bottom, 16)

            Button("Start", action: startActivity)
            Button("Update", action: updateActivity)
            Button("Finish", action: finishActivity)

            Spacer()
        }
        .buttonStyle(.borderedProminent)
    }

    static func tokensForStartingLiveActivity() {
        Task {
            for await pushToken in Activity<NeoPrototypeActivity>.pushToStartTokenUpdates {
                let pushTokenString = pushToken.reduce("") { $0 + String(format: "%02x", $1) }
                print("=== Our push token is: \(pushTokenString)")
            }
        }
    }

    static func listenForActivityTokenUpdates() {
        Task {
            for await activityData in Activity<NeoPrototypeActivity>.activityUpdates {
                Task {
                    for await tokenData in activityData.pushTokenUpdates {
                        let token = tokenData.map {String(format: "%02x", $0)}.joined()
                        print("Live activity push token: \(token)")
                    }
                }
            }
        }
    }

    func startActivity() {
        Task {
            let classInfo = NeoPrototypeActivity(
                classId: "1234",
                name: "Love2Dance",
                room: "room 1",
//                startTime: "21/10/2024"
                startTime: Date().addingTimeInterval(30.minutes)
            )
            let initialState = NeoPrototypeActivity.ContentState(
                participationState: .upcoming
            )

            let content = ActivityContent(state: initialState, staleDate: nil)

            do {
                activity = try Activity.request(
                    attributes: classInfo,
                    content: content,
                    pushType: .token
                )
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func updateActivity() {
        Task { @MainActor in
            guard let activity else {
                print("---------- no activity to update")
                return
            }

            let contentState = NeoPrototypeActivity.ContentState(
                participationState: .checkedIn
            )

            let alertConfig = AlertConfiguration(
                title: "Checked in!",
                body: "You spot is secured, now you can check your ticket in the app",
                sound: .default
            )

            await activity.update(
                ActivityContent<NeoPrototypeActivity.ContentState>.init(
                    state: contentState,
                    staleDate: nil
                ),
                alertConfiguration: alertConfig
            )
        }
    }

    func finishActivity() {
        Task { @MainActor in
            guard let activity else {
                print("---------- no activity to end")
                return
            }

            let finalContent = NeoPrototypeActivity.ContentState(
                participationState: .classCompleted
            )
            let dismissalPolicy: ActivityUIDismissalPolicy = .default

            await activity.end(
                ActivityContent(state: finalContent, staleDate: nil),
                dismissalPolicy: dismissalPolicy
            )
        }
    }
}

#Preview {
    LiveActivityStarterView()
}

extension Int {
    var minutes: TimeInterval { TimeInterval(self) * 60 }
}
