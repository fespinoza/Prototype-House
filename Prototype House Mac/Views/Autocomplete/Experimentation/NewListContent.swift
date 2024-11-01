//
//  NewListContent.swift
//  Prototype House Mac
//
//  Created by Felipe Espinoza on 17/06/2024.
//

import SwiftUI

struct NewListContent: View {
    struct Element: Identifiable, Hashable, Equatable {
        let id = UUID()
        let title: String
        let value: Int

        static let sampleElements: [Element] = [
            .init(title: "One", value: 1),
            .init(title: "Two", value: 2),
            .init(title: "Three", value: 3),
            .init(title: "Four", value: 4),
            .init(title: "Five", value: 5),
        ]
    }

    class ViewModel: ObservableObject {
        @Published var selectedCell: Element?
        let elements: [Element] = Element.sampleElements

        func selectFirst() {
            selectedCell = elements.first
        }

        func selectNext() {
            if let currentValue = selectedCell,
               let index = elements.firstIndex(of: currentValue),
               index + 1 < elements.count {
                selectedCell = elements[index + 1]
            } else {
                selectedCell = elements.first
            }
        }

        func selectPrevious() {
            if let currentValue = selectedCell,
               let index = elements.firstIndex(of: currentValue),
               index - 1 >= 0 {
                selectedCell = elements[index - 1]
            } else {
                selectedCell = elements.last
            }
        }
    }

    @ObservedObject var viewModel: ViewModel

    var body: some View {
        List(viewModel.elements, selection: $viewModel.selectedCell) { element in
            Text(element.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 4)
                .padding(.vertical, 2)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundStyle(
                            element == viewModel.selectedCell ? AnyShapeStyle(.selection) : AnyShapeStyle(.clear))
                )
                .contentShape(Rectangle())
                .onTapGesture {
                    print("selected \(element.title)")
                    viewModel.selectedCell = element
                }
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .onAppear(perform: {
            viewModel.selectFirst()
        })
        .focusable()
        .focusEffectDisabled()
//        .onKeyPress(KeyEquivalent.downArrow, action: {
//            selectNext()
//            return .handled
//        })
//        .onKeyPress(KeyEquivalent.upArrow, action: {
//            selectPrevious()
//            return .handled
//        })
//        .onMoveCommand(perform: { direction in
//            print("on move \(direction)")
//            switch direction {
//            case .up:
//                selectPrevious()
//            case .down:
//                selectNext()
//            case .right, .left:
//                break
//            @unknown default:
//                break
//            }
//        })
    }
}

#Preview {
    struct Demo: View {
        @StateObject var viewModel: NewListContent.ViewModel = .init()

        var body: some View {
            NewListContent(viewModel: viewModel)
        }
    }

    return Demo()
}
