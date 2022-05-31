//
//  SampleView.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 10/03/2022.
//

import SwiftUI

struct SampleViewData {
    let title: String // 1
    let message: String? // 2
    var isLoading: Bool // 2
}

// 1x2x2 = 4

struct SampleView: View {
    let viewData: SampleViewData
    var onClick: () -> Void = {}

    var body: some View {
        VStack {
            Text(viewData.title)
                .font(.system(.largeTitle).weight(.black))
                .italic()


            if viewData.isLoading {
                ProgressView()
            }

            if let message = viewData.message {
                Text(message)
                    .transition(.opacity.combined(with: .slide))
            }

            Button("Next state", action: onClick)
        }
    }
}

class SampleViewModel: ObservableObject {
    @Published var viewData: SampleViewData
    @Published var counter: Int = 1

    init() {
        self.viewData = .init(
            title: "Hello #1",
            message: nil,
            isLoading: false
        )
    }

    func nextState() {
        viewData.isLoading = true
        counter += 1

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                self.viewData = .init(
                    title: "Hello #\(self.counter)",
                    message: "I loaded things",
                    isLoading: false
                )
            }
        }
    }
}

struct SampleView_Previews: PreviewProvider {
    struct Demo: View {
        @StateObject var viewModel: SampleViewModel = .init()

        var body: some View {
            SampleView(viewData: viewModel.viewData, onClick: viewModel.nextState)
        }
    }

    static var previews: some View {
        Demo()
    }
}
