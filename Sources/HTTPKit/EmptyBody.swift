import Foundation

public struct EmptyBody: HTTPBody {
    public let isEmpty = true
    public func encode() throws -> Data { Data() }
}
