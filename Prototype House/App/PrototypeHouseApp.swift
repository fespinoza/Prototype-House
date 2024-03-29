//
//  Prototype_HouseApp.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 10/12/2021.
//

import SwiftUI

@main
struct PrototypeHouseApp: App {
    var body: some Scene {
        WindowGroup {
            if #available(iOS 17.0, *) {
                LoginFormView()
            } else {
                LocalizationFromPackage()
            }
        }
    }
}

struct ViewControllerRepresentable<Controller: UIViewController>: UIViewControllerRepresentable {
    let controller: Controller

    init(_ factory: () -> Controller) {
        self.controller = factory()
    }

    func makeUIViewController(context: Context) -> Controller { controller }
    func updateUIViewController(_ uiViewController: Controller, context: Context) {}
}
