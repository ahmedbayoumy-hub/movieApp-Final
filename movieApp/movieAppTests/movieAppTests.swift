//
//  movieAppTests.swift
//  movieAppTests
//
//  Created by Consultant on 1/6/23.
//

import XCTest
@testable import movieApp

final class movieAppTests: XCTestCase {
    
    var result: Movie?

    func testMovieTitles () {
        XCTAssertEqual(result!.results.first?.title, "Avatar: The Way of Water")
    }

}
