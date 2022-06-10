//
//  AlertWithTextFieldSampleView.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 31/05/2022.
//

import SwiftUI

struct AlertWithTextFieldSampleView: View {
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
//        .overlay(
//            Group {
//                if presentAlert {
//                    AlerViewControllerAdapter { newText in
//                        text = newText
//                    }
//                }
//            }
//        )
    }
}

struct AlerViewControllerAdapter: UIViewControllerRepresentable {
    var onSubmit: (String) -> Void

    init(onSubmit: @escaping (String) -> Void = { _ in }) {
        self.onSubmit = onSubmit
    }

    func makeUIViewController(context: Context) -> UIAlertController {
        let viewController = UIAlertController(
            title: "Title",
            message: "Message",
            preferredStyle: .alert
        )
        viewController.addTextField { textField in
            textField.placeholder = "New text"
        }
        viewController.addAction(
            .init(title: "OK", style: .default, handler: { [weak viewController] action in
                let text = viewController?.textFields?.first?.text ?? ""
                onSubmit(text)
            })
        )
        viewController.addAction(
            .init(title: "Nah", style: .cancel)
        )

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIAlertController, context: Context) {
        uiViewController.textFields?.first?.becomeFirstResponder()
    }
}

struct AlertWithTextFieldSampleView_Previews: PreviewProvider {
    static var previews: some View {
        AlertWithTextFieldSampleView()
    }
}
