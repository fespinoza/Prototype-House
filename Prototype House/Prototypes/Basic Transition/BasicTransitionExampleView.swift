//
//  BasicTransitionExampleView.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 13/12/2022.
//

import SwiftUI

struct BasicTransitionExampleView: View {
    enum Shape: String {
        case rectangle
        case circle
        case triangle
    }

    @State var showSecretMessage: Bool = false
    @State var currentShape: Shape = .rectangle

    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                Text("Sample Transition")
                    .font(.largeTitle.bold())

                Spacer()

                Group {
                    switch currentShape {
                    case .rectangle:
                        Rectangle()
                            .foregroundColor(.blue)
                    case .circle:
                        Circle()
                            .foregroundColor(.yellow)
                    case .triangle:
                        Capsule()
                            .foregroundColor(.red)
                    }
                }
                .transition(.opacity)
                .frame(width: 150, height: 100)

                Spacer()

                Button("Hello", action: pushButton)
                    .buttonStyle(.borderedProminent)

                // $currentShape.animation() is one way to do this
                Picker(selection: $currentShape, label: Text("Shape")) {
                    Text(Shape.rectangle.rawValue).tag(Shape.rectangle)
                    Text(Shape.circle.rawValue).tag(Shape.circle)
                    Text(Shape.triangle.rawValue).tag(Shape.triangle)
                }
            }

            if showSecretMessage {
                Text("Hello World!")
                    .padding(.top, 80)
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut, value: currentShape.rawValue)
        .animation(.easeInOut, value: showSecretMessage)
    }

    func pushButton() {
//        withAnimation {
            showSecretMessage.toggle()
//        }
    }
}

struct BasicTransitionExampleView_Previews: PreviewProvider {
    static var previews: some View {
        VStack { // this helps xcode previews
            BasicTransitionExampleView()
        }
    }
}
