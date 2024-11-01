//
//  InspectorDemoView.swift
//  Prototype House Mac
//
//  Created by Felipe Espinoza on 20/09/2024.
//

import SwiftUI

struct InspectorDemoView: View {
    @State private var isShowingInspector = false

    var body: some View {
        Button("Hello, world!") {
            isShowingInspector.toggle()
        }
        .font(.largeTitle)
        .inspector(isPresented: $isShowingInspector) {
            Text("Inspector View")
        }
    }
}

#Preview {
    InspectorDemoView()
}
