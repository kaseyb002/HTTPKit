import Foundation

public protocol HTTPLoadable {
    @discardableResult
    func send(
        _ request: HTTPRequestable,
        callback: @Sendable @escaping (HTTPResult) -> ()
    ) -> Cancellable?
    
    @available(macOS 12.0, *)
    @available(iOS 15.0, *)
    @available(tvOS 15.0, *)
    func send(_ request: HTTPRequestable) async throws -> HTTPResponse
}
