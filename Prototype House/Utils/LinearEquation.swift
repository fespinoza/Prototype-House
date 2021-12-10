//
//  LinearEquation.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 10/12/2021.
//

import CoreGraphics

struct LinearEquation {
    /// Creates a linear equation that applies only in the defined segment
    /// between the two points
    ///
    /// Example:
    ///
    ///  If we want to drive the alpha value of a view when the scroll is in positions 100 and 150 we would do
    ///
    ///   Then
    ///   ```swift
    ///    let alphaForOffset = segmentedLinearEquation(fromPoint: (x: 100, y: 0), toPoint: (x: 150, y: 1))
    ///
    ///    alphaForOffset(0) // returns 0
    ///    alphaForOffset(99) // returns 0
    ///    alphaForOffset(110) // returns value between 0 and 1
    ///    alphaForOffset(150) // returns 1
    ///   ```
    ///
    ///   With this we can safely manipulate the alpha value in the right range
    ///
    /// - Parameters:
    ///   - fromPoint: initial segment
    ///   - toPoint: final segment
    /// - Returns: returns a function that takes a value and calculates
    ///            the appropriate linear value if its in the range
    static func segmentedLinearEquation(fromPoint: CGPoint, toPoint: CGPoint) -> (CGFloat) -> CGFloat {
        let valueEquation = linearEquation(fromPoint: fromPoint, toPoint: toPoint)
        return { offset in
            if offset < fromPoint.x {
                return fromPoint.y

            } else if offset > toPoint.x {
                return toPoint.y

            } else {
                return valueEquation(offset)
            }
        }
    }

    /// Creates a linear equation function between the given 2 points
    ///
    /// - Returns: a linear equation function with the form `y(x) = m * x + n`
    static func linearEquation(fromPoint: CGPoint, toPoint: CGPoint) -> (CGFloat) -> CGFloat {
        let pendant: CGFloat = (fromPoint.y - toPoint.y) / (fromPoint.x - toPoint.x)
        let nIntersection: CGFloat = fromPoint.y - pendant * fromPoint.x

        return { xInput in
            xInput * pendant + nIntersection
        }
    }
}
