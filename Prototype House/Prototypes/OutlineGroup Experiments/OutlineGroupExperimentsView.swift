//
//  OutlineGroupExperimentsView.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 30/05/2022.
//

import SwiftUI

struct OutlineGroupExperimentsView: View {
    @State var data: [Item] = Self.sampleHierarchy

    var body: some View {
        specializedSOApproach
    }

    var nestedList: some View {
        List(data, children: \.children) { item in
            if item.children == nil {
                leafContent(for: item)
            } else {
                nodeContent(for: item)
            }
        }
        .navigationBarTitle("Hierarchies - List")
    }

//    var customList: some View {
//        List {
//            levelContent(for: $data)
//        }
//        .navigationTitle("Hierachies - Custom")
//    }

//    @ViewBuilder func levelContent(for items: Binding<[Item]>, level: Int = 0) -> some View {
//        ForEach(items) { $item in
//            DisclosureGroup(isExpanded: $item.isExpended) {
//                nestedContent(for: $item, level: level)
//            } label: {
//                nodeContent(for: item, level: level)
//            }
//        }
//    }
//
//    @ViewBuilder func nestedContent(for item: Binding<Item>, level: Int) -> some View {
//        if item.wrappedValue.children == nil {
//            leafContent(for: item.wrappedValue)
//        } else {
//            levelContent(
//                for: .init(
//                    get: { item.wrappedValue.children ?? [] },
//                    set: { newValue in item.wrappedValue.children = newValue }
//                ),
//                level: level + 1
//            )
//        }
//    }

    private func leafContent(for item: Item) -> some View {
        Label(item.name, systemImage: "mappin.circle.fill")
            .accentColor(.blue)
    }

    private func nodeContent(for item: Item, level: Int = 0) -> some View {
        let nesting = String(repeating: "\t", count: level)
        return Label(nesting + item.name, systemImage: "map.fill")
            .font(.body.bold())
    }

    var stackOverflowApproach: some View {
        List {
            ForEach(data) { item in
                NodeOutlineGroup(node: item, childKeyPath: \.children, isExpanded: true)
            }
        }
        .navigationBarTitle("Hierarchies - StackOverflow")
    }

    var specializedSOApproach: some View {
        List {
            ForEach(data) { item in
                ItemOutlineGroup(item: item, childKeyPath: \.children, isExpanded: true)
            }
        }
        .navigationBarTitle("Hierarchies - Spec")
    }
}

// from: https://stackoverflow.com/questions/62832809/list-or-outlinegroup-expanded-by-default-in-swiftui
struct NodeOutlineGroup<Node>: View where Node: Hashable, Node: Identifiable, Node: CustomStringConvertible {
    let node: Node
    let childKeyPath: KeyPath<Node, [Node]?>
    @State var isExpanded: Bool = true

    var body: some View {
        if node[keyPath: childKeyPath] != nil {
            DisclosureGroup(
                isExpanded: $isExpanded,
                content: {
                    if isExpanded {
                        ForEach(node[keyPath: childKeyPath]!) { childNode in
                            NodeOutlineGroup(node: childNode, childKeyPath: childKeyPath, isExpanded: isExpanded)
                        }
                    }
                },
                label: { Text(node.description) })
        } else {
            Text(node.description)
        }
    }
}

struct ItemOutlineGroup: View {
    typealias Item = OutlineGroupExperimentsView.Item

    let item: Item
    let childKeyPath: KeyPath<Item, [Item]?>
    @State var isExpanded: Bool = true

    var body: some View {
        if item[keyPath: childKeyPath] != nil {
            DisclosureGroup(
                isExpanded: $isExpanded,
                content: {
                    if isExpanded {
                        ForEach(item[keyPath: childKeyPath]!) { childNode in
                            ItemOutlineGroup(item: childNode, childKeyPath: childKeyPath, isExpanded: isExpanded)
                        }
                    }
                },
                label: {
                    nodeContent(for: item)
                }
            )
        } else {
            leafContent(for: item)
        }
    }

    private func leafContent(for item: Item) -> some View {
        Label(item.name, systemImage: "mappin.circle.fill")
            .accentColor(.blue)
    }

    private func nodeContent(for item: Item, level: Int = 0) -> some View {
        let nesting = String(repeating: "\t", count: level)
        return Label(nesting + item.name, systemImage: "map.fill")
            .font(.body.bold())
    }
}

extension OutlineGroupExperimentsView {
    struct Item: Identifiable, CustomStringConvertible, Hashable {
        var description: String { name }

        let id: UUID = .init()
        let name: String
        var isExpended: Bool = false
        var children: [Item]?
    }

    static let sampleHierarchy: [Item] = [
        .init(
            name: "Europe",
            children: [
                .init(
                    name: "Norway",
                    children: [
                        .init(name: "Oslo"),
                        .init(name: "Drammen"),
                        .init(name: "Begen"),
                        .init(name: "Tromsø"),
                        .init(name: "Sandefjord"),
                    ]
                ),
                .init(
                    name: "Sweden",
                    children: [
                        .init(name: "Stockholm"),
                        .init(name: "Malmö"),
                        .init(name: "Göteborg"),
                    ]
                ),
                .init(
                    name: "Germany",
                    children: [
                        .init(name: "Berlin"),
                        .init(name: "Stuttgart"),
                        .init(name: "Cologne"),
                        .init(name: "Munich"),
                    ]
                ),
            ]
        ),
        .init(
            name: "Latin America",
            children: [
                .init(
                    name: "Chile",
                    children: [
                        .init(name: "Santiago"),
                        .init(name: "Concepción"),
                        .init(name: "Temuco"),
                        .init(name: "Arica"),
                    ]
                ),
                .init(
                    name: "Argentina",
                    children: [
                        .init(name: "Buenos Aires"),
                        .init(name: "Mendoza"),
                    ]
                ),
                .init(
                    name: "Brazil",
                    children: [
                        .init(name: "Brasilia"),
                        .init(name: "São Paulo"),
                        .init(name: "Rio de Janeiro"),
                        .init(name: "Fortaleza"),
                        .init(name: "Bahía"),
                    ]
                ),
            ]
        )
    ]
}

struct OutlineGroupExperimentsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            OutlineGroupExperimentsView()
        }
    }
}
