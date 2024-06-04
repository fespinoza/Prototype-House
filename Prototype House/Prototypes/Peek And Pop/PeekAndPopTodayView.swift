//
//  PeekAndPopTodayView.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 05/10/2023.
//

import SwiftUI

@available(iOS 16.0, *)
struct PeekAndPopTodayView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<100, id: \.self) { index in
                    NavigationLink {
                        destination(for: index)
                    } label: {
                        Label("Row \(index)", systemImage: "globe")
                            .contextMenu {
                                Button("Delete", role: .destructive, action: {})
                                Button("Favorite", action: {})
//                            } preview: {
//                                destination(for: index)
                            }

                    }
                }
            }
        }
    }

    func destination(for index: Int) -> some View {
        VStack {
            Text("Details")
            Spacer()
            Label("Row \(index)", systemImage: "globe")
            Spacer()
        }
        .navigationTitle("Details \(index)")
        .frame(maxWidth: .infinity)
        .background(Color.red)
    }
}

@available(iOS 16.0, *)
#Preview {
    PeekAndPopTodayView()
}
