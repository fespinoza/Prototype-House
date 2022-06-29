//
//  TvAppContentViewData.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 29/06/2022.
//

import UIKit

struct TvAppContentViewData {
    let bannerImage: UIImage?
    let title: String
    let description: String
}

extension TvAppContentViewData {
    static let tedLasso = TvAppContentViewData(
        bannerImage: UIImage(named: "tedLassoBanner2"),
        title: "Ted Lasso",
        description: """
        Ted Lasso is an American sports comedy-drama television series developed by Jason Sudeikis, Bill Lawrence, Brendan Hunt, and Joe Kelly. It is based on a character of the same name that Sudeikis first portrayed in a series of promos for NBC Sports' coverage of the Premier League.[2] The series follows Ted Lasso, an American college football coach who is hired to coach an English soccer team in an attempt by its owner to spite her ex-husband. Lasso tries to win over the skeptical English market with his folksy, optimistic demeanor while dealing with his inexperience in the sport.

        The first season of 10 episodes premiered on Apple TV+ on August 14, 2020, with three episodes, followed by weekly installments.[3] A second season of 12 episodes premiered on July 23, 2021.[4][5][6] In October 2020, the series was renewed for a third season.[7]

        The series has received critical acclaim, with particular praise for its performances, writing, emotional themes and uplifting tone. Among other accolades, its first season was nominated for 20 Primetime Emmy Awards, becoming the most nominated freshman comedy in Emmy Award history. Sudeikis, Hannah Waddingham, and Brett Goldstein won for their performances, and the series won the 2021 Primetime Emmy Award for Outstanding Comedy Series. Sudeikis also won the Golden Globe Award for Best Actor – Television Series Musical or Comedy and the Screen Actors Guild Award for Outstanding Performance by a Male Actor in a Comedy Series.
        """
    )
}
