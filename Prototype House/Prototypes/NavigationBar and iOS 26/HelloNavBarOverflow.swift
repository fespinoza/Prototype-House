import SwiftUI

struct HelloNavBarOverflow: View {
    var body: some View {
        Text("Hello, World!")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Hola Mundo")
                        .frame(width: 200)
                        .background(Color.red.opacity(0.2))
                }

                ToolbarItemGroup(placement: .topBarTrailing) {
//                    HStack(spacing: 4) {
                        notificationButton
                        profileButton
//                    }
                }
            }
    }

    var profileButton: some View {
        Button(action: {}) {
            Label("Profile", systemImage: "person.circle")
        }
    }

    var notificationButton: some View {
        Button(action: {}) {
            Label("Notifications", systemImage: "bell")
        }
    }
}

#Preview {
    NavigationStack {
        HelloNavBarOverflow()
    }
}
