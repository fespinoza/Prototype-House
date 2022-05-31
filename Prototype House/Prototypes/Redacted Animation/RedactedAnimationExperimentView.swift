//
//  RedactedAnimationExperimentView.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 09/01/2022.
//

import SwiftUI

/*

 ## Animated highlight over redacted code

 To actually try to get a loading shimmer animation on redacted content

 Interesting concepts:
 - overlay + `.blendMode`
 - Infinite Animations
 - Stopping animations

 Sources:
 - https://www.swiftkickmobile.com/creating-a-repeating-animation-in-swiftui/
 - https://stackoverflow.com/questions/59133826/swiftui-stop-an-animation-that-repeats-forever

 */

struct RedactedAnimationExperimentView: View {
    @State var offsetX: CGFloat = 0
    @State var duration: CGFloat = 1.5
    @State var animationStarted: Bool = false
    @State var stopAnimation: Bool = false

//    var animation: Animation? = Animation.easeInOut.repeatForever(autoreverses: false)

    var body: some View {
        VStack {
            SampleContentView()
                .redacted(reason: .placeholder)
                .overlay(overlayContent)

            Circle()
                .foregroundColor(Color.gray)
                .frame(width: 200, height: 200)
                .overlay(overlayContent)
                .clipped()

            Spacer()

            form
        }
    }

    var overlayContent: some View {
        GeometryReader { proxy in
            Color
                .white
                .opacity(0.5)
//                            .blur(radius: 5)
                .frame(width: proxy.size.width * 0.3)
                .offset(x: proxy.size.width * offsetX, y: 0)
                .blendMode(.lighten)
        }
    }

    var form: some View {
        VStack {
            Text("Offset: ") + Text(offsetX, format: .number)

            Text("Duration: ") + Text(duration, format: .number)

            Slider(value: $offsetX)
                .padding()

            Slider(value: $duration, in: (0.1...CGFloat(3.0)))
                .padding()

            Button("Animate", action: animateOverlay)
        }
    }

    let delta: CGFloat = 5

    func animateOverlay() {
        var animation = Animation.easeInOut(duration: duration)

        if animationStarted {
//            animationRunningFromBefore = false
            // no repeat forever
            animationStarted = false
        } else {
            animation = animation.repeatForever(autoreverses: false)
            animationStarted = true
        }

        withAnimation(animation) {
            offsetX = offsetX > 1 ? 0 : offsetX + delta
        }
    }
}

extension RedactedAnimationExperimentView {
    struct SampleContentView: View {
        var body: some View {
            VStack {
                Image("sampleAvatar")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .clipped()

                Text("Felipe Espinoza")
                    .font(.title)

                Divider()

                HStack {
                    number(title: "Followers", value: "20")
                    Divider().frame(height: 80)
                    number(title: "Following", value: "10")
                }

                Divider()

//                Spacer()
            }
        }

        @ViewBuilder func number(title: String, value: String) -> some View {
            Spacer()

            VStack(spacing: 8) {
                Text(title).font(.subheadline)
                Text(value).font(.title2)
            }

            Spacer()
        }
    }
}

struct RedactedAnimationExperimentView_Previews: PreviewProvider {
    static var previews: some View {
        RedactedAnimationExperimentView()
    }
}
