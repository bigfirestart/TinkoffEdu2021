//
//  TinkoffEduUITests.swift
//  TinkoffEduUITests
//
//  Created by Кирилл Лукьянов on 05.05.2021.
//

import XCTest

class TinkoffEduUITests: XCTestCase {
    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.navigationBars["Tinkoff Chat"].buttons["Profile"].tap()
        
        let textFields = app.textFields
        let textViews = app.textViews
        
        XCTAssertEqual(textFields.count, 1)
        XCTAssertEqual(textViews.count, 1)
       
    }
}
