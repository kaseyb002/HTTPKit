import Foundation

extension URLSession: HTTPLoadable {
    
    public func send(_ request: HTTPRequestable,
                     callback: @escaping (HTTPResult) -> ()) -> Cancellable? {
        guard let url = request.url else {
            callback(.failure(.init(code: .invalidRequest, request: request)))
            return nil
        }
        
        var urlRequest = URLRequest(url: url,
                                    cachePolicy: request.cachePolicy,
                                    timeoutInterval: request.timeoutInterval)
        
        urlRequest.httpMethod = request.method.rawValue
        
        for (header, value) in request.headers {
            urlRequest.addValue(value, forHTTPHeaderField: header)
        }
        
        if let body = request.body, body.isEmpty == false {
            
            for (header, value) in body.additionalHeaders {
                urlRequest.addValue(value, forHTTPHeaderField: header)
            }
            
            do {
                urlRequest.httpBody = try body.encode()
            } catch {
                callback(.failure(.init(code: .invalidRequest, request: request)))
                return nil
            }
        }
        
        let dataTask = self.dataTask(with: urlRequest) { data, response, error in
            let result = HTTPResult(request: request,
                                    responseData: data,
                                    response: response,
                                    error: error)
            callback(result)
        }
        
        dataTask.resume()
        
        return dataTask
    }
}

extension URLSessionDataTask: Cancellable {}
