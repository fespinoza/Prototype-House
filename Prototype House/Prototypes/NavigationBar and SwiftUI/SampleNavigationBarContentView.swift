//
//  SampleNavigationBarContentView.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 05/07/2022.
//

import SwiftUI

struct SampleNavigationBarContentView: View {
    var body: some View {
        ScrollView {
            VStack {
                Color.blue
                    .frame(height: 50)

                LongContent()
            }
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity)
        .background(
            // by default in iOS 15 this expands behind the bar
//            Color.red
        )
        .navigationTitle("Simple Title")
        .navigationBarTitleDisplayMode(.inline)
//        .onAppear(perform: customizeUIkitNavigationBarAppearance)
    }

    func customizeUIkitNavigationBarAppearance() {
//        UINavigationBar.appearance().isTranslucent = true

        let customAppearance = UINavigationBarAppearance()
        customAppearance.configureWithTransparentBackground()
        customAppearance.titleTextAttributes = [.foregroundColor: UIColor.yellow]
        customAppearance.backgroundColor = .cyan

        UINavigationBar.appearance().standardAppearance = customAppearance
    }
}

struct PictureScrollableContentView: View {
    let imageHeight: CGFloat = 250

    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { proxy in
                Image("tedLassoBanner")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: proxy.size.width, height: imageHeight)
            }

            ScrollView {
                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: imageHeight)

                    SampleNavigationBarContentView.LongContent()
                        .background(Color.gray)
                }
//                .background(Color.red)
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Ted lasso")
        .onAppear {

            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.clear]
//            let standard = UINavigationBarAppearance()
//            standard.configureWithDefaultBackground()
//            UINavigationBar.appearance().standardAppearance = standard
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
        .background(Color.gray)
    }
}

extension SampleNavigationBarContentView {
    struct LongContent: View {
        var body: some View {
            VStack {
                Text("Top of the content")

                Spacer()

                Text("Middle")

                Spacer()

                Text("Bottom of the content")
            }
            .frame(maxWidth: .infinity, minHeight: 1600)
        }
    }
}


// reference: https://www.bigmountainstudio.com/community/public/posts/80041-how-do-i-customize-the-navigationview-in-swiftui

struct NavBar_ScreenBackgroundColor: View {
    let gradient = LinearGradient(colors: [Color.orange,Color.green],
                                  startPoint: .top, endPoint: .bottom)
    var body: some View {
        NavigationView {
            ZStack {
                gradient
                    .opacity(0.25)
                    .ignoresSafeArea()

                VStack {
                    Text("Background colors can be seen behind the NavigationView")
                        .padding()
                    Spacer()
                }
                .navigationTitle("Screen Background")
                .font(.title2)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


struct NavBar_BackgroundColor: View {
    var body: some View {
        NavigationView {
            ZStack {
                // this is just the color for the content's background
                Color.blue
                    .opacity(0.1)
                    .ignoresSafeArea()

                VStack {
                    // setting the background color of the nav bar
                    Rectangle()
                        .frame(height: 0)
                        .background(Color.blue.opacity(0.2))

                    Text("Have the style touching the safe area edge.")
                        .padding()

                    Spacer()
                }
                .font(.title2)
            }
            .navigationTitle("Nav Bar Background")
        }
    }
}

struct NavBar_BackgroundColor_Material: View {
    var body: some View {
        NavigationView {
            ZStack {
                // content background
                Color.green
//                    .opacity(0.1)
                    .ignoresSafeArea()

                VStack {
                    // material background for the navigation bar
                    Divider()
                        .background(.thinMaterial)

                    Text("Have the style touching the safe area edge.")
                        .padding()

                    Spacer()
                }
                .navigationTitle("Nav Bar Background")
                .font(.title2)
            }
        }
    }
}

struct NavBar_BackgroundColor_Gradient: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.green
                    .opacity(0.1)
                    .ignoresSafeArea()

                VStack {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 10)
                        .background(
                            LinearGradient(
                                colors: [.green.opacity(0.3), .blue.opacity(0.5)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )

                    Text("Have the style touching the safe area edge.")
                        .padding()

                    Spacer()
                }
                .navigationTitle("Nav Bar Background")
                .font(.title2)
            }
        }
    }
}

struct NavBar_WithList: View {
    var body: some View {
        NavigationView {
            imageStyle
        }
    }
    let imageHeight: CGFloat = 300

    var imageStyle: some View {
        ZStack(alignment: .top) {
//            Rectangle()
//                .background(Color.red)
//                .frame(height: 0)
            Image("tedLassoBanner")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: imageHeight)

            ScrollView {
                VStack(spacing: 0) {
                    Spacer().frame(height: imageHeight)

                    ForEach(0 ..< 15) { item in
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.orange)
                            .frame(height: 44)
                            .padding()
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationTitle("List & NavView")
    }

    var noTopBackground: some View {
        VStack(spacing: 0) {
            ScrollView {
                ForEach(0 ..< 15) { item in
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.orange)
                        .frame(height: 44)
                        .padding()
                }
            }
        }
        .navigationTitle("List & NavView")
    }

    var oldBody: some View {
        NavigationView {
            VStack(spacing: 0) {
                // seting the background color of the nav bar
                Divider()
                    .background(Color.blue.opacity(1.0))

                ScrollView {
                    ForEach(0 ..< 15) { item in
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.orange)
                            .frame(height: 44)
                            .padding()
                    }
                }
            }
            .navigationTitle("List & NavView")
        }
    }
}

struct NavBar_WithListScrollBehind: View {
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    ForEach(0 ..< 15) { item in
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.orange)
                            .frame(height: 44)
                            .padding()
                    }
                }
            }
            .navigationTitle("List & NavView")
        }
        .onAppear {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            appearance.backgroundColor = UIColor(Color.orange.opacity(0.2))
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

struct NavBar_WithListScrollBehind_InlineToo: View {
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    ForEach(0 ..< 15) { item in
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.orange)
                            .frame(height: 44)
                            .padding()
                    }
                }
            }
            .navigationTitle("List & NavView")
        }
        .onAppear {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            appearance.backgroundColor = UIColor(Color.orange.opacity(0.2))

            // Inline appearance (standard height appearance)
            UINavigationBar.appearance().standardAppearance = appearance
            // Large Title appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

struct SampleNavigationBarContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SampleNavigationBarContentView()
        }

        NavigationView {
            PictureScrollableContentView()
        }

//        NavBar_ScreenBackgroundColor()

//        NavBar_BackgroundColor()

//        NavBar_BackgroundColor_Material()

//        NavBar_BackgroundColor_Gradient()

        NavBar_WithList()
            .previewDisplayName("Always Big")

//        NavBar_WithListScrollBehind()
//            .previewDisplayName("To Inline")
//
//        NavBar_WithListScrollBehind_InlineToo()
    }
}
