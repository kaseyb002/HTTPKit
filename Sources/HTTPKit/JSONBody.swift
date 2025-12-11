import Foundation

public struct JSONBody: HTTPBody {
    public let isEmpty = false
    public var additionalHeaders = [
        "Content-Type": "application/json; charset=utf-8"
    ]
    
    private let encodeClosure: @Sendable () throws -> Data
    
    public init<T: Encodable & Sendable>(
        _ value: T,
        encoder: JSONEncoder = JSONEncoder()
    ) {
        self.encodeClosure = { try encoder.encode(value) }
    }
    
    public func encode() throws -> Data { try encodeClosure() }
}
