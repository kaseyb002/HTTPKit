import Foundation

public extension URLComponents {
    
    mutating func setQueryItems(for values: [String: String?]) {
        var parameters: [URLQueryItem] = queryItems ?? []
        for (name, value) in values {
            parameters.append(URLQueryItem(name: name, value: value))
        }
        
        // for predictable URLs.
        parameters.sort { a, b  in
            if a.name == b.name {
                if let aValue = a.value, let bValue = b.value {
                    return aValue < bValue
                }
                
                if a.value != nil, b.value == nil {
                    return true
                }
                    
                return false
                
            } else {
                return a.name < b.name
            }
        }
        
        self.queryItems = parameters
    }
}
