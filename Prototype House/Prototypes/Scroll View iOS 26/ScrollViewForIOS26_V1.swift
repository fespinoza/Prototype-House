import SwiftUI


@available(iOS 26.0, *)
struct ScrollViewForIOS26_V1: View {
    @State var offsetY: CGFloat = 0 // 2
    let customBarBackgroundHeight: CGFloat = 300

    var barOffset: CGFloat {
        -offsetY - 2 * customBarBackgroundHeight / 3 // 2
    }

    var titleOpacity: Double {
        min(1.0, max(0.0, 1.0 - offsetY / 9.0)) // fix this!
    }

    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    Color.blue
                        .frame(height: customBarBackgroundHeight)
                        .offset(y: barOffset) // 2
                        .ignoresSafeArea(.container, edges: .top)

                    Color.yellow
                }

                ScrollView(.vertical) {
                    VStack(spacing: 0) {
                        Color.green
                            .frame(height: 400)

                        Color.purple
                            .frame(height: 2000)
                    }
                }
//                .opacity(0.1)
                .onScrollGeometryChange( // 2
                    for: CGFloat.self,
                    of: { $0.contentOffset.y },
                    action: { _, newValue in
                        offsetY = newValue // 2
                    }
                )
            }
            .overlay { // 2
                Text("\(offsetY)\n\(barOffset)")
                    .monospacedDigit()
                    .padding()
                    .background(Color.red)
                    .offset()
            }
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

                ToolbarItem() {
                    Text("Hello")
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .opacity(titleOpacity)
                }
                .sharedBackgroundVisibility(.hidden)

                ToolbarSpacer(.fixed)

                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button(action: {}) {
                        Label("Filter", systemImage: "line.horizontal.3.decrease")
                    }

                    Button(action: {}) {
                        Label("Filter", systemImage: "person.circle")
                    }
                }
            }
        }
    }
}

@available(iOS 26.0, *)
#Preview {
    ScrollViewForIOS26_V1()
}
