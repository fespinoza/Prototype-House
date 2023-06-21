//
//  CommentComposerView.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 23/05/2023.
//

import SwiftUI

@available(iOS 16.0, *)
struct CommentComposerView: View {
    @State var text: String = ""
    @State var isLoading: Bool = false
    var onSubmit: ((String) async -> Void)?

    var body: some View {
        HStack {
            // iOS 16
            TextField("Foo", text: $text, prompt: Text("Hello").foregroundColor(.red), axis: .vertical)
                .onSubmit(submitComment)

//            TextField("Leave a comment", text: $text, axis: .vertical)
                .lineLimit(4)
                .textFieldStyle(.plain)

//            TextEditor(text: $text)
//                .scrollContentBackground(.hidden)

            if !text.isEmpty {
                Button(action: submitComment) {
                    Image(systemName: "arrow.up.circle.fill")
                        .symbolRenderingMode(.multicolor)
                        .foregroundColor(.blue)
//                        .foregroundColor(isLoading ? .red : .white)
                        .font(.system(size: 24))
                        .overlay {
                            if isLoading {
                                ProgressView()
                                    .controlSize(.small)
                                    .tint(.white)
                                    .background(Circle().foregroundColor(.blue))
                            }
                        }
                }
//                .disabled(isLoading)
            }
        }
        .padding(4)
        .background(
            RoundedRectangle(cornerRadius: 4).foregroundColor(.black.opacity(0.3))
                .overlay {
                    RoundedRectangle(cornerRadius: 4).stroke(Color.white)
                }
        )
        .padding()
        .background(Color.gray)
        .foregroundColor(.white)
    }

    func submitComment() {
        isLoading = true
        let newComment = text
        text = ""
        Task {
            await onSubmit?(newComment)
            isLoading = false
        }
    }
}

@available(iOS 16.0, *)
struct CommentComposerView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()

            CommentComposerView(text: "Something going on")

            CommentComposerView(
                text: "Something going on with a very lage text that spans multiple lines",
                isLoading: true
            )

            CommentComposerView()
        }
    }
}
