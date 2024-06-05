//
//  TextFieldExample.swift
//  Prototype House Mac
//
//  Created by Felipe Espinoza on 04/06/2024.
//

import SwiftUI

struct TextFieldExample: View {
    @State private var text: String = """
    this is a small space for text that may group in size when \
    the text become larger, like vertically in this case
    """
    @State private var amount: Float? = 29.1590

    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.currencyCode = "NOK"
        formatter.allowsFloats = true
        formatter.maximumFractionDigits = 2
        return formatter
    }()

    var body: some View {
        Form {
            // Growing vertical text field
            TextField(text: $text, axis: .vertical) {
                Label("Vertical", systemImage: "clock")
            }

            TextField(text: $text, axis: .horizontal) {
                Label("Horizontal", systemImage: "clock")
            }

            // Old formatter syntax
            TextField(
                "Amount",
                value: $amount,
                formatter: numberFormatter,
                prompt: Text("Something")
            )
            .textFieldStyle(.plain)

            // New formatter syntax
            TextField(
                "Amount",
                value: $amount,
                format: .number
                    .locale(Locale(identifier: "en-US"))
                    .precision(.significantDigits(4)),
                prompt: Text("Promp Text")
            )
            .textFieldStyle(.roundedBorder)

        }
        .padding()
    }
}

#Preview {
    TextFieldExample()
        .frame(width: 600, height: 300)
}
