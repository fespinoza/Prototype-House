//
//  SeachableViewModesSampleView.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 29/05/2022.
//

import SwiftUI

struct SeachableViewModesSampleView: View {
    @State var avengers: [String] = MockData.avengers
    @State var searchText: String = ""
    @State var isSearchExpanded: Bool = false

    var searchBarPlacement: SearchFieldPlacement {
        isSearchExpanded ? .navigationBarDrawer(displayMode: .always) : .navigationBarDrawer(displayMode: .automatic)
    }

    var filteredAvengers: [String] {
        guard !searchText.isEmpty else { return avengers }
        return avengers.filter { $0.contains(searchText) }
    }

    var body: some View {
        List(filteredAvengers, id: \.self) { name in
            Text(name)
        }
        .searchable(text: $searchText, placement: searchBarPlacement, prompt: "Hello")
        .navigationTitle("Avengers")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                Button(action: toggleSearchBar) {
                    Label("Search", systemImage: "magnifyingglass")
                }
            }
        }
    }

    func toggleSearchBar() {
        withAnimation {
            isSearchExpanded.toggle()
        }
    }
}

struct SeachableViewModesSampleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SeachableViewModesSampleView()
        }
    }
}
