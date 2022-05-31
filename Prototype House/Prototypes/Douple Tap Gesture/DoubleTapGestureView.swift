//
//  DoubleTapGestureView.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 17/04/2022.
//

import SwiftUI

struct DoubleTapGestureView: View {
    @State var message: String = "..."

    var body: some View {
        VStack(spacing: 20) {
            Text("Double Tap Gesture")
                .font(.title)
            Text("A way to implement this in swiftUI")
                .textSelection(.enabled)

            Spacer()

            Text(message)
                .foregroundColor(.red)
                .padding()

            Rectangle()
                .frame(width: 250, height: 250)
                .foregroundColor(.red)
                .overlay {
                    DoubleTouchAdapterView { recognizer in
                        message = "Double tap!"
                    }
                }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            message = "..."
        }
        .padding(40)
        .multilineTextAlignment(.center)
    }
}


// source: https://developer.apple.com/forums/thread/132827
struct DoubleTouchAdapterView: UIViewRepresentable {
    typealias UIViewType = UIView

    var tapCallback: (UITapGestureRecognizer) -> Void

    func makeCoordinator() -> DoubleTouchAdapterView.Coordinator {
        Coordinator(tapCallback: self.tapCallback)
    }

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        let doubleTapGestureRecognizer = UITapGestureRecognizer(
            target: context.coordinator,
            action: #selector(Coordinator.handleTap(sender:))
        )

        /// Set number of touches.
        doubleTapGestureRecognizer.numberOfTouchesRequired = 2

        view.addGestureRecognizer(doubleTapGestureRecognizer)
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}

    class Coordinator {
        var tapCallback: (UITapGestureRecognizer) -> Void

        init(tapCallback: @escaping (UITapGestureRecognizer) -> Void) {
            self.tapCallback = tapCallback
        }

        @objc func handleTap(sender: UITapGestureRecognizer) {
            self.tapCallback(sender)
        }
    }
}

struct DoubleTapGestureView_Previews: PreviewProvider {
    static var previews: some View {
        DoubleTapGestureView()
    }
}

/*

 Sources:

 - https://stackoverflow.com/questions/61566929/swiftui-multitouch-gesture-multiple-gestures
 - https://www.reddit.com/r/SwiftUI/comments/s55gyy/multitouch_support_in_swiftui/

 */
