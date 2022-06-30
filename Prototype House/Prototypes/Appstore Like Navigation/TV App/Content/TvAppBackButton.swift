//
//  TvAppBackButton.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 30/06/2022.
//

import SwiftUI

struct TvAppBackButton: View {
    var body: some View {
        Button(action: {}, label: {
            Image(systemName: "chevron.left.circle.fill")
                .resizable()
                .renderingMode(.original)
//                .foregroundStyle(.white, .red)
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24, alignment: .center)
        })
    }
}

struct TvAppBackButton_Previews: PreviewProvider {
    static var previews: some View {
        TvAppBackButton()
            .padding()
            .background(Color.gray)
            .previewLayout(.sizeThatFits)
    }
}
