//
//  TriangleShape.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 28/02/2023.
//

import SwiftUI

// Example of a custom shape
struct BubbleArrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX / 2, y: rect.maxY))

        return path
    }
}

struct BubbleArrowAlt: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX, y: 0))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))

        return path
    }
}

struct TriangleShape: View {
    var body: some View {
        VStack {
            Text("Hi")

            BubbleArrowAlt()
                .frame(size: 30)

            ZStack {
                Color.blue

                BubbleArrow()
                    .foregroundColor(.red)
            }
            .frame(width: 100, height: 100)
        }
    }
}

struct TriangleShape_Previews: PreviewProvider {
    static var previews: some View {
        TriangleShape()
    }
}
