//
//  CheckScrollVisibleContentView.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 24/05/2022.
//

import SwiftUI

struct CheckScrollVisibleContentView: View {
    @State var selectedLetter: String = "A"
    @State var content: [String] = [
        "A", "B", "C", "D", "E", "F", "G", "H", "I",
        "J", "K", "L", "M", "N", "O", "P", "Q", "R",
        "S", "T", "U", "V", "W", "X", "Y", "Z",
    ]
    @State var scrollToLetter: String?

    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                ScrollViewReader { proxy in
                    HStack(spacing: 2) {
                        ForEach(content, id: \.self) { letter in
                            Text(letter)
                                .bold()
                                .foregroundColor(letter == selectedLetter ? .blue : .black)
                                .padding()
                                .id("text-\(letter)")
                                .frame(width: 48)
                                .background(letter == selectedLetter ? Color(white: 0.75) : Color(white: 0.9))
                                .onTapGesture {
                                    selectedLetter = letter
                                }
                        }
                    }
                    .onChange(of: selectedLetter, perform: { newValue in
                        proxy.scrollTo("text-\(newValue)")
                    })
                }
            }

            TabView(selection: $selectedLetter) {
                ForEach(content, id: \.self) { letter in
                    VStack {
                        Spacer()

                        Text("\"\(letter)\"")
                            .bold()
                        Text("content")

                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color(white: 0.85))
                    .tag(letter)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))

            Button("Scroll To Current Letter") {
                scrollToLetter = selectedLetter
            }
        }
    }
}

struct CheckScrollVisibleContentView_Previews: PreviewProvider {
    static var previews: some View {
        CheckScrollVisibleContentView()
    }
}
