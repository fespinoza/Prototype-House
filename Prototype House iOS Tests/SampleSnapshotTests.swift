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
    func testOutlineView() throws {
        let rootView = NavigationStack {
            OutlineGroupExperimentsView()
        }

        assertSnapshot(view: rootView, on: .iPhone, with: .lightMode)
        assertSnapshot(view: rootView, on: .iPad(orientation: .landscape), with: .darkMode)
    }
}
