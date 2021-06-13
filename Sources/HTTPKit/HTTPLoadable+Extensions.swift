import Foundation

// MARK: Typed Requests
extension HTTPLoadable {
    
    @discardableResult
    public func sendTyped<R: TypedHTTPRequestable> (
        _ request: R,
        callback: @escaping (Result<R.ResponseType, HTTPError>) -> ()
    ) -> Cancellable? {
        send(request) { result in
            switch result {
            case .success(let response):
                do {
                    let data = try request.parse(response)
                    callback(.success(data))
                } catch let error {
                    let httpError = HTTPError(code: .invalidResponse,
                                              request: request,
                                              response: response,
                                              underlyingError: error)
                    callback(.failure(httpError))
                }
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
    
    @available(macOS 12.0, *)
    @available(iOS 15.0, *)
    public func sendTyped<R: TypedHTTPRequestable> (_ request: R) async throws -> R.ResponseType {
        let response = try await send(request)
        let data = try request.parse(response)
        return data
    }
}
