//
//  CustomPresentationView.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 17/04/2022.
//

import SwiftUI

struct CustomPresentationView: View {
    @State var isPresentingDetail: Bool = false
    @State var isUpsideDown: Bool = false

    var body: some View {
        VStack(spacing: 30) {
            Text("Custom SwiftUI Presentation")
                .font(.title)

            Text("The idea is to make a custom presentation of a view controller in swiftUI")

            Spacer()

            Toggle("Upside Down?", isOn: $isUpsideDown)

            Button(action: presentDetail) {
                Text("Present Detail")
            }
            .buttonStyle(.bordered)
        }
        .padding(.horizontal)
        .multilineTextAlignment(.center)
        .padding()
        .scaleEffect(isPresentingDetail ? 0.85 : 1)
        .overlay(detailContent)
    }

    func presentDetail() {
        withAnimation(.easeInOut) {
            isPresentingDetail.toggle()
        }
    }

    @ViewBuilder var detailContent: some View {
        if isPresentingDetail {
            SampleDetailView(isPresented: $isPresentingDetail)
                .rotationEffect(.degrees(isUpsideDown ? 180 : 0))
                .frame(maxWidth: .infinity)
                .background(
                    Color(UIColor.secondarySystemBackground)
                        .ignoresSafeArea()
                )
                .transition(
                    .move(edge: isUpsideDown ? .top : .bottom)
                )
//                .environment(\.dismiss, )
        }
    }

    func customDismissAction() -> DismissAction {
//        let action = DismissAction
        fatalError()
    }
}


extension CustomPresentationView {
    struct SampleDetailView: View {
        @Binding var isPresented: Bool
//        @Environment(\.dismiss) var dismiss

        var body: some View {
            VStack {
                Spacer()

                Text("Detail!")
                    .font(.largeTitle)

                Spacer()

                Button(action: closeDetail) {
                    Text("Close")
                }
                .buttonStyle(.bordered)
            }
        }

        func closeDetail() {
            withAnimation {
                isPresented.toggle()
            }
        }
    }
}


struct CustomPresentationView_Previews: PreviewProvider {
    static var previews: some View {
        CustomPresentationView()
    }
}
