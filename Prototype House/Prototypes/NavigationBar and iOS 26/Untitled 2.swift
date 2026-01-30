//
//  Untitled 2.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 06/10/2025.
//

import SwiftUI

// TODO: make the area on the top scroll down in the opposite direction

struct ScrollOffsetExample: View {
//    @State private var scrollPosition: CGFloat?
    @State private var scrollOffset: CGFloat = .zero
    @State private var initialOffset: CGFloat?
//    @State private var position = ScrollPosition(idType: String.self)

    let offset: CGFloat = 80

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView {
                    VStack {
                        ForEach(0..<50) { i in
                            Text("Item \(i)")
                                .frame(height: 60)
                                .frame(maxWidth: .infinity)
                                .id(CGFloat(i) * 60)
                        }
                    }
                    .background(Color.red.opacity(0.2))
                }
//                .scrollPosition($position)
                .onScrollGeometryChange(for: CGFloat?.self) { geo in
                    (geo.contentOffset.y < initialOffset ?? 0) ? geo.contentOffset.y : nil
                } action: { oldValue, newValue in
                    // clean this!

                    scrollOffset = newValue ?? 0
                    if initialOffset == nil, newValue != 0 {
                        initialOffset = newValue
                    }
                }
                .overlay(alignment: .top, content: {
                    Color.blue
                        .opacity(0.8)
                        .frame(height: offset)
                        .offset(y: max(-(scrollOffset - (initialOffset ?? 0)), 0))
                })
                .overlay(content: {
                    Text("\(scrollOffset)\n\(initialOffset)\n\(-(scrollOffset - (initialOffset ?? 0)))")
                        .padding()
                        .background(Color.purple)
                })

                .contentMargins(.top, offset, for: .scrollContent)
//                .contentMargins(.top, offset, for: .scrollIndicators)
                .navigationTitle(Text("Hello"))
//                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview {
    ScrollOffsetExample()
}
