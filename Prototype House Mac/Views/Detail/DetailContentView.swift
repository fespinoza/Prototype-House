//
//  DetailContextView.swift
//  Prototype House Mac
//
//  Created by Felipe Espinoza on 03/01/2022.
//

import SwiftUI

struct DetailContentView: View {
    let index: Int

    var body: some View {
        HSplitView {
            Text("Card Details")
            Text("Content")
            Text("Search")
        }
        .frame(maxHeight: .infinity)
        .navigationTitle("Index #\(index)")
    }
}

struct DetailContentView_Previews: PreviewProvider {
    static var previews: some View {
        DetailContentView(index: 2)
    }
}
