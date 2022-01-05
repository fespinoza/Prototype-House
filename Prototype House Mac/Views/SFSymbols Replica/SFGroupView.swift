//
//  SFGroupView.swift
//  Prototype House Mac
//
//  Created by Felipe Espinoza on 03/01/2022.
//

import SwiftUI

struct TrailingSidebarContainer<Content: View, LeadingContent: View, TrailingContent: View>: NSViewControllerRepresentable {
    @Binding var openSidebar: Bool
    let content: Content
    let leadingContent: LeadingContent
    let trailingContent: TrailingContent

    init(
        openSidebar: Binding<Bool>,
        @ViewBuilder content: () -> Content,
        @ViewBuilder leadingContent: () -> LeadingContent,
        @ViewBuilder trailingContent: () -> TrailingContent
    ) {
        self._openSidebar = openSidebar
        self.content = content()
        self.leadingContent = leadingContent()
        self.trailingContent = trailingContent()
    }

    func makeNSViewController(context: Context) -> NSSplitViewController {
        let controller = NSSplitViewController()

        let leadingSidebar = NSSplitViewItem(viewController: NSHostingController(rootView: leadingContent))
        leadingSidebar.minimumThickness = 300

        let contentItem = NSSplitViewItem(viewController: NSHostingController(rootView: content))

        let trailingSidebar = NSSplitViewItem(
            sidebarWithViewController: NSHostingController(rootView: trailingContent)
        )
        trailingSidebar.minimumThickness = 300

        controller.splitViewItems = [leadingSidebar, contentItem, trailingSidebar]
        return controller
    }

    func updateNSViewController(_ splitController: NSSplitViewController, context: Context) {
        let sidebarItem = splitController.splitViewItems[2]
        if sidebarItem.isCollapsed != openSidebar {
            splitController.toggleSidebar(nil)
        }
    }
}

struct SFGroupView: View {
    let group: ContentData.Group

    @State var isTrainingSidebarOpen: Bool = true
    @State var fontSelection: String = "SF Pro"
    @State var weightSelection: String = "Regular"

    let rows: [GridItem] = [
        GridItem.init(.adaptive(minimum: 200, maximum: 300), spacing: 30, alignment: .center),
        GridItem.init(.adaptive(minimum: 200, maximum: 300), spacing: 30, alignment: .center),
    ]

    var body: some View {
        nsSplitControllerApproach
//        splitHApproach
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
            ToolbarItem(placement: .confirmationAction) {
                Button(action: { isTrainingSidebarOpen.toggle() }) {
                    Image(systemName: "sidebar.trailing")
                }
            }
        }
        .navigationTitle(group.title)
        .navigationSubtitle("\(group.itemCount) Symbols")
    }

    var splitHApproach: some View {
        HSplitView {
            Text("Details")
                .frame(minWidth: 300, maxHeight: .infinity)
                .background(.ultraThinMaterial)

            Color.red
                .overlay(Text("Content").foregroundColor(.white))

            Text("Sidebar")
                .frame(minWidth: 300, maxHeight: .infinity)
                .background(.thinMaterial)
        }
    }

    var nsSplitControllerApproach: some View {
        TrailingSidebarContainer(openSidebar: $isTrainingSidebarOpen) {
            Color.red
                .overlay(Text("Content").foregroundColor(.white))
        } leadingContent: {
            Text("Details")
                .frame(minWidth: 300, maxHeight: .infinity)
        } trailingContent: {
            Text("Sidebar")
                .frame(minWidth: 300, maxHeight: .infinity)
        }
    }
}

struct SFGroupView_Previews: PreviewProvider {
    static var previews: some View {
        SFGroupView(group: .sample)
            .previewLayout(.fixed(width: 600, height: 400))
    }
}
