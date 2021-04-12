import Foundation

public protocol HTTPRequestable {
    var method: HTTPMethod { get }
    var path: String { get }
    var headers: [String: String] { get }
    var params: [String: String] { get }
    var body: HTTPBody? { get }
}

public extension HTTPRequestable {
    var headers: [String: String] { [:] }
    var params: [String: String] { [:] }
    var method: HTTPMethod { .get }
    var body: HTTPBody? { EmptyBody() }
    var cachePolicy: URLRequest.CachePolicy { .reloadRevalidatingCacheData }
    var timeoutInterval: TimeInterval { 60 }
    
    var url: URL? {
        guard path.isEmpty == false else { return nil }
        
        guard let url = URL(string: path) else { return nil }
        
        var components = URLComponents(url: url,
                                       resolvingAgainstBaseURL: true)
        
        components?.setQueryItems(for: params)
        
        return components?.url
    }
}
