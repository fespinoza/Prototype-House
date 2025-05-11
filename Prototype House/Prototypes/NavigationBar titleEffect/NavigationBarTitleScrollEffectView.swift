//
//  NavigationBarTitleScrollEffectView.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 23/05/2023.
//

import SwiftUI

// Custom Scroll Offset Driven, title animation in SwiftUI

//@available(iOS 16.0, *)
struct NavigationBarTitleScrollEffectView: View {
    @State var offset: CGFloat = 0.0

    var body: some View {
        NavigationView {
            ScrollReaderView(scrollValue: $offset) {
                VStack {
                    Text("Top")
                        .background(Color.blue.opacity(0.3))

                    Text("Hello")
                        .font(.largeTitle.bold())
                        .background(Color.red)
                        .padding(.top, 100)

                    Spacer()

                    Text("Center")
                        .background(Color.green.opacity(0.3))

                    Spacer()

                    Text("Bottom")
                        .background(Color.red.opacity(0.3))
                }
                .frame(maxWidth: .infinity)
                .border(Color.red)
                .frame(maxWidth: .infinity, minHeight: 1200)
                .background(Color.green.opacity(0.2))
            }
            .overlay(content: {
                Text("\(offset)")
                    .frame(maxWidth: .infinity, alignment: .leading)
            })
            .toolbar(content: {
                ToolbarItem(placement: .principal) {
                    Text("Hello")
                        .offset(x: 0, y: UtilMath.yOffset(-offset))
                        .opacity(UtilMath.opacifyForOffset(-offset))
                }
            })
            .navigationTitle("Hello")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.orange.opacity(0.2))
        }
    }
}

private struct UtilMath {
    static let yOffset = LinearEquation.segmentedLinearEquation(
        fromPoint: .init(x: 130, y: 20),
        toPoint: .init(x: 174, y: 0)
    )

    static let opacifyForOffset = LinearEquation.segmentedLinearEquation(
        fromPoint: .init(x: 130, y: 0.0),
        toPoint: .init(x: 200, y: 1.0)
    )
}

//@available(iOS 16.0, *)
struct NavigationBarTitleScrollEffectView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarTitleScrollEffectView()
    }
}
