//
//  ShapeDifferenceExample.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 28/02/2023.
//

import SwiftUI

// Taking a rectangle from the circle

// More examples in: https://stackoverflow.com/questions/59656117/swiftui-add-inverted-mask

struct ShapeDifferenceExample: View {
    var body: some View {
        VStack {
            Spacer()

            ZStack(alignment: .topTrailing) {
                Circle()
                    .foregroundColor(.black.opacity(0.8))

                Rectangle()
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .padding(60)
//                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .blendMode(.destinationOut)  // ⚠️
            }
            .compositingGroup() // ⚠️

            Spacer()
        }
        .background(Color.orange)
    }
}

struct ShapeDifferenceExample_Previews: PreviewProvider {
    static var previews: some View {
        ShapeDifferenceExample()
    }
}
