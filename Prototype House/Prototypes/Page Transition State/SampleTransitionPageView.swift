//
//  SampleTransitionPageView.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 21/10/2022.
//

import SwiftUI

struct SampleTransitionPageView: View {
    @State var showOnboarding: Bool = false

    var body: some View {
        VStack {
            Spacer()

            Text("Hello, World!")
                .font(.largeTitle)

            Spacer()

            Button("Show onboarding", action: { showOnboarding = true })
                .buttonStyle(.borderedProminent)
        }
        .fullScreenCover(isPresented: $showOnboarding) {
            SampleTransitionPageView.OboardingView()
        }
    }
}

extension SampleTransitionPageView {
    struct OboardingView: View {
        @State var step: Int = 1
        @Environment(\.dismiss) var dismiss

        var body: some View {
            VStack {
                Text("Logo")
                    .font(.title)

                stepContent()
            }
            .frame(maxWidth: .infinity)
            .background(Color.purple)
            .foregroundColor(.white)
            .transition(.opacity)
        }

        let lastStep: Int = 4

        func stepContent() -> some View {
            let finish: Bool = step == lastStep

            return VStack {
                Spacer()

                Text("Step #\(step)")
                    .font(.system(size: 80))
                    .bold()

                Spacer()

                Button(finish ? "Finish" : "Next Step", action: nextOrFinish)
                    .buttonStyle(.borderedProminent)
                    .accentColor(.white)
                    .foregroundColor(.purple)
            }
            .transition(.slide)
        }

        func nextOrFinish() {
            if step < lastStep {
                withAnimation {
                    step += 1
                }
            } else {
                dismiss()
            }
        }
    }
}

struct SampleTransitionPageView_Previews: PreviewProvider {
    static var previews: some View {
        SampleTransitionPageView()

        SampleTransitionPageView.OboardingView()
            .previewDisplayName("Onboarding step")
    }
}
