//
//  SFGroupView.swift
//  Prototype House Mac
//
//  Created by Felipe Espinoza on 03/01/2022.
//

import SwiftUI

struct SFGroupView: View {
    let group: ContentData.Group

    @State var fontSelection: String = "SF Pro"
    @State var weightSelection: String = "Regular"

    let rows: [GridItem] = [
        GridItem.init(.fixed(200), spacing: 30, alignment: .center),
        GridItem.init(.adaptive(minimum: 200, maximum: 300), spacing: 30, alignment: .center),
    ]

    var body: some View {
        LazyHGrid(rows: rows) {
            ForEach(group.items) { item in
                VStack {
                    Image(systemName: item.iconName)
                    Text(item.name)
                }
                .padding()
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Picker("Font", selection: $fontSelection) {
                    Text("SF Pro").tag("SF Pro")
                    Text("SF Compact").tag("SF Compact")
                    Text("SF Pro Text").tag("SF Pro Text")
                }
            }
            ToolbarItem(placement: .principal) {
                Picker("Weight", selection: $weightSelection) {
                    Text("Thin").tag("Thin")
                    Text("Regular").tag("Regular")
                    Text("Medium").tag("Medium")
                    Text("Bold").tag("Bold")
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle(group.title)
        .navigationSubtitle("\(group.itemCount) Symbols")
        .padding()
    }
}

struct SFGroupView_Previews: PreviewProvider {
    static var previews: some View {
        SFGroupView(group: .sample)
            .previewLayout(.fixed(width: 600, height: 400))
    }
}
