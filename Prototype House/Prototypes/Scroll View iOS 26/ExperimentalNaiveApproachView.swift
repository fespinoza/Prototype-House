import SwiftUI

@available(iOS 26.0, *)
struct ExperimentalNaiveNavBarColorView: View {
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    Color(uiColor: .lightGray)
                        .frame(height: 400)

                    Color.white
                        .frame(height: 2000)
                }
            }
            .ignoresSafeArea()
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
            // only this sets the background for the standard appearance
//            .toolbarBackground(Color.blue, for: .navigationBar)

            // this sort of works, but "stains" the navigation effect
//            .background(
//                VStack(spacing: 0) {
//                    Color.teal
//                    Color.blue
//                }
//                .ignoresSafeArea()
//            )
        }
    }
}

@available(iOS 26.0, *)
#Preview {
    ExperimentalNaiveNavBarColorView()
}
