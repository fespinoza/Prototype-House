import Foundation
import Testing

@Test("check if require works as expected, with value")
func firstTest() throws {
    let value: String? = "Hello World"

    let realValue = try #require(value)

    #expect(realValue == "Hello World")
}

@Test("check if require works as expected, no value")
func secondTest() throws {
    let value: String? = nil

    let realValue = try #require(value)

    #expect(realValue == "Hello World")
}


@Test("check if require works as expected with parameterized test", arguments: [
    ("Hello World", "Hello World"),
    ("Hello World", "Hello Vorld"),
    (nil, "Hello Vorld"),
])
func secondTest(value: String?, result: String) throws {
    let value: String? = nil

    let realValue = try #require(value)

    #expect(realValue == result)
}

func onlyEven(_ value: Int) -> String? {
    if value.isMultiple(of: 2) {
        return "Even"
    }

    return nil
}

@Test("test with paramerized test and values inline", arguments: [
    (2, "Even"),
    (4, "Even"),
    (7, "Even"),
    (8, "Even"),
    (16, "Even"),
])
func thirdTest(value: Int, result: String) throws {
    let realValue = try #require(onlyEven(value))

    #expect(realValue == result)
}
