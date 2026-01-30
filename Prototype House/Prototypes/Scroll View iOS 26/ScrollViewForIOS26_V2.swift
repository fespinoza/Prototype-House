import SwiftUI

@available(iOS 26.0, *)
struct ScrollViewForIOS26_V2: View {
    @State var offsetY: CGFloat = 0
    @State var initialOffsetY: CGFloat = 0
    let customBarBackgroundHeight: CGFloat = 400

    var barOffset: CGFloat {
        -(initialOffsetY + offsetY) - customBarBackgroundHeight / 2
    }

    var titleOpacity: Double {
        min(1.0, max(0.0, 1.0 - (offsetY + initialOffsetY) / 9.0))
    }

    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    Color.red
                        .frame(height: customBarBackgroundHeight)
                        .offset(y: barOffset)
                        .ignoresSafeArea(.container, edges: .top)

                    Color.yellow
                }

                ScrollViewReader { proxy in
                    ScrollView(.vertical) {
                        VStack(spacing: 0) {
                            Color.indigo
                                .frame(height: 400)

                            Color.teal
                                .frame(height: 2000)
                        }
                    }
                    .onScrollGeometryChange(
                        for: CGFloat.self,
                        of: { geometry in
                            geometry.contentOffset.y
                        },
                        action: { oldValue, newValue in
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
            .onGeometryChange(for: CGFloat.self, of: { proxy in
                proxy.size.width
            }, action: { oldValue, newValue in
                if oldValue != newValue {
                    initialOffsetY = 0
                }
            })
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Circle()
                        .foregroundStyle(Color.yellow)
                        .overlay {
                            Text("S")
                        }
                }

                ToolbarItem() {
//                    Menu {
//                        Button("Hello", action: {})
//                        Button("Hello", action: {})
//                        Button("Hello", action: {})
//                    } label: {
//                        Text("Hello")
//                    }

                    Text("Hello")
                        .contextMenu {
                            Button("Hello", action: {})
                            Button("Hello", action: {})
                            Button("Hello", action: {})
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .opacity(titleOpacity)
                }

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
            .toolbarBackground(Color.clear, for: .navigationBar)
        }
    }

    struct CustomTitleView: View {
        let title: String

        var body: some View {
            HStack(alignment: .top) {
                Image(systemName: "number")
                    .bold()
                    .font(.caption)

                VStack(alignment: .leading) {
                    Text(title)
                        .bold()

                    Text("1400 members")
                        .foregroundStyle(.secondary)
                }
                .font(.caption)

                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 4)
//            .glassEffect()
        }
    }
}

@available(iOS 26.0, *)
#Preview {
    ScrollViewForIOS26_V2()
}
