//
//  movieAppUITests.swift
//  movieAppUITests
//
//  Created by Consultant on 1/6/23.
//

import XCTest

final class movieAppUITests: XCTestCase {

    func testNavigation() {

        let app = XCUIApplication()
        app.launch()
        
        
        let avatarPredicate = NSPredicate(format: "label beginswith 'Avatar: The Way of Water'")

        app.tables.buttons.element(matching: avatarPredicate).tap()
        XCTAssert(app.staticTexts["Avatar: The Way of Water"].exists)
        app.navigationBars.buttons["Top Movies"].tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
