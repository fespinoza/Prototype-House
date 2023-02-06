//
//  CheckScrollVisibleContentView.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 24/05/2022.
//

import SwiftUI

struct CheckScrollVisibleContentView: View {
    @State var selectedLetter: String
    @State var content: [String]

    init() {
//        let content: [String] = (1...100).map { String(format: "%02d", $0) }
        let content: [String] = [
            "A", "B", "C", "D", "E", "F", "G", "H", "I",
            "J", "K", "L", "M", "N", "O", "P", "Q", "R",
            "S", "T", "U", "V", "W", "X", "Y", "Z",
        ]

        self._content = .init(initialValue: content)
        self._selectedLetter = .init(initialValue: content.first ?? "")
    }

    @State var screenWidth: CGFloat = 1
    let elementSpacing: CGFloat = 2
    let elementSize: CGFloat = 48
    var numberOfElements: Int { content.count }

    var visibleRect: CGRect {
        let correctedOffset = -offset
        return CGRect(
            x: correctedOffset,
            y: 0,
            width: screenWidth,
            height: elementSize
        )
    }

    var visibleContent: [String] {
        let numberOfSpaces = numberOfElements - 1
        let totalWidth = elementSpacing * CGFloat(numberOfSpaces) + elementSize * CGFloat(numberOfElements)

        let foo = content.enumerated().filter { index, element in
            let elementOrigin: CGFloat = CGFloat(index) * elementSize + CGFloat(index) * elementSpacing
            let elementRect = CGRect(x: elementOrigin, y: 0, width: elementSize, height: elementSize)

            return visibleRect.intersects(elementRect)
        }
        .map { $1 }

        return foo
    }

    @State var scrollToLetter: String?

    @State var offset: CGFloat = 0

    var body: some View {
        VStack {
            GeometryReader { geometryProxy in
                ScrollViewOffsetReader(.horizontal, scrollValue: $offset) {
                    //                ScrollView(.horizontal) {
                    ScrollViewReader { proxy in
                        LazyHStack(spacing: elementSpacing) {
                            ForEach(content, id: \.self) { letter in
                                Text(letter)
                                //                                .bold()
                                    .font(.caption)
                                    .foregroundColor(letter == selectedLetter ? .blue : .black)
                                    .padding()
                                    .id("text-\(letter)")
                                    .frame(width: elementSize, height: elementSize)
                                    .background(letter == selectedLetter ? Color(white: 0.75) : Color(white: 0.9))
                                    .onTapGesture {
                                        selectedLetter = letter
                                    }
                                //                                .onAppear(perform: {
                                //                                    visibleLetters.append(letter)
                                //                                    outLetters.removeAll(where: { $0 == letter })
                                //                                })
                                //                                .onDisappear(perform: {
                                //                                    visibleLetters.removeAll(where: { $0 == letter })
                                //                                    outLetters.append(letter)
                                //                                })
                            }
                        }
                        .frame(height: elementSize)
                        .onChange(of: selectedLetter, perform: { newValue in
                            proxy.scrollTo("text-\(newValue)")
                        })
                        .onChange(of: scrollToLetter, perform: { newValue in
                            if let newValue {
                                withAnimation {
                                    proxy.scrollTo("text-\(newValue)")
                                }
                            }
                        })
                    }
                }
                .onAppear(perform: { screenWidth = geometryProxy.size.width })
            }
            .frame(height: elementSize)

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

            Text("Offset: \(offset)")
            Text("ScreenWidth: \(screenWidth)")
            Text("Visible Rect: \(visibleRect.debugDescription)")
            Text("Visible: \(visibleContent.joined(separator: "."))")

//            visibleDebug

            Button("Scroll To Current Letter") {
                withAnimation {
                    scrollToLetter = selectedLetter
                }
            }
        }
    }

    // MARK: - LazyHStack visible debugging

    @State var visibleLetters: [String] = []
    @State var outLetters: [String] = []

    var visibleDebug: some View {
        VStack {
            Text("Visible Letters (\(visibleLetters.count)): \(visibleLetters.sorted().joined(separator: "."))")
            Text("Invisible Letters: \(outLetters.sorted().joined(separator: "."))")

            Button("Clear") {
                visibleLetters = []
                outLetters = []
            }

        }
    }
}

struct CheckScrollVisibleContentView_Previews: PreviewProvider {
    static var previews: some View {
        CheckScrollVisibleContentView()
    }
}
