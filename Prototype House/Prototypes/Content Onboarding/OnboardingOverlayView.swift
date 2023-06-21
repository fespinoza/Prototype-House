//
//  OnboardingOverlayView.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 01/03/2023.
//

import SwiftUI

@available(iOS 16.0, *)
struct OnboardingOverlayView: View {
    enum OnboardingStep {
        case hidden
        case onlyBackground
        case stepOne
        case stepTwo

        var stepNumber: Int {
            switch self {
            case .stepTwo: return 2
            default: return 1
            }
        }
    }

    @State var step: OnboardingStep = .hidden

    var body: some View {
        ZStack {
            Color.clear

            if step != .hidden {
                GeometryReader { proxy in
                    ZStack {
                        overlayCurtain
                            .onAppear(perform: animateContentIfNeeded)

                        stepCounter

                        stepOne(proxy: proxy)

                        stepTwo
                    }
                }
            }
        }
        .onTapGesture(perform: nextStep)
        .onAppear(perform: animateBackgroundIfNeeded)
    }

    func animateBackgroundIfNeeded() {
        withAnimation {
            step = .onlyBackground
        }
    }

    func animateContentIfNeeded() {
        withAnimation(.default.delay(0.5)) {
            step = .stepOne
        }
    }

    func nextStep() {
        switch step {
        case .stepOne:
            step = .stepTwo
        case .stepTwo:
            withAnimation {
                step = .hidden
            }
        default:
            break
        }
    }

    @ViewBuilder var overlayCurtain: some View {
        ZStack {
            Color.black.opacity(0.6)
            stepTwoBackgroundCutout
        }
        .compositingGroup()
    }

    @ViewBuilder var stepCounter: some View {
        if step != .hidden && step != .onlyBackground {
            Text("\(step.stepNumber)/2").font(.body.monospaced())
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .foregroundColor(.black)
                .background(Color.white)
                .cornerRadius(8)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(8)
        }
    }

    @ViewBuilder func stepOne(proxy: GeometryProxy) -> some View {
        if step == .stepOne {
            BubbleView(edge: .bottomTrailing, tailXOffset: offsetX(from: proxy)) {
                Text("Statistics")
                    .font(.headline)
                Text("Lorem ipsum dipsum dupsko, her er en tekst om hva du finner her.")
            }
            .padding(.horizontal, 8)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
    }

    @ViewBuilder var stepTwo: some View {
        if step == .stepTwo {
            BubbleView(edge: .topTrailing) {
                Text("Profile").font(.headline)
                Text("Lorem ipsum dipsum dupsko, her er en tekst om hva du finner her.")
            }
            .padding(.top, 40)
            .padding(.horizontal, 8)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
    }

    @ViewBuilder var stepTwoBackgroundCutout: some View {
        if step == .stepTwo {
            Circle()
                .blendMode(.destinationOut)
                .frame(size: 44)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding(.top, -6)
                .padding(.trailing, 6)
        }
    }

    func offsetX(from proxy: GeometryProxy) -> CGFloat {
        let numberOfTabs: CGFloat = 3
        let tabWidth = proxy.size.width / numberOfTabs
        return tabWidth / 2.0 - 13
    }
}

@available(iOS 16.0, *)
struct OnboardingOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            VStack {
                Image("london")
                    .resizable()
                    .aspectRatio(contentMode: .fit)

                Text("Hello, World!")

                Spacer()
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "trash")
                }
            })
            .navigationTitle("London")
        }
        .overlay {
            OnboardingOverlayView()
        }
    }
}
