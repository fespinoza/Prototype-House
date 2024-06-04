//
//  SwiftUIView.swift
//  
//
//  Created by Felipe Espinoza on 06/07/2023.
//

import SwiftUI

public struct CustomLoadingView: View {
    public init() {}

    public var body: some View {
        HStack {
            Text("Loading Message", bundle: .module, comment: "message for the translator")
            Spacer()
            ProgressView()
        }
    }
}

#Preview {
    VStack {
        GroupBox {
            CustomLoadingView()
        }

        Text("Random Text", bundle: .module)
    }
    .padding()
    .environment(\.locale, .init(identifier: "en"))
}
