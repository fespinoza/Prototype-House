import SwiftUI

// No title variant

@available(iOS 26.0, *)
struct ScrollViewForIOS26_V3: View {
    @State var offsetY: CGFloat = 0
    @State var initialOffsetY: CGFloat = 0
    let customBarBackgroundHeight: CGFloat = 400

    var barOffset: CGFloat {
        -(initialOffsetY + offsetY) - customBarBackgroundHeight / 2
    }

    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    Color.blue
                        .frame(height: customBarBackgroundHeight)
                        .offset(y: barOffset)
                        .ignoresSafeArea(.container, edges: .top)

                    Color.yellow
                }

                ScrollViewReader { proxy in
                    ScrollView(.vertical) {
                        VStack(spacing: 0) {
                            Color(uiColor: .lightGray)
                                .frame(height: 400)

                            Color.white
                                .frame(height: 2000)
                        }
                    }
                    .onScrollGeometryChange(
                        for: CGFloat.self,
                        of: { $0.contentOffset.y },
                        action: { _, newValue in
                            offsetY = newValue
                            if initialOffsetY == 0 {
                                initialOffsetY = -newValue
                            }
                        }
                    )
                }
            }
            .overlay {
                Text("\(offsetY)\n\(barOffset)\n\(initialOffsetY)")
                    .monospacedDigit()
                    .padding()
                    .background(Color.red)
                    .offset()
            }
            .onGeometryChange(
                for: CGFloat.self,
                of: { $0.size.width },
                action: { oldValue, newValue in
                    if oldValue != newValue {
                        initialOffsetY = 0
                    }
                }
            )
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Circle()
                        .foregroundStyle(Color(uiColor: .black))
                        .overlay {
                            Text("S")
                                .foregroundStyle(.white)
                        }
                }

                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button(action: {}) {
                        Label("Filter", systemImage: "line.horizontal.3.decrease")
                    }

                    Button(action: {}) {
                        Label("Filter", systemImage: "person.circle")
                    }
                }
            }
            .toolbarBackground(Color.clear, for: .navigationBar)
        }
    }
}

@available(iOS 26.0, *)
#Preview {
    ScrollViewForIOS26_V3()
}
