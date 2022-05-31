//
//  SearchableModifierSampleView.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 29/05/2022.
//

import SwiftUI

struct SearchableModifierSampleView: View {
    @State var avengers: [String] = MockData.avengers
    @State var searchText: String = ""


    var filteredAvengers: [String] {
        guard !searchText.isEmpty else { return avengers }
        return avengers.filter { $0.contains(searchText) }
    }

    var body: some View {
        Content(content: filteredAvengers)
            .searchable(text: $searchText)
            .navigationTitle("Avengers")
            .navigationBarTitleDisplayMode(.inline)
    }

    struct Content: View {
        let content: [String]
        @Environment(\.isSearching) var isSearching
        @State var extraMessage: Bool = false

        var body: some View {
            VStack {
                List(content, id: \.self) { name in
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .opacity(isSearching ? 1.0 : 0)
                        Text(name)
                        Spacer()
                    }
                }

                Text(isSearching ? "Searching" : "Not searching")

                if extraMessage {
                    Text("`isSearching` changed!")
                }
            }
            .onChange(of: isSearching) { [isSearching] newValue in
                extraMessage = isSearching != newValue
            }
        }
    }
}

struct SearchableModifierSampleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SearchableModifierSampleView()
        }
    }
}
