//
//  LocalizationFromPackage.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 06/07/2023.
//

import SwiftUI
import SamplePackage

struct LocalizationFromPackage: View {
    @Environment(\.locale) var locale
    
    var body: some View {
        NavigationView {
            List {
                Text(locale.debugDescription).bold()

                Text(Locale.current.debugDescription)

                CustomLoadingView()

                ForEach(NetworkingError.allCases, id: \.self) { error in
                    // this text coming from the package
                    // is using the string catalog,
                    // but it's using the english one only
                    Text(error.localizedDescription)
                }
            }
            // this actually gets localized
            .navigationTitle("Network Errors")
        }
    }
}

struct LocalizationFromPackage_Previews: PreviewProvider {
    static var previews: some View {
        LocalizationFromPackage()
            .environment(\.locale, .init(identifier: "es"))
    }
}
