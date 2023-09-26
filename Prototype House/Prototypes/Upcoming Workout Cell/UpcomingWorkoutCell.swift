//
//  UpcomingWorkoutCell.swift
//  Prototype House
//
//  Created by Felipe Espinoza on 29/08/2023.
//

import SwiftUI

@available(iOS 17.0, *)
struct UpcomingWorkoutCell: View {
    struct ViewData {
        let time: String
        let duration: String
        let name: String
        let withInstructor: String
        let club: String
    }

    let viewData: UpcomingWorkoutCell.ViewData
    @Environment(\.dynamicTypeSize) var dynamicTypeSize

    var body: some View {
        dynamicTypeSizeApproach
            .font(.subheadline)
            .padding()
            .background(Color.red.opacity(0.2))
    }

    @ViewBuilder var dynamicTypeSizeApproach: some View {
        if dynamicTypeSize >= .accessibility1 {
            VStack(alignment: .leading, spacing: 16) {
                if dynamicTypeSize >= .accessibility3 {
                    HStack(alignment: .top, spacing: 2.0) {
                        Text(viewData.time)
                            .bold()
                        Spacer()
                        Text(viewData.duration)
                    }
                } else {
                    VStack(alignment: .leading, spacing: 2.0) {
                        Text(viewData.time)
                            .bold()
                        Text(viewData.duration)
                    }
                }

                VStack(alignment: .leading, spacing: 2.0) {
                    Text(viewData.name)
                        .bold()

                    if dynamicTypeSize < .accessibility3 {
                        Text(viewData.withInstructor)
                    }
                    Text(viewData.club)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

//                Spacer()

                Button("Book", action: {})
                    .buttonStyle(.borderedProminent)
            }
        } else {
            HStack(alignment: .top, spacing: 16) {
                VStack(alignment: .leading, spacing: 2.0) {
                    Text(viewData.time)
                        .bold()
                    Text(viewData.duration)
                }

                VStack(alignment: .leading, spacing: 2.0) {
                    Text(viewData.name)
                        .bold()

                    Text(viewData.withInstructor)
                    Text(viewData.club)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

                Button("Book", action: {})
                    .buttonStyle(.borderedProminent)
            }
        }
    }

    var viewThatFitsApproach: some View {
        ViewThatFits(in: .horizontal) {
            HStack(alignment: .top, spacing: 16) {
                content()
            }

            VStack(alignment: .leading, spacing: 16) {
                content(includeSpacer: false)
            }
        }
    }

    @ViewBuilder func content(includeSpacer: Bool = true) -> some View {
        VStack(alignment: .leading, spacing: 2.0) {
            Text(viewData.time)
                .bold()
            Text(viewData.duration)
        }

        VStack(alignment: .leading, spacing: 2.0) {
            Text(viewData.name)
                .bold()

            Text(viewData.withInstructor)
            Text(viewData.club)
        }
        .frame(maxWidth: .infinity, alignment: .leading)

        if includeSpacer {
            Spacer()
        }

        Button("Book", action: {})
            .buttonStyle(.borderedProminent)
    }
}

@available(iOS 17.0, *)
#Preview("Upcoming Workout Cell") {
    Group {
        UpcomingWorkoutCell(viewData: .previewValue())
    }
}

@available(iOS 17.0, *)
extension UpcomingWorkoutCell.ViewData {
    static func previewValue(
        time: String = "09:00",
        duration: String = "45 min",
        name: String = "Indoor Running",
        withInstructor: String = "w/Tony Stark",
        club: String = "Nydalen"
    ) -> Self {
        .init(
            time: time,
            duration: duration,
            name: name,
            withInstructor: withInstructor,
            club: club
        )
    }
}
