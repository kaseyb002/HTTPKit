import XCTest
@testable import HTTPKit

final class HTTPKitTests: XCTestCase {
    func testCharacter() {
        let expectation = XCTestExpectation()
        let request = StarWarsCharacterRequest(personId: "1")
        URLSession.shared.sendTyped(request) { result in
            switch result {
            case .success(let character):
                print(character.name)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.description)
            }
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func testCharacterList() {
        let expectation = XCTestExpectation()
        let request = StarWarsCharacterListRequest()
        URLSession.shared.sendTyped(request) { result in
            switch result {
            case .success(let list):
                print("count: \(list.count)")
                print("next: \(list.next?.absoluteString ?? "nil")")
                print("prev: \(list.previous?.absoluteString ?? "nil")")
                for c in list.results {
                    print("name: \(c.name)")
                }
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.description)
            }
        }
        wait(for: [expectation], timeout: 10)
    }
}

protocol StarWarsRequest: HTTPRequestable {
    var endpoint: String { get }
}

extension StarWarsRequest {
    var url: URL? {
        let baseURL = URL(string: "https://swapi.dev/api/")!
        var urlComponents = URLComponents(
            url: baseURL.appendingPathComponent(endpoint),
            resolvingAgainstBaseURL: true
        )!
        urlComponents.queryItems = [
            URLQueryItem(name: "format", value: "json"),
        ]
        return urlComponents.url
    }
}

struct StarWarsCharacterListRequest: TypedHTTPRequestable, StarWarsRequest {
    typealias ResponseType = StarWarsCharacterList
    var endpoint: String { "people" }
}

struct StarWarsCharacterRequest: TypedHTTPRequestable, StarWarsRequest {
    typealias ResponseType = StarWarsCharacter
    
    let personId: String
    var endpoint: String { "people/\(personId)" }
}

struct StarWarsCharacterList: Decodable {
    let count: Int
    let next: URL?
    let previous: URL?
    let results: [StarWarsCharacter]
}

struct StarWarsCharacter: Decodable {
    let name: String
}
