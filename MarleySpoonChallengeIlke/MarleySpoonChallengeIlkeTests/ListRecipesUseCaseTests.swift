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
        let sut = makeSUT()

        XCTAssertTrue(sut.requestedQueries.isEmpty)
    }

    func test_load_requestsDataFromURL() {
        let query = "recipe"
        let sut = makeSUT(queryString: query)
        
        sut.loadAllRecipes(with: query) { _ in }
        
        XCTAssertEqual(sut.requestedQueries, [query])
    }
    
    func test_loadTwice_requestsDataFromURL() {
        let query = "recipe"
        let sut = makeSUT()
        
        sut.loadAllRecipes(with: query){ _ in }
        sut.loadAllRecipes(with: query){ _ in }
        
        XCTAssertEqual(sut.requestedQueries, [query, query])
    }
  
   //  MARK: - Helpers
    
    private func makeSUT(queryString: String = "", file: StaticString = #filePath, line: UInt = #line) -> RemoteRecipeLoaderSpy {

        let sut = RemoteRecipeLoaderSpy(spaceId: "", accessToken: "")
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
  
}
