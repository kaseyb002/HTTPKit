import Foundation

public protocol Cancellable: Sendable {
    func cancel()
}
