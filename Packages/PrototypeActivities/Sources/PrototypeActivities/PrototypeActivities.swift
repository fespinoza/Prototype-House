// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
import ActivityKit

public struct WaitingList: Codable, Hashable {
    public let position: Int
    public let total: Int

    public init(position: Int, total: Int) {
        self.position = position
        self.total = total
    }
}

public struct NeoPrototypeActivity: ActivityAttributes {
    public let classId: String
    public let name: String
    public let room: String
    public let startTime: Date

    public init(classId: String, name: String, room: String, startTime: Date) {
        self.classId = classId
        self.name = name
        self.room = room
        self.startTime = startTime
    }

    public struct ContentState: Codable & Hashable {
        public let participationState: ParticipationState

        public init(participationState: ParticipationState) {
            self.participationState = participationState
        }
    }
}

public enum ParticipationState: String, Codable, Hashable, Equatable {
    case upcoming
    case upcomingOnWaitingList
    case checkedIn
    case waitingList
    case lostSpot
    case lostSpotFromWaitingList
    case classCompleted

    public var description: String {
        switch self {
        case .upcoming: return "Upcoming"
        case .upcomingOnWaitingList: return "Upcoming on Waiting List"
        case .checkedIn: return "Checked In"
        case .waitingList: return "Waiting List"
        case .lostSpot: return "Lost Spot"
        case .lostSpotFromWaitingList: return "Lost Spot from Waiting List"
        case .classCompleted: return "Class completed"
        }
    }
}
