import SwiftUI

struct ZoomTransitionDemo: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [.init(.flexible()), .init(.flexible())]) {
                Cell(title: "Ted Lasso") {
                    Image(.tedLassoBanner)
                        .resizable()
                        .scaledToFill()
                }

                Cell(title: "London") {
                    Image(.london)
                        .resizable()
                        .scaledToFill()
                }

                Cell(title: "RED") {
                    Color.red
                        .overlay { Text("RED").bold() }
                }

                Cell(title: "BLUE") {
                    Color.blue
                        .overlay { Text("BLUE").bold() }
                }

                Cell(title: "GREEN") {
                    Color.green
                        .overlay { Text("GREEN").bold() }
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle("Menu")
    }

    struct Cell<Content: View>: View {
        let title: String
        @ViewBuilder var content: Content

        @Namespace var cellNamespace

        var body: some View {
            NavigationLink {
                DetailView(title: title, namespace: cellNamespace, content: { content })
            } label: {
                content
                    .frame(height: 100)
                    .clipShape(.rect(cornerRadius: 8))
                    .tint(Color.primary)
            }
            .matchedTransitionSource(id: title, in: cellNamespace)
        }
    }
}

private struct DetailView<Content: View>: View {
    let title: String
    let namespace: Namespace.ID
    @ViewBuilder var content: Content

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                content
                    .frame(height: 300)
                    .clipped()
                    .background(Color.black.opacity(0.3))
                    .navigationTransition(.zoom(sourceID: title, in: namespace))

                Text("Description goes in here...")
                    .padding()

                Text("""
                    Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
                    """)
                    .padding()
            }
        }
        .navigationTitle(title)
    }
}

#Preview {
    NavigationStack {
        ZoomTransitionDemo()
    }
}

#Preview("Detail") {
    @Previewable @Namespace var namespace

    NavigationStack {
        DetailView(title: "Ted Lasso", namespace: namespace) {
            Image(.tedLassoBanner)
                .resizable()
                .scaledToFit()
        }
    }
}
