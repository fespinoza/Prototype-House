import SwiftUI

/*

 Ideas:
 - ZStack with nested ScrollView ✅
 - Custom navigation bar element that fills the width and has text left aligned ❌✅
    - .infinity doesn't work, a fixed sizes does though

 ## Challenges

 - [x] what's the initial offset position?
 - [~] what should be the title width?
    - i have an approximation
 - [ ]

 */


@available(iOS 26.0, *)
struct ScrollViewForIOS26: View {
    @State var offsetY: CGFloat = 0
    @State var initialOffsetY: CGFloat = 0 // 116
    @State var customTitleWidth: CGFloat = 180 // 200
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
                    //            .overlay(alignment: .top) {
                    //                Color.blue
                    //                    .frame(height: 120)
                    //                    .offset(y: -offsetY - 120)
                    //                    .ignoresSafeArea(.container, edges: .top)
                    //            }
                    //            .scrollClipDisabled(true)
                    //            .onScrollPhaseChange({ oldPhase, newPhase in })

//                    .onScrollVisibilityChange(threshold: 0.2, { _ in
//                    })
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

                    //            .scrollBounceBehavior(.basedOnSize)

                    //            .scrollContentBackground(.hidden)


                    //            .defaultScrollAnchor(.init(x: 0, y: 0.2))
                    //            .background(Color.purple)
                    //                .navigationTitle("Hi")
                    //                .toolbarTitleDisplayMode(.inline)
                }
            }
            .overlay {
                Text("\(offsetY)\n\(barOffset)\n\(initialOffsetY)\n\(customTitleWidth)")
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
                    customTitleWidth = newValue * 0.5
                }
            })
            .toolbarTitleDisplayMode(.inline)
//            .toolbarTitleMenu(content: {})
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Circle()
                        .foregroundStyle(Color.yellow)
                        .overlay {
                            Text("S")
                        }
                }

                //                ToolbarItem(placement: .topBarLeading) {
                //                    Text("Hello World")
                //                }
                //                .sharedBackgroundVisibility(.hidden)

                ToolbarItem() {
//                    Button(action: {}) {
                        Text("Hello")
//                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .background(Color.yellow)
//                        .frame(width: customTitleWidth, alignment: .leading)
//                    CustomTitleView(title: "Hello")
//                        .glassEffect()
                        .opacity(titleOpacity)
                }
                .sharedBackgroundVisibility(.hidden)

                ToolbarSpacer(.fixed)

//                ToolbarSpacer(.flexible, placement: .principal)

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

    /*

     

     */

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
    ScrollViewForIOS26()
}
