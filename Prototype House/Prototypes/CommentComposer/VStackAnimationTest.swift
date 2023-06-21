//
//  VStackAnimationTest.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 30/05/2023.
//

import SwiftUI

struct VStackAnimationTest: View {
    @State var content: [String] = [
        "Hello",
        "World",
        "Asdf",
    ]

    var body: some View {
        VStack {
            Color
                .blue
                .frame(height: 100)
                .onTapGesture(count: 2) {
                    withAnimation {
                        content = [
                            "Hello",
                            "World",
                            "Asdf",
                        ]
                    }
                }

            ForEach(content, id: \.self) { text in
                cell(text)
            }

            Spacer()
        }
        .contentShape(Rectangle())
    }

    func cell(_ text: String) -> some View {
        Text(text)
            .padding()
            .background(Color.blue)
            .onTapGesture(count: 2) {
                withAnimation {
                    content.removeAll(where: { $0 == text })
                }
            }
    }
}

struct VStackAnimationTest_Previews: PreviewProvider {
    static var previews: some View {
        VStackAnimationTest()
    }
}
