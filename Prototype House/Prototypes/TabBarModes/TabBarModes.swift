import SwiftUI

struct iOS26TabbarModes: View {
    var body: some View {
        TabView {
           TabContent()
                .tabItem {
                    Label("First", systemImage: "number")
                }

            TabContent()
                .tabItem {
                    Label("Second", systemImage: "circle.hexagongrid.circle.fill")
                }
        }
        //.tint(.green)
//        .tint(Color(UIColor(dynamicProvider: {
//            print("$0.userInterfaceStyle = \($0.userInterfaceStyle)")
//            if $0.userInterfaceStyle == .dark {
//                return UIColor.systemOrange
//            } else {
//                return UIColor.systemGreen
//            }
//        })))
//        .tint(AdaptiveColor(light: .green, dark: .orange))
//        .tint(Color.tabBarAccent)
    }

    struct TabContent: View {
        var body: some View {
            ScrollView {
                ForEach(0 ..< 50) { index in
                    Rectangle()
                        .fill(index.isMultiple(of: 2) ? Color.black : Color.teal.opacity(0.2))
                        .frame(height: 164)
                        .overlay { Button("Button") {} }
                }
                .frame(maxWidth: .infinity)
            }
            .tint(.orange)
        }
    }
}

struct AdaptiveColor: ShapeStyle {
    var light: Color
    var dark: Color

    func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
        environment.colorScheme == .light ? light : dark
    }
}

#Preview {
    iOS26TabbarModes()
}
