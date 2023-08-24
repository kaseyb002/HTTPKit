import Foundation

public protocol HTTPRequestable {
    var url: URL { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var body: HTTPBody? { get }
}

public extension HTTPRequestable {
    var headers: [String: String] { [:] }
    var method: HTTPMethod { .get }
    var body: HTTPBody? { EmptyBody() }
    var cachePolicy: URLRequest.CachePolicy { .reloadRevalidatingCacheData }
    var timeoutInterval: TimeInterval { 60 }
}
