import Testing
import Foundation
@testable import PrototypeActivities

@Test func decoding() async throws {
    struct StateContainer: Codable {
        let participationState: ParticipationState
    }

    let jsonString = """
    {
        "participationState": "upcoming"
    }
    """
    let json = try #require(jsonString.data(using: .utf8))
    let result = try JSONDecoder().decode(StateContainer.self, from: json)

    #expect(result.participationState == .upcoming)
}

@Test func decodingActivityDefaultDecoder() throws {
    let jsonString = """
    {
        "classId": "1234",
        "name": "Indoor Running",
        "room": "room 2",
        "startTime": 1729337784
    }
    """
    let json = try #require(jsonString.data(using: .utf8))

    let jsonDecoder = JSONDecoder()
    let activity = try jsonDecoder.decode(NeoPrototypeActivity.self, from: json)

    #expect(activity.classId == "1234")
    #expect(activity.name == "Indoor Running")
}

@Test func decodingActivityDifferentDateDecoder() throws {
    let jsonString = """
    {
        "classId": "1234",
        "name": "Indoor Running",
        "room": "room 2",
        "startTime": "2024-10-19T11:22:59Z"
    }
    """
    let json = try #require(jsonString.data(using: .utf8))

    let jsonDecoder = JSONDecoder()
    jsonDecoder.dateDecodingStrategy = .iso8601
    let activity = try jsonDecoder.decode(NeoPrototypeActivity.self, from: json)

    #expect(activity.classId == "1234")
    #expect(activity.name == "Indoor Running")
}
