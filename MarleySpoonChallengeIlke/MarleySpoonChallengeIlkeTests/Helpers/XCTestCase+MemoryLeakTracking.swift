//
//  XCTestCase+MemoryLeakTracking.swift
//  MarleySpoonChallengeIlkeTests
//
//  Created by Ilke Yucel on 6.09.2021.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocted. Potential memory leak.", file: file, line: line)
        }
    }
}
