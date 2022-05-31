import SwiftUI

struct SizeReaderModifier: ViewModifier {
    let handler: (CGSize) -> Void

    private var geometryView: some View {
        GeometryReader { geometry -> Color in
            let size = geometry.size
            DispatchQueue.main.async {
                self.handler(size)
            }
            return Color.clear
        }
    }

    func body(content: Content) -> some View {
        content.background(geometryView)
    }
}

extension View {
    func sizeReader(_ handler: @escaping (CGSize) -> Void) -> some View {
        modifier(SizeReaderModifier(handler: handler))
    }

    func sizeReader() {}
}
