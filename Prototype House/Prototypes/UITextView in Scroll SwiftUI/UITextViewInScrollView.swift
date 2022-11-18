//
//  UITextViewInScrollView.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 05/10/2022.
//

import SwiftUI

struct HtmlNSAttributeStringBuilder {
    static func attributedString() -> NSAttributedString {
        guard
            let fileUrl = Bundle.main.url(forResource: "sample-article", withExtension: "html"),
            let data = try? Data(contentsOf: fileUrl),
            let content = try? NSAttributedString(
                data: data,
                options: [.documentType: NSAttributedString.DocumentType.html],
                documentAttributes: nil
            )
        else {
            return NSAttributedString(string: "it failed")
        }

        return content
    }
}

class CustomTextView: UITextView {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
//        let textSize = attributedText.size()
//        let padding: CGFloat = 100
//        return CGSize(
//            width: textSize.width,
//            height: textSize.height + padding
//        )

        return attributedText.boundingRect(
            with: CGSize(
                width: bounds.width,
                height: CGFloat.greatestFiniteMagnitude
            ),
            options: [.usesLineFragmentOrigin, .usesDeviceMetrics],
            context: nil
        )
        .size
    }
}

struct TextContainer: UIViewRepresentable {
    let text: NSAttributedString
    @Binding var debugText: String

    func makeUIView(context: Context) -> UITextView {
        let textView = CustomTextView()
        textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return textView
    }

    func updateUIView(_ textView: UITextView, context: Context) {
        textView.attributedText = text
//        let rect = text.boundingRect(
//            with: CGSize(
//                width: UIView.layoutFittingCompressedSize.width,
//                height: CGFloat.greatestFiniteMagnitude
//            ),
//            options: [.usesLineFragmentOrigin, .usesDeviceMetrics],
//            context: nil
//        )

        let rect = textView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)


        debugText = textView.intrinsicContentSize.debugDescription
    }
}

struct UITextViewInScrollView: View {
    @State var debugText: String = ""

    var body: some View {
        ScrollView(.vertical) {
            VStack {
                Image("london")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()

                Text("Hello, World!")
                    .font(.title.bold())

                Text(debugText)

//                longContent

                TextContainer(text: HtmlNSAttributeStringBuilder.attributedString(), debugText: $debugText)
//                    .frame(height: 300) // a smaller height will make the text view scrollable
//                    .frame(height: 800) // a bigger height will make the text behave correctly
                    .background(Color.red.opacity(0.3))
            }
            .navigationTitle("Sample")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    var longContent: some View {
        Rectangle()
            .foregroundColor(.red)
            .frame(height: 800)
            .overlay {
                VStack {
                    Text("Top")

                    Spacer()

                    Text("Center")

                    Spacer()

                    Text("Bottom")
                }
                .padding()
            }
    }
}

struct UITextViewInScrollView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UITextViewInScrollView()
        }
    }
}
