import SwiftUI

struct NavBarForIOS26: View {
    let title: String

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Color.blue
                        .frame(height: 400)
                        .overlay(alignment: .bottom) {
                            Image("gymSample2")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 200)
                                .frame(maxWidth: .infinity)
                        }
                        .clipped()

                    SampleNavigationBarContentView.LongContent()
                        .overlay(alignment: .top, content: {
                            Color.white
                                .frame(height: 150)
                                .offset(y: 150)
                        })

                        .overlay {
                            NavigationLink {
                                NavBarForIOS26(title: "Child Content")
                            } label: {
                                Text("Next page")
                            }
                            .buttonStyle(.borderedProminent)
                        }
                }
                .background(Color(uiColor: UIColor.systemBackground))
            }
            // 🟢 this sets a tint for the header
            .containerBackground(for: .navigation, content: { background })
            .ignoresSafeArea(edges: .top)
            .navigationTitle(Text(title))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {

                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward.circle.fill")
                            .foregroundStyle(Color.white)
                            .font(.title)
                    }
                }


                ToolbarItem(placement: .primaryAction) {
                    Button("Hi", systemImage: "bell.badge", action: {})
                }

                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Hi", systemImage: "person", action: {})
                }


                ToolbarItem(placement: .principal) {
//                    Image(systemName: "s.circle.fill")
//                        .font(Font.title)

                    Image(.randoms)
                        // using the image as template
                        .renderingMode(.template)
                        .foregroundStyle(Color.tabBarAccent)
                }
            }
        }
    }

    var background: some View {
        VStack {
            Color.blue
                .frame(height: 400)

            Spacer()
        }
    }
}

#Preview {
    NavBarForIOS26(title: "Main Content")
}

/*

 - the principal image adapts to light/dark mode, maybe because it a custom SF symbol. Would it work with a custom one?

 - ✅ back button title works when replacing the principal item

 */
