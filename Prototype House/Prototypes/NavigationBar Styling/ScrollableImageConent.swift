import SwiftUI

struct ScrollableDemoList: View {
    var body: some View {
        List {
            NavigationLink("Ted Lasso") {
                ScrollableImageConent(image: Image(.tedLassoBanner), tedLasso: true)
            }

            NavigationLink("London") {
                ScrollableImageConent(image: Image(.london), tedLasso: false)
            }
        }
        .navigationTitle("Choose your demo")
    }
}

struct ScrollableImageConent: View {
    @State var image: Image = Image(.tedLassoBanner)
    @State var tedLasso: Bool = true

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                GeometryReader { proxy in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: proxy.size.width, height: proxy.size.height)
                }
                .frame(height: 350)
                .clipped()
                .overlay(
                    LinearGradient(
                        colors: [.black.opacity(0.5), .clear],
                        startPoint: .init(x: 0, y: 0),
                        endPoint: .init(x: 0, y: 0.35)
                    )
                )

                Group {

                    Text(tedLasso ? "Ted Lasso" : "London")
                        .font(.largeTitle.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Button("Toggle Image", action: toggleImage)
                        .buttonStyle(.borderedProminent)

                    Color.clear
                        .frame(height: 800)

                    Text("Center")

                    Color.clear
                        .frame(height: 800)

                    Text("Bottom of Screen")
                }
                .padding(.horizontal, 16)
            }
        }
        .ignoresSafeArea(.all, edges: .top)
        .navigationTitle("Ted Lasso")
        .navigationBarTitleDisplayMode(.inline)
        .invisibleScrollEdgeTitle()
    }

    func toggleImage() {
        if tedLasso {
            image = Image(.london)
            tedLasso = false
        } else {
            image = Image(.tedLassoBanner)
            tedLasso = true
        }
    }
}

#Preview {
    NavigationStack {
        ScrollableImageConent()
    }
}
