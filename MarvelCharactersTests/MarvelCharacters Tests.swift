//
//  MarvelCharactersTests.swift
//  MarvelCharactersTests
//
//  Created by Osamu Chiba on 9/23/21.
//

import XCTest
@testable import MarvelCharacters
import CryptoKit
import Combine

class MarvelCharactersTests: XCTestCase {
    let fetcher = MarvelFetcher()
    private var disposables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // Reference:
    // https://mokacoding.com/blog/testing-combine-publisher-cheatsheet/
    func testExample() throws {
        let expectation = self.expectation(description: "Get Characters")
        var code: Int = 0

        fetcher.fetchCharacters(offset: 0)
        .map { response in
            code = response.code
        }
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { completion in
       
            switch completion {
                case .failure(let error):
                    print("Failed 😫: \(error.localizedDescription)")
                case .finished:
                    break
            }
            expectation.fulfill()
        },
        receiveValue: {
        })
        .store(in: &disposables)
        
        wait(for: [expectation], timeout: 5)
        XCTAssertTrue(code == 200)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFormatTo1Fraction() {
        let double1 = 9.89
        XCTAssertTrue(double1.formatTo1Fraction == "9.9")
        
        let double2 = 19.81
        XCTAssertFalse(double2.formatTo1Fraction == "19.9")
    }
}
