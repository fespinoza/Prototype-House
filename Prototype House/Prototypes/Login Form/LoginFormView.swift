//
//  LoginFormView.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 25/09/2023.
//

import SwiftUI

@available(iOS 17.0, *)
@Observable
class LoginFormViewModel {
    var username: String
    var password: String
    var message: String?

    init(username: String = "", password: String = "", message: String? = nil) {
        self.username = username
        self.password = password
        self.message = message
    }

    func submit() {
        if username.isEmpty && password.isEmpty {
            message = nil
        } else {
            message = "Logged in with \(username):\(password)"
            username = ""
            password = ""
        }
    }
}

@available(iOS 17.0, *)
struct LoginFormView: View {
    @Bindable var viewModel: LoginFormViewModel = .init()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                VStack(alignment: .leading) {
                    Text("Welcome to **My App**")

                    if let message = viewModel.message {
                        Text(message)
                            .padding(4)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.green.opacity(0.2))
                            .foregroundStyle(Color.gray)
                            .cornerRadius(4)
                    }
                }

                VStack {
                    TextField("Username", text: $viewModel.username)
                        .textContentType(.username)

                    SecureField("Password", text: $viewModel.password)
                        .textContentType(.password)
                }

                Button(action: viewModel.submit) {
                    Text("Submit")
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity)
                .keyboardShortcut(.defaultAction)
            }
            .textFieldStyle(.roundedBorder)
            .padding()
        }
        .navigationTitle("Login")
    }
}

@available(iOS 17.0, *)
#Preview {
    NavigationStack {
        LoginFormView()
    }
}
