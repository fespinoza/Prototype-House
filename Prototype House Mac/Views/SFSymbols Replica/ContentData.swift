//
//  ContentData.swift
//  Prototype House Mac
//
//  Created by Felipe Espinoza on 03/01/2022.
//

import Foundation

struct ContentData {
    let sections: [Section]
}

extension ContentData {
    struct Section: Identifiable {
        let name: String
        let groups: [Group]

        var id: String { name }
    }

    struct Group: Identifiable {
        let title: String
        let iconName: String
        let items: [Item]

        var id: String { title }
        var itemCount: Int { items.count }

        init(title: String, iconName: String, itemNumber: Int) {
            self.title = title
            self.iconName = iconName
            self.items = (0..<itemNumber).map({ Item(name: "Item #\($0)") })
        }
    }

    struct Item: Identifiable {
        let id = UUID()
        let name: String
        let iconName: String = "circle.and.line.horizontal"
    }
}

extension ContentData {
    static let sample: ContentData = .init(
        sections: [
            .sfSymbols,
            .library,
        ]
    )
}

extension ContentData.Section {
    static let sfSymbols = ContentData.Section(
        name: "SF Symbols",
        groups: [
            .init(title: "All", iconName: "rectangle.grid.2x2", itemNumber: 50),
            .init(title: "What's new", iconName: "sparkles", itemNumber: 15),
            .init(title: "Multicolour", iconName: "paintpalette", itemNumber: 10),
            .init(title: "Communication", iconName: "message", itemNumber: 25),
        ]
    )

    static let library = ContentData.Section(
        name: "Library",
        groups: [
            .init(title: "Custom Symbols", iconName: "rectangle.grid.2x2", itemNumber: 20),
            .init(title: "Favorites", iconName: "folder", itemNumber: 6),
        ]
    )
}

extension ContentData.Group {
    static let sample = ContentData.Group(title: "All", iconName: "rectangle.grid.2x2", itemNumber: 25)
}
