//
//  SlackNavigationBarStyle.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 06/01/2026.
//

import SwiftUI

@available(iOS 26.0, *)
struct SlackNavigationBarStyle: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                content
                    .background(Color.white)
            }
            .toolbar {
                logo
                trailing
            }
//            .toolbarBackground(.visible, for: .navigationBar)
//            .toolbarBackground(Color.purple, for: .navigationBar)
            .background(
                VStack(spacing: 0) {
                    Color.teal
                    Color.blue
                }
                .ignoresSafeArea()
            )
            .overlay(alignment: .topLeading) {
                Text("Crafting Swift")
                    .padding(.leading)
                    .padding(.top)
                    .ignoresSafeArea(.container, edges: .top)
            }
        }
    }

    @ToolbarContentBuilder var logo: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Color.blue
                .frame(width: 32, height: 32)
                .overlay { Text("C") }
                .clipShape(.circle)
                .contentShape(.circle)
        }
    }

    @ToolbarContentBuilder var trailing: some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing) {
            Button(action: {}) {
                Label("Filter", systemImage: "line.horizontal.3.decrease")
            }

            Button(action: {}) {
                Image(.sampleAvatar)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32, height: 32)
                    .clipShape(.circle)
            }
        }
    }

    var content: some View {
        VStack(alignment: .leading, spacing: 24) {
            section(
                title: "External Connections",
                items: [
                    .lock("external-provider"),
                    .lock("project-poc")
                ]
            )

            Divider()

            section(
                title: "Starred",
                items: [
                    .channel("development-team"),
                    .channel("app-team"),
                    .channel("ios-team"),
                    .lock("internal-app-team")
                ]
            )

            Divider()

            section(
                title: "Channels",
                items: [
                    .channel("discover"),
                    .channel("app-store-reviews"),
                    .channel("books"),
                    .channel("coffee-machine"),
                ]
            )

            Divider()

            section(
                title: "Others",
                items: [
                    .channel("all groups"),
                    .channel("runs"),
                    .channel("gaming"),
                    .channel("sports"),
                    .channel("new-recruits"),
                    .channel("alerts"),
                    .channel("new-releases"),
                    .channel("research"),
                ]
            )

            Divider()

            section(
                title: "Team Members",
                items: [
                    .person("Ali"),
                    .person("Snadre Mogens"),
                    .person("Sicily"),
                    .person("Zara"),
                    .person("Robert"),
                    .person("Paul"),
                    .person("Guy"),
                ]
            )
        }
        .padding()
        .background(Color.red.opacity(0.2))
    }

    func section(title: String, items: [RowItem]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title)
                    .font(.footnote.bold())
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundStyle(.secondary)
            }

            ForEach(items) { item in
                HStack(spacing: 12) {
                    Image(systemName: item.icon)
                        .foregroundStyle(.secondary)

                    Text(item.title)

                    Spacer()
                }
                .padding(.vertical, 4)
            }
        }
    }
}

enum RowItem: Identifiable {
    case channel(String)
    case lock(String)
    case person(String)

    var id: String { title }

    var title: String {
        switch self {
        case .channel(let name), .lock(let name), .person(let name):
            return name
        }
    }

    var icon: String {
        switch self {
        case .channel:
            return "number"
        case .lock:
            return "lock"
        case .person:
            return "person.circle"
        }
    }
}

@available(iOS 26.0, *)
#Preview {
    SlackNavigationBarStyle()
}
