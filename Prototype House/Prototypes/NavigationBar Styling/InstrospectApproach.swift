//
//  InstrospectApproach.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 29/03/2025.
//

import SwiftUI
import SwiftUIIntrospect

struct InstrospectApproachView: View {
    var body: some View {
        ScrollView {
            SampleNavigationBarContentView.LongContent()
        }
        .background(Color.red.opacity(0.1))
        .navigationTitle("Sample title")
        .navigationBarTitleDisplayMode(.inline)
        .invisibleScrollEdgeTitle()
    }
}

#Preview {
    NavigationStack {
        InstrospectApproachView()
    }
}
