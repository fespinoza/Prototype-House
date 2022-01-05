//
//  SFSymbolsReplica.swift
//  Prototype House Mac
//
//  Created by Felipe Espinoza on 03/01/2022.
//

import SwiftUI

struct SFSymbolsReplica: View {
    let data: ContentData = .sample
    @State var selectedItem: ContentData.Group.ID?

    init() {
        self._selectedItem = State(initialValue: data.sections[0].groups[0].id)
    }

    var body: some View {
        NavigationView {
            List(selection: $selectedItem) {
                ForEach(data.sections) { section in
                    Section {
                        ForEach(section.groups) { group in
                            NavigationLink(
                                destination: {
                                    SFGroupView(group: group)
//                                    SplitViewDemo(group: group)
                                },
                                label: {
                                    Label(group.title, systemImage: group.iconName)
                                        .tag(Optional(group.id))
                                        .padding(.leading, 8)
                                }
                            )
                        }
                    } header: {
                        Text(section.name)
                    }
                }
            }
            .frame(minWidth: 200)
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button(action: toggleSidebar) {
                        Image(systemName: "sidebar.leading")
                    }
                }
            }

            DetailView(index: nil)
        }
    }

    func toggleSidebar() {
        NSApp
            .keyWindow?
            .firstResponder?
            .tryToPerform(
                #selector(NSSplitViewController.toggleSidebar(_:)),
                with: nil
            )
    }
}

struct SFSymbolsReplica_Previews: PreviewProvider {
    static var previews: some View {
        SFSymbolsReplica()
    }
}
