//
//  SampleSnapshotTests.swift
//  Prototype House iOS Tests
//
//  Created by Felipe Espinoza on 25/09/2023.
//

import Foundation
@testable import Prototype_House_iOS
import SnapshotTesting
import SwiftUI
import XCTest

class SampleSnapshotTests: XCTestCase {
    func testOutlineView() throws {
        let rootView = NavigationStack {
            OutlineGroupExperimentsView()
        }

        assertSnapshot(of: rootView, on: .iPhone, in: .lightMode)
        assertSnapshot(of: rootView, on: .iPad(orientation: .landscape), in: .darkMode)
    }
}
