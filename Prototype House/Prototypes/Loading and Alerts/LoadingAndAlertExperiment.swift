import SwiftUI

struct LoadingAndAlertExperiment: View {
    @State var isLoading: Bool = false
    @State var confirm: Bool = false
    @State private var alertData: AlertData? = nil
    @State var count: Int = 0

    var body: some View {
        VStack(spacing: 16) {
            Menu {
                Button("Async operation", action: asyncOperation)
                Button("Confirm, then async", action: confirmThenAsync)
            } label: {
                if isLoading {
                    ProgressView()
                } else {
                    Text("Options")
                }
            }
            .buttonStyle(.borderedProminent)

            Text("Async Actions: \(count)")
        }
        .alert(for: $alertData)
//        .alert("Confirm Action", isPresented: $confirm) {
//            Button("Cancel", role: .cancel, action: {})
//            Button("Hell yeah", action: asyncOperation)
//        }
    }

    func asyncOperation() {
        Task {
            isLoading = true
            try await Task.sleep(for: .seconds(2))
            count += 1
            isLoading = false
        }
    }

    func confirmThenAsync() {
//        confirm.toggle()
        alertData = .init(
            title: "Confirm Async Action",
            message: "Yeah, we need your permission to do this.",
            actionTitle: "Do the thing",
            action: asyncOperation
        )
    }
}

#Preview {
    LoadingAndAlertExperiment()
}

private struct AlertData {
    let title: String
    let message: String
    let actionTitle: String
    let action: () -> Void
}

private extension Binding where Value == AlertData? {
    var presence: Binding<Bool> {
        .init(
            get: { wrappedValue != nil },
            set: { newValue in
                if newValue {
                    // do nothing
                } else {
                    wrappedValue = nil
                }
            }
        )
    }
}

private extension View {
    func alert(for alertData: Binding<AlertData?>) -> some View {
        alert(
            Text(alertData.wrappedValue?.title ?? "None"),
            isPresented: alertData.presence,
            presenting: alertData.wrappedValue) { alertData in
                Button("Cancel", role: .cancel, action: {})
                Button(alertData.actionTitle, action: alertData.action)
            } message: { alertData in
                Text(alertData.message)
            }

    }
}
