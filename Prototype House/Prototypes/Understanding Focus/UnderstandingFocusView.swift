//
//  UnderstandingFocusView.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 05/01/2022.
//

import SwiftUI

struct UnderstandingFocusView: View {
    @State var isEditing: Bool = false
    @State var text: String = ""
    @FocusState var isTextFieldFocused: Bool

    var body: some View {
        VStack {
            Button(action: reset) {
                Text("Reset")
                    .padding()
                    .frame(maxWidth: .infinity)
            }
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .padding()

            TextEditor(text: $text)
                // available iOS 15+
                .focused($isTextFieldFocused)
                .overlay(
                    // using an overlay its better than
                    // having a `if` before the text editor
                    // otherwise the focus change woudln't occur
                    // as the TextEditor wasn't there when I
                    // asked it to get focused
                    Group {
                        if !isEditing {
                            VStack {
                                Text("Placeholder: Hello, World!")

                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                            .contentShape(Rectangle())
                            .onTapGesture(perform: startEditing)
                        }
                    }
                )
        }
        .frame(maxWidth: .infinity)
        .padding(.top)
        .background(.thinMaterial)
        .padding(.top)
        .navigationTitle("Understanding Focus")
    }

    func startEditing() {
        isEditing = true
        isTextFieldFocused = true
    }

    func reset() {
        isEditing = false
        isTextFieldFocused = false
        text = ""
    }
}

struct UnderstandingFocusView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UnderstandingFocusView()
        }
    }
}
