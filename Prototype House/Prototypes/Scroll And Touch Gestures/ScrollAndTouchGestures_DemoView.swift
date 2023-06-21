//
//  ScrollAndTouchGestures_DemoView.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 23/05/2023.
//

import SwiftUI

struct ScrollAndTouchGestures_DemoView: View {
    let numbers: [Int] = [2, 0, 4, 6, 8, 3, 2, 5, 1, 2, 3, 5, 2, 0, 4, 6, 8, 3, 2, 5]

    @State var selectedNumber: Int?
    @State var selectedElement: Int?

    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                Text("Selected: \(selectedNumber ?? -1)")

                ScrollView(.horizontal) {
                    HStack(alignment: .bottom) {
                        ForEach(Array(numbers.enumerated()), id: \.offset) { pair in
                            Rectangle()
                                .foregroundColor(selectedElement == pair.offset ? .red : .blue)
                                .frame(width: 30, height: 20 * CGFloat(pair.element))
                                .onTapGesture {
                                    selectedElement = pair.offset
                                    selectedNumber = pair.element
                                }
                        }
                    }
                    .background(Color.gray.opacity(0.2))
                }
                .padding()

                Spacer()
            }
            .navigationTitle("Scroll And Touch")
        }
    }
}

struct ScrollAndTouchGestures_DemoView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollAndTouchGestures_DemoView()
    }
}
