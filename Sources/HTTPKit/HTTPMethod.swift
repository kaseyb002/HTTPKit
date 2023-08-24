import Foundation

public struct HTTPMethod: Hashable, RawRepresentable {
    public static let get = HTTPMethod(rawValue: "GET")
    public static let post = HTTPMethod(rawValue: "POST")
    public static let put = HTTPMethod(rawValue: "PUT")
    public static let delete = HTTPMethod(rawValue: "DELETE")

    public let rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}
