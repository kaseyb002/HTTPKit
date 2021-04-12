import Foundation

public protocol HTTPLoadable {
    
    @discardableResult
    func send(_ request: HTTPRequestable,
              callback: @escaping (HTTPResult) -> ()) -> Cancellable?
}
