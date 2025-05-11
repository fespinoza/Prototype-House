import SwiftUI

struct StretchyHeaderView: View {
    private let headerHeight: CGFloat = 300

    var body: some View {
        ScrollView {
            GeometryReader { geometry in
                let offset = geometry.frame(in: .global).minY
                Image(.tedLassoBanner) // replace with your image name
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: offset > 0 ? headerHeight + offset : headerHeight)
                    .clipped()
                    .offset(y: offset > 0 ? -offset : 0)
            }
            .frame(height: headerHeight)
//            .clipped()

            VStack(spacing: 20) {
                ForEach(0..<20) { index in
                    Text("Item \(index)")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
            .padding(.top)
        }
        .edgesIgnoringSafeArea(.top)
        .navigationTitle("Hello")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]

            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

#Preview {
    NavigationStack {
        StretchyHeaderView()
    }
}
