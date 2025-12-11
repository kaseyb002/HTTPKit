import Foundation

public struct HTTPResponseError: Error, Sendable {
    public let response: HTTPResponse

    public init(
        response: HTTPResponse
    ) {
        self.response = response
    }
}
