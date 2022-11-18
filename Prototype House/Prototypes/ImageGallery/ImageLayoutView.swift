//
//  ImageLayoutView.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 28/10/2022.
//

import SwiftUI

struct ImageLayoutView: View {
    var body: some View {
        VStack {
            HStack {
                Color.red
                VStack {
                    Color.green
                    Color.orange
                }
            }
            Color.blue
        }
    }
}

struct ImageLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        ImageLayoutView()
    }
}
