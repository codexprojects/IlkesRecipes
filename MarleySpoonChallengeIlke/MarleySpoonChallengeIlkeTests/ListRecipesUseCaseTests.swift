//
//  ListRecipesUseCaseTests.swift
//  MarleySpoonChallengeIlkeTests
//
//  Created by Ilke Yucel on 5.09.2021.
//

import XCTest
import MarleySpoonChallengeIlke

class ListRecipesUseCaseTests: XCTestCase {
    
    func test_init_doesNotRequestFromURL() {
        let (_, client) = makeSUT()
        
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    
    // MARK: - Helpers
    
    private func makeSUT(url: URL =  URL(string: "https://a-url.com")!, file: StaticString = #filePath, line: UInt = #line) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        
        return(sut, client)
    }
    
    private class HTTPClientSpy: HTTPClient {
        private var messages = [(url: URL, completion: (HTTPClientResult) -> Void)]()
        
        var requestedURLs: [URL] {
            return messages.map{ $0.url}
        }
        
        func get(from url:URL, completion: @escaping (HTTPClientResult) -> Void) {
            messages.append((url, completion))
        }
        
        func complete(with error: Error, at index: Int = 0) {
            messages[index].completion(.failure(error))
        }
        
        func complete(withStatusCode code: Int, data: Data, at index: Int = 0) {
            let response = HTTPURLResponse(url: requestedURLs[index],
                                           statusCode: code,
                                           httpVersion: nil,
                                           headerFields: nil
            )!
            messages[index].completion(.success(data, response))
        }
    }
    
}

public protocol HTTPClient {
    func get(from url:URL, completion: @escaping (HTTPClientResult) -> Void)
}

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public enum LoadFeedResult {
    case success([Any])
    case failure(Error)
}

private protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}

public final class RemoteFeedLoader: FeedLoader {
    private let url: URL
    private let client: HTTPClient
   
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public typealias Result = LoadFeedResult
   
    public init(url: URL, client: HTTPClient) {
        self.client = client
        self.url = url
    }
    
    public func load(completion: @escaping (LoadFeedResult) -> Void) {
        
    }

}
