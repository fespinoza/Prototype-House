//
//  CustomSearchView.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 11/08/2022.
//

import SwiftUI

struct SearchContainer<Content: View>: View {
    @Binding var searchText: String
    @State private var isSearching: Bool = false
    @FocusState private var isTextFieldFocused: Bool
    @ViewBuilder var content: Content

    var body: some View {
        VStack {
            searchTextField

            content
        }
        .navigationBarHidden(isSearching)
    }

    var searchTextField: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)

                TextField("Search for avengers", text: $searchText)
                    .focused($isTextFieldFocused)

                if !searchText.isEmpty {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .onTapGesture(perform: resetSearch)
                }
            }
            .onTapGesture(perform: beginSearch)
            .padding(8)
            .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.black.opacity(0.1)))

            if isSearching {
                Button("Cancel", action: resetSearch)
                    .transition(.move(edge: .trailing))
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }

    func beginSearch() {
        withAnimation {
            isSearching = true
            isTextFieldFocused = true
        }
    }

    func resetSearch() {
        withAnimation {
            isSearching = false
            searchText = ""
            isTextFieldFocused = false
        }
    }
}

struct CustomSearchView: View {
    @State var searchText: String = ""

    var data: [String] {
        if searchText.isEmpty {
            return MockData.avengers
        } else {
            return MockData.avengers.filter({ $0.lowercased().contains(searchText.lowercased()) })
        }
    }

    var body: some View {
        SearchContainer(searchText: $searchText) {
            List(data, id: \.self) { name in
                Text(name)
            }
        }
    }
}

struct CustomSearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CustomSearchView()
                .navigationTitle("Avengers")
        }
//        .preferredColorScheme(.dark)
    }
}
