//
//  PrototypeHouseApp.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 10/12/2021.
//

import SwiftUI

extension Data {
    struct HexEncodingOptions: OptionSet {
        let rawValue: Int
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
    }

    func hexEncodedString(options: HexEncodingOptions = []) -> String {
        let format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
        return self.map { String(format: format, $0) }.joined()
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        print(#function)
        UIApplication.shared.registerForRemoteNotifications()

        LiveActivityStarterView.tokensForStartingLiveActivity()
        LiveActivityStarterView.listenForActivityTokenUpdates()

        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("------- PUSH TOKEN: \(deviceToken.hexEncodedString())")
    }
}

@main
struct PrototypeHouseApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ScrollableDemoList()
            }
        }
    }

    @ViewBuilder var liveActivities: some View {
        if #available(iOS 17.0, *) {
            LiveActivityStarterView()
                .task { await setupPushNotifications() }
        } else {
            LocalizationFromPackage()
        }
    }

    func setupPushNotifications() async {
        do {
            let result = try await UNUserNotificationCenter
                .current()
                .requestAuthorization(options: [.alert, .badge, .sound])
            print("Notifications enabled \(result)")
        } catch {
            print(error)
        }
    }
}

struct ViewControllerRepresentable<Controller: UIViewController>: UIViewControllerRepresentable {
    let controller: Controller

    init(_ factory: () -> Controller) {
        controller = factory()
    }

    func makeUIViewController(context _: Context) -> Controller { controller }
    func updateUIViewController(_: Controller, context _: Context) {}
}
