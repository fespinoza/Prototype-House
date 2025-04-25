//
//  AnimationTest.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 21/03/2025.
//
import SwiftUI

struct AnimationTest: View {
    @State var middle: Bool = true

    var body: some View {
        VStack(spacing: 30) {
            cell("Top", color: .red)
            if middle {
                cell("Middle", color: .green)
                    .transition(.scale(scale: 0))
            }
            cell("Bottom", color: .blue)

            Spacer()

            Button(action: hiddeMiddle) {
                Text("Hide middle")
            }

        }
        .padding(.top, 16)
    }

    func hiddeMiddle() {
//        withAnimation(.easeInOut.speed(5000)) {
        withAnimation(.easeInOut(duration: 5)) {
            middle.toggle()
        }
    }

    func cell(_ text: String, color: Color) -> some View {
        Text(text)
            .frame(maxWidth: .infinity)
            .padding(16)
            .background(color)
            .padding(.horizontal, 16)
    }
}

#Preview {
    AnimationTest()
}
