//
//  SampleSnapshotTests.swift
//  Prototype House iOS Tests
//
//  Created by Felipe Espinoza on 25/09/2023.
//

import Foundation
import SnapshotTesting
import SwiftUI
import XCTest
@testable import Prototype_House_iOS

class SampleSnapshotTests: XCTestCase {
    func testOutlineView() {
        let rootView = NavigationView {
            OutlineGroupExperimentsView()
        }

        assertSnapshots(
            of: rootView,
            as: [
                "lightImage": .image(traits: UITraitCollection(userInterfaceStyle: .light)),
                "darkImage": .image(traits: UITraitCollection(userInterfaceStyle: .dark))
            ]
        )
    }
}
