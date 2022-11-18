//
//  ImageGalleryView.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 28/10/2022.
//

import SwiftUI

struct ImageGalleryView: View {
    @State var selectedImage: Image?
    @State var showFull: Bool = false

    var body: some View {
        ScrollView {
            ZStack {
                VStack {
                    Image("gymSample1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 238, height: 238)
                        .onTapGesture {
                            selectedImage = Image("gymSample1")
                        }

                    Image("gymSample2")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 238, height: 238)
                        .onTapGesture {
                            selectedImage = Image("gymSample2")
                        }

                    Image("gymSample3")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 238, height: 238)
                        .onTapGesture {
                            selectedImage = Image("gymSample3")
                        }
                }

                if let selectedImage = selectedImage {
                    GeometryReader { proxy in
                        selectedImage
                            .resizable()
                            .aspectRatio(contentMode: showFull ? .fill : .fit)
                            .frame(width: proxy.size.width, height: proxy.size.height)
                            .onTapGesture(count: 2) {
                                self.selectedImage = nil
                            }
                            .onTapGesture {
                                print("H")
                                showFull.toggle()
                            }
                    }
                    .background(Color.black)
                }
            }
        }
    }
}

struct ImageGalleryView_Previews: PreviewProvider {
    static var previews: some View {
        ImageGalleryView()
    }
}
