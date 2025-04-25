import SwiftUI

struct NavBarStylingDemoView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                SampleNavigationBarContentView.LongContent()
//                    .background(
//                        LinearGradient(
//                            colors: [.red, .blue],
//                            startPoint: .init(x: 0, y: 0),
//                            endPoint: .init(x: 0, y: 1.0)
//                        )
//                    )
                    .background(Color.red)
                    .overlay(alignment: .bottom) {
                        NavigationLink {
                            SampleNavigationBarContentView.LongContent()
                                .navigationTitle("Child Screen")
                        } label: {
                            Text("Next")
                        }
                        .buttonStyle(.borderedProminent)
                    }
            }
//            .navigationTitle(Text("Content"))
            .navigationTitle(Text("A very long title that can be truncated"))
            .navigationBarTitleDisplayMode(.inline)
//            .onAppear {
//                styleNavigationBar()
//            }
            .invisibleScrollEdgeTitle()
            .background(
                Color.orange
            )
//            .toolbar {
//                ToolbarItem(placement: .navigation) {
//                    Text("A very long title that can be truncated")
//                        .lineLimit(nil)
//                        .font(.largeTitle.bold())
//                        .border(Color.blue)
//                        .multilineTextAlignment(.center)
//                        .fixedSize(horizontal: false, vertical: true)
//                        .background(Color.green)
//                }
//            }
            .toolbarBackground(.blue) // standard appearance background
//            .toolbarTitleMenu { // standard appearance menu
//                Text("Foo")
//            }
//            .toolbarTitleDisplayMode(.inlineLarge)
//            .toolbarTitleDisplayMode(.large)
//            .toolbarTitleDisplayMode(.inline)
//            .toolbarTitleDisplayMode(.automatic)
        }
    }

    func styleNavigationBar() {
//        UINavigationBar.appearance().largeTitleTextAttributes = [
//            .foregroundColor: UIColor.clear
//        ]
    }
}

#Preview {
    NavBarStylingDemoView()
}
