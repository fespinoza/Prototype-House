//
//  NavigationBarSegmentedControl.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 04/08/2023.
//

import SwiftUI

@available(iOS 16.0, *)
struct NavigationBarSegmentedControl: View {
    @State var selectedTab: Int = 0

    var body: some View {
        safeAreaApproach
    }

    var safeAreaApproach: some View {
        tabContent
            .navigationTitle("Hello")
            .navigationBarTitleDisplayMode(.inline)
            .safeAreaInset(edge: .top) {
                picker
                    .padding(.horizontal)
            }

    }

    var principalApproach: some View {
        tabContent
            .navigationTitle("Hello")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    picker
                }
            }
    }

    var tabContent: some View {
        TabView(selection: $selectedTab) {
            tabContent(color: .red, text: "Tab 1", number: 0)
            tabContent(color: .green, text: "Tab 2", number: 1)
            tabContent(color: .blue, text: "Tab 3", number: 2)
        }
        .tabViewStyle(.page)
    }

    var picker: some View {
        Picker(selection: $selectedTab.animation(), label: Text("Foo")) {
            Text("Tab 1").tag(0)
            Text("Tab 2").tag(1)
            Text("Tab 3").tag(2)
        }
        .pickerStyle(.segmented)
    }

    func tabContent(color: Color, text: String, number: Int) -> some View {
        color.overlay(content: { Text(text).font(.largeTitle).bold() }).tag(number)
    }
}

@available(iOS 16.0, *)
#Preview {
    NavigationStack {
        NavigationBarSegmentedControl()
    }
}
