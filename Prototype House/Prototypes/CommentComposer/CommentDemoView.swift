//
//  CommentDemoView.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 23/05/2023.
//

import SwiftUI

struct Comment: Identifiable {
    let id: UUID = .init()
    let authorName: String
    let authorColor: Color
    let text: String
    let createdDate: String
}

@available(iOS 16.0, *)
struct CommentDemoView: View {
    @State var comments: [Comment]
    @State var placeholder: Comment?

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack {
                    ForEach(comments) { comment in
                        cell(for: comment)
                            .id("comment-\(comment.id)")
                    }

                    if let placeholder {
                        cell(for: placeholder, isLoading: true)
                            .id("comment-\(placeholder.id)")
                    }

                    Spacer().frame(height: 120)
                }
                .overlay {
                    composer(scrollProxy: proxy)
                }
            }
        }
    }

    func composer(scrollProxy: ScrollViewProxy) -> some View {
        VStack {
            HStack {
                Button("top", action: { scrollToTop(scrollProxy) })

                Spacer()

                Button("bottom", action: { scrollToBottom(scrollProxy) })
            }
            .buttonStyle(.borderedProminent)
            .padding()
            Spacer()
            CommentComposerView { newText in
                await submitComment(newText, proxy: scrollProxy)
            }
        }
    }

    func scrollToTop(_ scrollProxy: ScrollViewProxy) {
        withAnimation { scrollProxy.scrollTo("comment-\(comments.first!.id)", anchor: .top) }
    }

    func scrollToBottom(_ scrollProxy: ScrollViewProxy) {
        withAnimation { scrollProxy.scrollTo("comment-\(comments.last!.id)", anchor: .top) }
    }

    func submitComment(_ text: String, proxy: ScrollViewProxy) async {
        let comment = Comment(authorName: "Current User", authorColor: .blue, text: text, createdDate: "Now")
        scrollToBottom(proxy)
        withAnimation {
            placeholder = comment
        }
        try? await Task.sleep(for: .seconds(2))
//        comments.insert(comment, at: 0)
        comments.append(comment)
        placeholder = nil
    }

    func cell(for comment: Comment, isLoading: Bool = false) -> some View {
        HStack {
            Circle().foregroundColor(comment.authorColor)
                .frame(size: 45)
                .overlay {
                    if isLoading {
                        ProgressView().tint(.white)
                    }
                }

            VStack(alignment: .leading) {
                HStack {
                    Text(comment.authorName).bold()

                    Spacer()
                    if isLoading {
                        Text(comment.createdDate)
                            .redacted(reason: .placeholder)
                    } else {
                        Text(comment.createdDate)
                    }
                }
                .font(.caption)

                Text(comment.text)

                Divider()
            }
        }
        .padding()
        .background(Color.blue)
//        .transition(.opacity)
//        .onTapGesture(count: 2, perform: {
//            delete(comment)
//        })
        .contextMenu {
            Button(action: { delete(comment) }) {
                Text("Delete")
            }
        }
    }

    func delete(_ comment: Comment) {
        withAnimation(.easeInOut.delay(0.5)) {
            comments.removeAll(where: { $0.id == comment.id })
        }
    }
}

@available(iOS 16.0, *)
struct CommentDemoView_Previews: PreviewProvider {
    struct Demo: View {
        @State var comments: [Comment] = (1...20).map { .previewValue(text: "Comment #\($0)") }


        var body: some View {
            NavigationStack {
                CommentDemoView(comments: comments)
            }
        }
    }

    static var previews: some View {
        Demo()
    }
}

extension Comment {
    static func previewValue(
        authorName: String = "John Snow",
        authorColor: Color = .red,
        text: String = "A sample comment",
        createdDate: String = "3 hours ago"
    ) -> Comment {
        .init(
            authorName: authorName,
            authorColor: authorColor,
            text: text,
            createdDate: createdDate
        )
    }
}
