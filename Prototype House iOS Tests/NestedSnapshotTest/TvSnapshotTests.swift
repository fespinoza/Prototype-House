//
//  TvSnapshotTests.swift
//  Prototype House iOS Tests
//
//  Created by Felipe Espinoza on 25/09/2023.
//

import Foundation
@testable import Prototype_House_iOS
import SnapshotTesting
import SwiftUI
import XCTest

class TvSnapshotTests: XCTestCase {
    func testTvContentView() throws {
        let rootView = NavigationStack {
            ScrollView {
                TvAppContentSwiftUIView(viewData: .tedLasso)
            }
        }

        assertSnapshot(of: rootView, on: .iPhone, in: .darkMode)
    }
}
