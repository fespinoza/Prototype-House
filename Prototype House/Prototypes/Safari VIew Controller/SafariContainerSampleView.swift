//
//  SafariContainerSampleView.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 24/06/2022.
//

import SwiftUI
import SafariServices

struct SafariContainerSampleView: View {
    @StateObject var viewModel = ViewModel()
    @State var presentWebpage: Bool = false

    var body: some View {
        VStack(spacing: 30) {
            Spacer()

            Text("Hello, World!")
                .font(.largeTitle.bold())

            Button(action: { presentWebpage.toggle() }) {
                Text("Show website!")
                    .padding(4)
            }
            .buttonStyle(.bordered)

            Spacer()
        }
        .sheet(isPresented: $presentWebpage) {
            websiteSheetContent()
        }
    }

    func websiteSheetContent() -> some View {
        let url = URL(string: "https://www.sats.no")!
        let config = SFSafariViewController.Configuration()

        let safari = SFSafariViewController(url: url, configuration: config)

        return DemoWrapperViewController(viewController: safari)
            .ignoresSafeArea()
    }
}

extension SafariContainerSampleView {
    class ViewModel: NSObject, ObservableObject, SFSafariViewControllerDelegate {

    }

//    SFAuthenticationSession.CompletionHandler
//    The completion handler for an authentication session when the user cancels or finishes the login.
}

struct SafariContainerSampleView_Previews: PreviewProvider {
    static var previews: some View {
        SafariContainerSampleView()
    }
}
