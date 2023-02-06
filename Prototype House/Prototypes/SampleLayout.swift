//
//  SampleLayout.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 15/12/2022.
//

import SwiftUI

struct SampleLayout: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 0) {
//                Image("tedLassoBanner")
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(height: 100)
//                    .clipped()
                Rectangle()
                    .foregroundColor(.blue)
                    .frame(height: 200)
                    .overlay(
                        Image("tedLassoBanner")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    )

                Text("Hello, World!")
                    .bold()
                    .foregroundColor(.white)
                    .padding()
            }
            .background(Color.orange)
            .cornerRadius(8)
            .padding(.horizontal, 8)
        }
    }
}

struct SampleLayout_Previews: PreviewProvider {
    static var previews: some View {
        SampleLayout()
    }
}
