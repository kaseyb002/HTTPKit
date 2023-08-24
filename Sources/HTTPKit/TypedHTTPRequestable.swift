import Foundation

public protocol TypedHTTPRequestable: HTTPRequestable {
    associatedtype ResponseType
    
    func parse(_ response: HTTPResponse) throws -> ResponseType
}

extension TypedHTTPRequestable where ResponseType: Decodable {
    public func parse(_ response: HTTPResponse) throws -> ResponseType {
        guard let data = response.body, data.isEmpty == false else {
            throw HTTPError(code: .cannotDecodeResponse, request: response.request)
        }
        
        return try JSONDecoder().decode(ResponseType.self, from: data)
    }
}
