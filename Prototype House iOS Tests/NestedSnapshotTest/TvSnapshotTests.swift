//
//  TvSnapshotTests.swift
//  Prototype House iOS Tests
//
//  Created by Felipe Espinoza on 25/09/2023.
//

import Foundation
import SnapshotTesting
import SwiftUI
import XCTest
@testable import Prototype_House_iOS

class TvSnapshotTests: XCTestCase {
    func testTvContentView() throws {
        let rootView = NavigationStack {
            ScrollView {
                TvAppContentSwiftUIView(viewData: .tedLasso)
            }
        }
        
        assertSnapshot(view: rootView, on: .iPhone, with: .darkMode)
    }
}
