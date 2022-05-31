//
//  BottomSheetExperimentView.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 17/01/2022.
//

import SwiftUI

struct BottomSheetExperimentView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Text("Hello, World!")
                    .font(.title)

                Spacer()
            }

            VStack(spacing: -15) {
                Color.white
                    .frame(height: 30)
                    .cornerRadius(15)
                    .overlay(
                        Color.gray
                            .opacity(0.7)
                            .frame(width: 45, height: 5)
                            .cornerRadius(5)
                            .offset(x: 0, y: -5)
                    )

                NavigationView {
                    VStack {
                        NavigationLink(destination: sampleView) {
                            Text("Sample")
                        }
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Hello")
                }
            }
            .frame(height: 300)
        }
    }

    var sampleView: some View {
        Text("All works!")
            .navigationTitle("Fine!")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct BottomSheetExperimentView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetExperimentView()
            .background(Color.blue.ignoresSafeArea())
    }
}
