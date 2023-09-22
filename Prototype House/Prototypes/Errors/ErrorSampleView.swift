//
//  ErrorSampleView.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 29/08/2023.
//

import SwiftUI
import SamplePackage

enum SampleCustomError: Error {
    case singleError
    case multipleError
}

enum SampleLocalizeError: String, LocalizedError {
    case initialCase
    case somethingElse
}

enum SampleThirdError: Error, LocalizedError {
    case anotherOne
    case bitesTheDust

    var errorDescription: String? {
        switch self {
        case .anotherOne: String(localized: "Another Error", comment: "Error message")
        case .bitesTheDust: String(localized: "Bites the dust", comment: "Error message")
        }
    }
}

enum SampleFourthError: String, LocalizedError {
    case initialCase
    case somethingElse

    var errorDescription: String? {
        String(localized: .init(stringLiteral: rawValue), comment: "Fourth Error")
    }
}

struct ErrorSampleView: View {
    var anotherMessage: String {
        String(localized: "Foo bar", comment: "asdf")
    }

    var body: some View {
        VStack {
            Text("Hello, world!")

            Text(anotherMessage)

            Text(SampleCustomError.singleError.localizedDescription)

            Text(SampleLocalizeError.initialCase.localizedDescription)

            Text(SampleThirdError.anotherOne.localizedDescription)

            Text(SampleFourthError.somethingElse.localizedDescription)

            Text(NetworkingError.serverError.localizedDescription)
        }
    }
}

#Preview {
    ErrorSampleView()
        .environment(\.locale, .init(identifier: "es"))
}
