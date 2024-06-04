//
//  LinearEquationTests.swift
//  Prototype House iOS Tests
//
//  Created by Felipe Espinoza on 25/09/2023.
//

import Foundation
@testable import Prototype_House_iOS
import XCTest

class LinearEquationTests: XCTestCase {
    func testSampleEquation() {
        let linearEquation = LinearEquation.linearEquation(fromPoint: .init(x: 0, y: 10), toPoint: .init(x: 100, y: 40))

        let result = Int(linearEquation(100))

        XCTAssertEqual(result, 40)
    }
}
