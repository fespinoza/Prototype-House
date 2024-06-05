//
//  ListFocusExample.swift
//  Prototype House Mac
//
//  Created by Felipe Espinoza on 04/06/2024.
//

import SwiftUI

struct ListFocusExample: View {
    @FocusState private var focusedCell: Int?

    let elements = Array(0 ..< 7)

    var body: some View {
        VStack {
            VStack {
                ForEach(elements, id: \.self) { index in
                    Cell(index: index)
                        .focused($focusedCell, equals: index)
                }
            }
            .onMoveCommand(perform: { direction in
                guard let currentValue = focusedCell else { return }

                switch direction {
                case .up:
                    if currentValue - 1 >= 0 {
                        focusedCell = currentValue - 1
                    } else {
                        focusedCell = elements.count - 1
                    }
                case .down:
                    if currentValue + 1 < elements.count {
                        focusedCell = currentValue + 1
                    } else {
                        focusedCell = 0
                    }
                case .right, .left:
                    break
                @unknown default:
                    break
                }
            })
//            .onKeyPress(KeyEquivalent.downArrow, action: {
//                if let focusedCell {
//                    if focusedCell + 1 < elements.count {
//                        self.focusedCell = focusedCell + 1
//                    } else {
//                        self.focusedCell = 0
//                    }
//                }
//                return .handled
//            })
//            .onKeyPress(KeyEquivalent.upArrow, action: {
//                if let focusedCell {
//                    if focusedCell - 1 >= 0 {
//                        self.focusedCell = focusedCell - 1
//                    } else {
//                        self.focusedCell = elements.count - 1
//                    }
//                }
//                return .handled
//            })
            .focusSection()
            .focusable()
//            .focusable(interactions: .activate)
//            .defaultFocus($focusedCell, 3)
//            .defaultFocus($focusedCell, 3, priority: .automatic)

            Spacer()

            if let focusedCell {
                Text("Focused on #\(focusedCell + 1)")
            } else {
                Text("No focus")
            }
        }
        .padding()
    }

    struct Cell: View {
        let index: Int
        @Environment(\.isFocused) private var isFocused
        @State private var isTapped: Bool = false

        var body: some View {
            Text("Hello World #\(index + 1)")
                .padding(.vertical, 4)
                .focusable(interactions: .activate)
                .background(isTapped ? Color.blue : Color.clear)
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
    ListFocusExample()
        .frame(width: 300, height: 500)
}
