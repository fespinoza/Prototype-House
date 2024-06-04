//
//  PrototypeHouseMacApp.swift
//  Prototype House Mac
//
//  Created by Felipe Espinoza on 03/01/2022.
//

import SwiftUI

@main
struct PrototypeHouseMacApp: App {
    var body: some Scene {
        WindowGroup {
            SFSymbolsReplica()
        }
        .windowToolbarStyle(.unified)
//        .windowStyle(.titleBar)
        .commands {
            SidebarCommands()
        }
    }
}
