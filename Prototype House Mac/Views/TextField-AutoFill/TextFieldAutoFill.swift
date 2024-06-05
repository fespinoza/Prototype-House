//
//  TextFieldAutoFill.swift
//  Prototype House Mac
//
//  Created by Felipe Espinoza on 04/06/2024.
//

import SwiftUI

// taken from: https://bluelemonbits.com/2022/03/21/textfield-recommendations-autocomplete-swiftui-macos-and-ios/

// TODO: complete behavior

struct TextFieldAutoFill: View {
    @State private var query: String = ""
    @State private var showPopover: Bool = false

    @State private var processedContent: [String] = []

    var body: some View {
        Form {
            TextField("Auto Suggestions", text: $query)
                .onChange(of: query) { oldValue, newValue in
                    showPopover = !newValue.isEmpty
                }
                .popover(isPresented: $showPopover, content: {
                    ListSelectionExample { selection in
                        print("selection \(selection)")
                        processText()
                        showPopover = false
                    }
                })
//
//                .popover(
//                    isPresented: $showPopover,
//                    attachmentAnchor: .point(UnitPoint.top),
//                    arrowEdge: .top,
//                    content: {
//                        ListSelectionExample { selection in
//                            print("selection \(selection)")
//                            processText()
//                            showPopover = false
//                        }
//                    })

            Text(processedContent, format: .list(type: .and))
        }
        .padding()
    }

    func processText() {
        processedContent.append(query)
        query = ""
    }
}

#Preview {
    TextFieldAutoFill()
        .frame(width: 600, height: 300)
}
