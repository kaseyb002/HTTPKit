import XCTest
@testable import HTTPKit

final class HTTPKitTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
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

protocol StarWarsRequest {
    var address: String { get }
}

extension StarWarsRequest {
    var baseUrl: String { "https://swapi.dev/api" }
    var path: String { baseUrl + address }
}

struct StarWarsCharacterListRequest: TypedHTTPRequestable, StarWarsRequest {
    typealias ResponseType = StarWarsCharacterList
    var address: String { "/people" }
}

struct StarWarsCharacterRequest: TypedHTTPRequestable, StarWarsRequest {
    typealias ResponseType = StarWarsCharacter
    
    let personId: String
    var address: String { "/people/\(personId)" }
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
