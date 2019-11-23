//
//  QuotesMakerUITests.swift
//  QuotesMakerUITests
//
//  Created by Shadrach Mensah on 21/11/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import XCTest

class QuotesMakerUITests: XCTestCase {

    private var app:XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_General_UI(){
        let newProjectCollection = app.scrollViews.otherElements.collectionViews
        let cells = newProjectCollection.cells
        XCTAssertNotNil(cells, "NewProject Cells Do not Exist")
        let igOption = cells.otherElements.containing(.staticText, identifier: "Instagram Post")
        XCTAssertNotNil(igOption, "No Option for selecting IG option")
        //.tap()
        igOption.element.tap()
        
        let studioEditorPanel = app.collectionViews.containing(.other, identifier:"Vertical scroll bar, 2 pages")
        XCTAssertNotNil(studioEditorPanel)
        let addLayerCell = studioEditorPanel.children(matching: .cell).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element
        XCTAssertNotNil(addLayerCell)
        
       addLayerCell.tap()
       
        
        app.scrollViews.otherElements.collectionViews.cells.otherElements.containing(.staticText, identifier:"Instagram Post").element.tap()
        app.collectionViews.containing(.other, identifier:"Vertical scroll bar, 2 pages").children(matching: .cell).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 3).children(matching: .other).element(boundBy: 0).tap()
        
        
    }
    
    func test_story_blankLayer(){
        
        let app = XCUIApplication()
        app.scrollViews.otherElements.collectionViews.cells.otherElements.containing(.staticText, identifier:"Instagram Post").element.tap()
        app.collectionViews.containing(.other, identifier:"Vertical scroll bar, 2 pages").children(matching: .cell).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.tap()
        
        let element4 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element
        let element6 = element4.children(matching: .other).element(boundBy: 3)
        let button = element6.children(matching: .button).element
        button.tap()
        
        let element7 = element4.children(matching: .other).element(boundBy: 1)
        let element = element7.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.tap()
        
        let element2 = element.children(matching: .other).element
        element2.tap()
        element.tap()
        element2.tap()
        
        let element3 = element.children(matching: .other).element(boundBy: 0)
        element3.tap()
        element3.tap()
        element3.tap()
        element2.tap()
        element.tap()
        element2.tap()
        element3.tap()
        element3.tap()
        element3.tap()
        element3.tap()
        element4.children(matching: .other).element(boundBy: 0).collectionViews.children(matching: .cell).element(boundBy: 1).children(matching: .other).element.tap()
        element6.children(matching: .other).element(boundBy: 0).tap()
        
        let slider = app.sliders["100%"]
        slider.tap()
        slider.tap()
        button.tap()
        
        let element5 = element7.children(matching: .other).element(boundBy: 2)
        element5.tap()
        element5.tap()
        element5.tap()
        
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
