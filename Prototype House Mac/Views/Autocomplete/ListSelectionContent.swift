//
//  ListSelectionExample.swift
//  Prototype House Mac
//
//  Created by Felipe Espinoza on 04/06/2024.
//

import SwiftUI

struct ListSelectionContent: View {
    @Binding private var selectedCell: Int?
    var onReturn: ((Int?) -> Void)?

    let elements = Array(0 ..< 7)

    var body: some View {
        VStack(spacing: 0) {
            ForEach(elements, id: \.self) { index in
                Cell(index: index, isSelected: index == selectedCell)
                    .onTapGesture {
                        selectedCell = index
                    }
            }
        }
        .focusSection()
        .focusable()
        .focusEffectDisabled()
        .onKeyPress(KeyEquivalent.return, action: {
            onReturn?(selectedCell)
            return .handled
        })
        .onMoveCommand(perform: { direction in
            switch direction {
            case .up:
                if let currentValue = selectedCell, currentValue - 1 >= 0 {
                    selectedCell = currentValue - 1
                } else {
                    selectedCell = elements.count - 1
                }
            case .down:
                if let currentValue = selectedCell, currentValue + 1 < elements.count {
                    selectedCell = currentValue + 1
                } else {
                    selectedCell = 0
                }
            case .right, .left:
                break
            @unknown default:
                break
            }
        })
        .padding()
    }

    struct Cell: View {
        let index: Int
        let isSelected: Bool

        @State private var isTapped: Bool = false

        var body: some View {
            Text("Hello World #\(index + 1)")
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
                .background(isSelected ? AnyShapeStyle(.selection) : AnyShapeStyle(.clear))
                .padding(.bottom, 4)
                .onKeyPress(KeyEquivalent.space, phases: .down) { _ in
                    print("tapped \(index)")
                    isTapped = true
                    return .handled
                }
                .onKeyPress(KeyEquivalent.space, phases: .up) { _ in
                    isTapped = false
                    return .handled
                }
                .contentShape(Rectangle())
        }
    }

}

#Preview {
    ListSelectionExample()
        .frame(width: 300, height: 500)
}
