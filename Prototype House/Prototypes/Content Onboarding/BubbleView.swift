//
//  BubbleView.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 28/02/2023.
//

import SwiftUI

struct BubbleView<Content: View>: View {
    @State var edge: TailEdge = .topTrailing
    @State var tailXOffset: CGFloat = 16
    @ViewBuilder var content: Content

    private let backgroundColor: Color = .white
    private let textColor: Color = .black
    private let tailSize: CGFloat = 26
    private let tailYOffset: CGFloat = 8

    var body: some View {
        VStack(alignment: horizontalAlignment, spacing: 0) {
            if edge.isTop { tail }

            bubbleContent

            if edge.isBottom { tail }
        }
    }

    var bubbleContent: some View {
        VStack(alignment: .leading) {
            content
        }
        .foregroundColor(textColor)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(backgroundColor)
        .cornerRadius(8)
    }

    var tail: some View {
        BubbleArrowAlt()
            .foregroundColor(backgroundColor)
            .frame(size: tailSize)
            .rotationEffect(angle)
            .offset(x: tailXOffset * xOffsetMultiplier, y: tailYOffset * yOffsetMultiplier)
    }

    var horizontalAlignment: HorizontalAlignment {
        switch edge {
        case .topLeading, .bottomLeading: return .leading
        case .topTrailing, .bottomTrailing: return .trailing
        }
    }

    var xOffsetMultiplier: CGFloat {
        switch edge {
        case .topLeading, .bottomLeading: return 1
        case .topTrailing, .bottomTrailing: return -1
        }
    }

    var yOffsetMultiplier: CGFloat {
        switch edge {
        case .topLeading, .topTrailing: return 1
        case .bottomLeading, .bottomTrailing: return -1
        }
    }

    var angle: Angle {
        switch edge {
        case .topLeading: return .degrees(270)
        case .topTrailing: return .degrees(180)
        case .bottomLeading: return .degrees(0)
        case .bottomTrailing: return .degrees(90)
        }
    }

    enum TailEdge {
        case topTrailing
        case topLeading
        case bottomLeading
        case bottomTrailing

        var isTop: Bool {
            switch self {
            case .topLeading, .topTrailing: return true
            default: return false
            }
        }

        var isBottom: Bool { !isTop }
    }
}

struct BubbleView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 60) {
            Spacer()

            BubbleView(edge: .topLeading) {
                Text("Sample topLeading")
            }

            BubbleView(edge: .topTrailing) {
                Text("Sample topTrailing")
            }

            BubbleView(edge: .bottomLeading) {
                Text("Sample bottomLeading")
            }

            BubbleView(edge: .bottomTrailing) {
                Text("Sample bottomTrailing")
            }

            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.gray)
    }
}
