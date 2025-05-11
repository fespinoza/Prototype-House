import SwiftUI

struct StickyHeaderImageDemoView: View {
    @State var size: CGSize = .zero

    var body: some View {
        ZStack {
            VStack {
                Image(.tedLassoBanner)
                    .resizable()
                    .scaledToFit()
                    .background(Color.black.opacity(0.3))
                    .sizeReader { size in
                        self.size = size
                    }

                Spacer()
            }

            ScrollView {
                VStack(alignment: .leading) {
                    Spacer()
                        .frame(height: size.height)

                    Text("Description goes in here...")
                        .padding()

                    lorem
                    lorem
                    lorem
                    lorem
                }
            }
        }
        .overlay(alignment: .bottom) {
            Text("\(size)")
                .monospacedDigit()
                .padding()
                .background(Color.white)
                .shadow(radius: 5)
                .padding()
        }
    }

    var lorem: some View {
        Text("""
                    Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
                    """)
        .padding()
    }
}

#Preview {
    NavigationStack {
        StickyHeaderImageDemoView()
    }
}
