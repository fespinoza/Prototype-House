//
//  MatchedGeometrySample.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 29/11/2022.
//

// https://www.hackingwithswift.com/quick-start/swiftui/how-to-synchronize-animations-from-one-view-to-another-with-matchedgeometryeffect

import SwiftUI

struct MatchedGeometrySample: View {
    @State var showDetails: Bool = false
    @Namespace private var tvCell

    var body: some View {
        VStack {
            if showDetails {
                ShowDetailsView(showDetails: $showDetails, tvCell: tvCell)
            } else {
                cell
                    .onTapGesture {
                        withAnimation {
                            showDetails.toggle()
                        }
                    }
            }
        }
        // THIS DOESN'T WORK
//        .fullScreenCover(isPresented: $showDetails) {
//            wrappedFullContent
//        }
    }

    var cell: some View {
        Image("tedLassoBanner")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .matchedGeometryEffect(id: "bannerImage", in: tvCell)
            .overlay(
                VStack {
                    Spacer()

                    Text("Ted Lasso")
                        .font(.largeTitle.bold())
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.7))
                        .matchedGeometryEffect(id: "title", in: tvCell)
                }
            )
            .cornerRadius(12)
            .shadow(radius: 3)
            .padding()
    }

    var wrappedFullContent: some View {
        NavigationView {
            ShowDetailsView(showDetails: $showDetails, tvCell: tvCell)
                .navigationTitle("Ted Lasso")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            withAnimation {
                                showDetails.toggle()
                            }
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                        }

                    }
                }
        }
    }


}

struct MatchedGeometrySample_Previews: PreviewProvider {
    static var previews: some View {
        MatchedGeometrySample()
    }
}

extension MatchedGeometrySample {
    struct ShowDetailsView: View {
        @Binding var showDetails: Bool
        let tvCell: Namespace.ID

        var body: some View {
            GeometryReader { proxy in
                ScrollView {
                    VStack(spacing: 16) {
                        Image("tedLassoBanner")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: proxy.size.width, height: 300)
                            .matchedGeometryEffect(id: "bannerImage", in: tvCell)
                            .onTapGesture {
                                withAnimation {
                                    showDetails.toggle()
                                }
                            }

                        Text("Ted Lasso")
                            .font(.largeTitle.bold())
                            .matchedGeometryEffect(id: "title", in: tvCell)

                        Text(description)
                            .padding(.horizontal)
                            .transition(.move(edge: .bottom).animation(.default.delay(2)))
                    }

                    Spacer()
                }
            }
        }

        let description: String = """
        Ted Lasso is an American sports comedy-drama television series developed by Jason Sudeikis, \
        Bill Lawrence, Brendan Hunt, and Joe Kelly. It is based on a character of the same name that \
        Sudeikis first portrayed in a series of promos for NBC Sports' coverage of the Premier League.\
        The series follows Ted Lasso, an American college football coach who is hired to coach an English \
        soccer team in an attempt by its owner to spite her ex-husband. Lasso tries to win over the \
        skeptical English market with his folksy, optimistic demeanor while dealing with his \
        inexperience in the sport.

        The first season of 10 episodes premiered on Apple TV+ on August 14, 2020, with three \
        episodes, followed by weekly installments.[3] A second season of 12 episodes premiered \
        on July 23, 2021.[4][5][6] In October 2020, the series was renewed for a third season.[7]

        The series has received critical acclaim, with particular praise for its performances \
        (specifically Sudeikis, Hannah Waddingham, and Brett Goldstein), writing, themes, \
        and uplifting tone. Among other accolades, its first season was nominated for 20 \
        Primetime Emmy Awards, becoming the most nominated first-season comedy in Emmy Award history.\
        Sudeikis, Waddingham, and Goldstein won for their performances, and the series won the \
        2021 Primetime Emmy Award for Outstanding Comedy Series. Sudeikis also won the Golden \
        Globe Award for Best Actor – Television Series Musical or Comedy and the Screen Actors \
        Guild Award for Outstanding Performance by a Male Actor in a Comedy Series.
        """
    }
}
