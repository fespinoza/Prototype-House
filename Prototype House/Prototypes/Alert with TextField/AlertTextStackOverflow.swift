import SwiftUI

// taken from: https://swiftuirecipes.com/blog/swiftui-alert-with-textfield
// then adapted by me

public struct TextAlertViewData {
    /// Alert's title
    public var title: String
    public var message: String
    public var placeholder: String = ""
    /// Content for the text field
    public var text: String? = nil
    public var confirm: String = "OK"
    public var cancel: String = "Cancel"
    public var keyboardType: UIKeyboardType = .default
    // Triggers when either of the two buttons closes the dialog
    public var action: (String?) -> Void
}

extension UIAlertController {
    convenience init(alertViewData: TextAlertViewData) {
        self.init(title: alertViewData.title, message: alertViewData.message, preferredStyle: .alert)

        addTextField { textField in
            textField.placeholder = alertViewData.placeholder
            textField.text = alertViewData.text
            textField.keyboardType = alertViewData.keyboardType
        }

        addAction(
            UIAlertAction(title: alertViewData.cancel, style: .cancel) { _ in
                alertViewData.action(nil)
            }
        )

        let textField = self.textFields?.first
        addAction(UIAlertAction(title: alertViewData.confirm, style: .default) { _ in
            alertViewData.action(textField?.text)
        })
    }
}

struct AlertWrapper<Content: View>: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    let alertViewData: TextAlertViewData
    let content: Content

    func makeUIViewController(context: Context) -> UIHostingController<Content> {
        UIHostingController(rootView: content)
    }

    func updateUIViewController(_ uiViewController: UIHostingController<Content>, context: Context) {
        uiViewController.rootView = content

        if isPresented && uiViewController.presentedViewController == nil {
            var alert = self.alertViewData
            alert.action = {
                self.isPresented = false
                self.alertViewData.action($0)
            }

            context.coordinator.alertController = UIAlertController(alertViewData: alert)
            uiViewController.present(context.coordinator.alertController!, animated: true)
        }

        if !isPresented && uiViewController.presentedViewController == context.coordinator.alertController {
            uiViewController.dismiss(animated: true)
        }
    }

    final class Coordinator {
        var alertController: UIAlertController?

        init(_ controller: UIAlertController? = nil) {
            self.alertController = controller
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
}

extension View {
    public func alert(isPresented: Binding<Bool>, alert: TextAlertViewData) -> some View {
        AlertWrapper(isPresented: isPresented, alertViewData: alert, content: self)
    }
}

struct SOAlertWithTextFieldSampleView: View {
    @State var presentAlert: Bool = false
    @State var text: String = ""

    var body: some View {
        VStack(spacing: 10) {
            Text("Alert Experiment")
                .font(.title.bold())

            Text(text)

            Button("Push me", action: { presentAlert.toggle() })
                .buttonStyle(.borderedProminent)
        }
        .alert(
            isPresented: $presentAlert,
            alert: .init(
                title: "Hello World",
                message: "new title",
                text: text,
                action: { content in
                    if let content = content {
                        text = content
                    }
                }
            )
        )
    }
}

struct SOAlertWithTextFieldSampleView_Previews: PreviewProvider {
    static var previews: some View {
        SOAlertWithTextFieldSampleView()
    }
}
