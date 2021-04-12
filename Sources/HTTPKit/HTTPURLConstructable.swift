import Foundation

public protocol HTTPURLConstructable {
    var baseUrl: String { get }
    var appendedPath: String { get }
}

extension HTTPURLConstructable {
    
    public var path: String {
        var appendedPath = self.appendedPath
        
        guard let firstChar = appendedPath.first else { return "" }
        
        if firstChar != "/" {
            appendedPath.insert("/", at: appendedPath.startIndex)
        }
        
        return baseUrl + appendedPath
    }
}
