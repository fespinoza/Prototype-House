//
//  LocalizationSampleView.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 30/05/2022.
//

import SwiftUI

struct LocalizationSampleView: View {
    @Environment(\.locale) var locale

    let secretMessage: String = NSLocalizedString("mySecretMessage", comment: "Foo bar")
    let titleKey: String = "myCustomMessage"

    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Text("myCustomMessage")
                .font(.title.bold())

            Text("mySecretMessage")
                .multilineTextAlignment(.center)

            // this is not being localized
            Text(secretMessage)
                .foregroundColor(.blue)

            // this is not being localized
            Text(LocalizedStringKey(secretMessage))
                .foregroundColor(.purple)

            Text(LocalizedStringKey("myCustomMessage"))

            Text(LocalizedStringKey(titleKey))
                .foregroundColor(.orange)

            HStack {
                Spacer()

                Text(locale.identifier)

                Text(Locale.current.identifier)
                    .foregroundColor(.red)

                Spacer()
            }
            .font(.caption.bold())
        }
    }
}

struct LocalizationSampleView_Previews: PreviewProvider {
    static var previews: some View {
        return Group {
            LocalizationSampleView()

            LocalizationSampleView()
                .environment(\.locale, .init(identifier: "es"))

            LocalizationSampleView()
                .environment(\.locale, .init(identifier: "nb"))
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
