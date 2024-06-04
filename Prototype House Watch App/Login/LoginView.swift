//
//  LoginView.swift
//  Prototype House Watch App
//
//  Created by Felipe Espinoza on 05/10/2023.
//

import SwiftUI

// class LoginViewModel: ObservableObject {
//    @Published var username: String = ""
//    @Published var password: String = ""
//    @Published var isLoading: Bool = false
//
//    func login() {
//
//    }
// }
//
// struct LoginView: View {
//    @StateObject var viewModel: LoginViewModel = .init()
//
//    var body: some View {
//        ScrollView {
//            VStack {
//                TextField("Email or Member ID", text: $viewModel.username)
//                    .textContentType(.username)
//                    .multilineTextAlignment(.center)
//
//                SecureField("Password", text: $viewModel.password)
//                    .textContentType(.password)
//                    .multilineTextAlignment(.center)
//
//                Button(action: login, label: {
//                    if viewModel.isLoading {
//                        ProgressView()
//                    } else {
//                        Text("Sign in")
//                    }
//                })
//                .buttonStyle(.borderedProminent)
//
//            }
//        }
//        .toolbar {
//            ToolbarItem(placement: .primaryAction) {
//                Image(.logoSmall)
//            }
//        }
//    }
//
//    func login() {
//        viewModel.isLoading.toggle()
//    }
// }

#Preview {
    NavigationView {
        LoginView()
    }
}
