//
//  TvAppContentSwiftUIView.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 29/06/2022.
//

import SwiftUI

//struct TvAppContentViewData {
//    let bannerImage: UIImage?
//    let title: String
//    let description: String
//}

struct TvAppContentSwiftUIView: View {
    let viewData: TvAppContentViewData

    var body: some View {
        ZStack {
            VStack {
                GeometryReader { proxy in
                    if let bannerImage = viewData.bannerImage {
                        Image(uiImage: bannerImage)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: proxy.size.width)
                            .overlay(
                                LinearGradient(
                                    stops: [
                                        .init(color: .clear, location: 0),
                                        .init(color: .clear, location: 0.5),
                                        .init(color: .black.opacity(0.7), location: 0.8),
                                        .init(color: .black, location: 1),
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                    }
                }

                Spacer()
            }

            VStack(spacing: 30) {
                Spacer()
                    .frame(height: 200)

                Text(viewData.title)
                    .font(.system(size: 60).weight(.black).italic())
                    .textCase(.uppercase)
                    .shadow(color: .black.opacity(0.6), radius: 3, x: 0, y: 0)

                Button(action: {}) {
                    Text("Get Apple TV+")
                        .bold()
                        .padding(.vertical, 8)
                        .padding(.horizontal, 32)
                }
                    .buttonStyle(.borderedProminent)
                    .tint(.white)
                    .foregroundColor(.black)

                Text(viewData.description)
            }
            .padding()
        }
    }
}

struct TvAppContentSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            TvAppContentSwiftUIView(viewData: .tedLasso)
        }
        .ignoresSafeArea()
        .preferredColorScheme(.dark)
    }
}
