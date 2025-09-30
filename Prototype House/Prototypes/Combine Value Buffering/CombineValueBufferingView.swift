//
//  CombineValueBufferingView.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 06/02/2023.
//

import SwiftUI
import Combine

extension CombineValueBufferingView {
    class ViewModel: ObservableObject {
        @Published var value: CGFloat
        @Published var bufferedValue: CGFloat

        private var observations: Set<AnyCancellable> = []

        init(value: CGFloat) {
            self.value = value
            self.bufferedValue = value

            self
                .$value
                .debounce(for: .milliseconds(30), scheduler: DispatchQueue.main)
                .sink(receiveValue: { newValue in
                    self.bufferedValue = newValue
                })
                .store(in: &observations)
        }
    }
}

struct CombineValueBufferingView: View {
    @StateObject var viewModel: ViewModel = .init(value: 1.0)

    var body: some View {
        VStack {
            Slider(value: $viewModel.value)

            Text("Normal: \(viewModel.value * 100, format: .number.precision(.significantDigits(2)))").bold()

            Text("Buffered: \(viewModel.bufferedValue * 100, format: .number.precision(.significantDigits(2)))").bold()
        }
        .padding()
    }
}

struct CombineValueBufferingView_Previews: PreviewProvider {
    static var previews: some View {
        CombineValueBufferingView()
    }
}
