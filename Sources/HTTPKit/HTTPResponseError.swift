import Foundation

public struct HTTPResponseError: Error {
    public let response: HTTPResponse

    public init(
        response: HTTPResponse
    ) {
        self.response = response
    }
}
