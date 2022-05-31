import SwiftUI

struct ImageWithTitleContentView: View {
    let title: String = "Hello World"
    let text: String = "It is a long established fact that a reader will be distracted by the readable content"

    @State var offset: CGFloat = 0
    @State var size: CGSize = .zero
    @State var rect: CGRect = .zero

    var imageHeight: CGFloat {
        max(280, 280 + offset)
    }

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                VStack(spacing: 0) {
                    Image("london")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: imageHeight)
                        .frame(minWidth: proxy.size.width)
                        .opacity(0.5)
                        .background(Color.blue)

                    Color(UIColor.lightGray)
                }

                ScrollReaderView(scrollValue: $offset) {
                    ScrollView {
                        VStack {
                            Spacer()
                                .frame(width: proxy.size.width, height: imageHeight)

                            VStack(alignment: .leading, spacing: 20) {
                                Text(title)
                                    .font(.largeTitle)
                                    .bold()
                                    .padding(.horizontal)
                                    .sizeReader { size in
                                        self.size = size
                                    }
                                    .background(
                                        GeometryReader { newProxy in
                                            Color.orange
                                                .onAppear {
                                                    rect = newProxy.frame(in: CoordinateSpace.global)
                                                }
                                        }
                                    )
                                    .padding(.top, 20)

                                Text(text)
                                    .font(.body)
                                    .padding(.horizontal)

                                Spacer()

                                HStack {
                                    Spacer()
                                    Text("More content down 👇")
                                    Spacer()
                                }
                                .padding()

                                Spacer()

                                HStack {
                                    Spacer()

                                    Button("Sumbit", action: {})
                                        .buttonStyle(.borderedProminent)

                                    Spacer()
                                }
                                .padding(.top, 500)
                                .padding(.bottom, 50)
                            }
                            .background(Color(UIColor.lightGray))
                        }
                    }
                }
            }
        }
        .overlay(debugArea)
        .ignoresSafeArea()
    }

    var debugArea: some View {
        VStack(alignment: .leading) {
            Spacer()

            HStack {
                VStack(alignment: .leading) {
                    Text("offset")
                        .font(.footnote)
                    Text(offset.rounded(), format: .number)
                }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)

                Spacer()

            }

            HStack {
                VStack(alignment: .leading) {
                    Text("rect")
                        .font(.footnote)
                    Text("\(rect.origin.x.rounded()) - \(rect.origin.y.rounded())  - \(rect.size.width.rounded()) - \(rect.size.height.rounded())")
                }
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)

                Spacer()

            }

            Spacer()
        }
    }
}

struct ImageWithTitleContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ImageWithTitleContentView()
        }
    }
}
