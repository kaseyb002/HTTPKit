import Foundation

public struct HTTPResponse {
    public let request: HTTPRequestable
    public let response: HTTPURLResponse
    public let body: Data?
    
    public var status: HTTPResponseStatus? {
        HTTPResponseStatus(rawValue: response.statusCode)
    }
    
    public var headers: [AnyHashable: Any] { response.allHeaderFields }
}

public struct HTTPResponseStatus: ExpressibleByIntegerLiteral, RawRepresentable {
    
    public enum Kind {
        case informational
        case success
        case redirect
        case clientError
        case serverError
        case unknown
    }
    
    public static let ok: HTTPResponseStatus = 200
    
    public static let movedPermanently: HTTPResponseStatus = 301
    public static let found: HTTPResponseStatus = 302
    public static let notModified: HTTPResponseStatus = 304
    public static let temporaryRedirect: HTTPResponseStatus = 307
    public static let permanentRedirect: HTTPResponseStatus = 308
    
    public static let badRequest: HTTPResponseStatus = 400
    public static let unauthorized: HTTPResponseStatus = 401
    public static let forbidden: HTTPResponseStatus = 403
    public static let notFound: HTTPResponseStatus = 404
    
    public static let internalServerError: HTTPResponseStatus = 500
    public static let serviceUnavailable: HTTPResponseStatus = 503
    
    public let rawValue: Int
    public let kind: Kind
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
        switch rawValue {
            case 100 ..< 200: kind = .informational
            case 200 ..< 300: kind = .success
            case 300 ..< 400: kind = .redirect
            case 400 ..< 500: kind = .clientError
            case 500 ..< 600: kind = .serverError
            default: kind = .unknown
        }
    }
    public init(integerLiteral value: UInt16) { self.init(rawValue: Int(value)) }
    
    public var isInformational: Bool { kind == .informational }
    public var isSuccess: Bool { kind == .success }
    public var isRedirect: Bool { kind == .redirect }
    public var isClientError: Bool { kind == .clientError }
    public var isServerError: Bool { kind == .serverError }
    
    public var description: String {
        HTTPURLResponse.localizedString(forStatusCode: rawValue)
    }
}
