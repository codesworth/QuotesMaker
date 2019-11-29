//
//  HomeVCTests.swift
//  QuotesMakerTests
//
//  Created by Shadrach Mensah on 20/11/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import XCTest
@testable import QuotesMaker

class HomeVCTests: XCTestCase {
    
    private var home:HomePageVC!

    override func setUp() {
        if UIDevice.current.userInterfaceIdiom == .phone{
            home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:"\(HomePageVC.self)") as? HomePageVC
            
        }else{
            home = UIStoryboard(name: "iPadMain", bundle: nil).instantiateViewController(withIdentifier:"\(HomePageVC.self)") as? HomePageVC
        }
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_recent_isLoaded(){
        home.loadViewIfNeeded()
        XCTAssertEqual(home.recentCollectionVIew.numberOfItems(inSection: 0), home.allModels.count, "Uneven number of recent items")
    }
    
    func test_templatesLoaded(){
        home.loadViewIfNeeded()
        XCTAssertEqual(home.dimensionsProjectCollection.numberOfItems(inSection: 0),home.sizes.count)
    }
    
    func donottest_RecentSelected(){
        home.loadViewIfNeeded()
        home.refreshRecent()
        let studio = home.collectionViewItemSelected(collectionView: home.recentCollectionVIew, indexPath: IndexPath(row: 0, section: 0))
        if UIDevice.current.userInterfaceIdiom == .phone{
            XCTAssertNotNil(studio as? StudioVC, "Error creating studio from recent")
            XCTAssertNotNil((studio as? StudioVC)?.coordinator.existingModel, "Unable to initilaize studio with recent Model")
        }else{
           XCTAssertNotNil(studio as? iPadStudioVC, "Error creating studio from recent")
            XCTAssertNotNil((studio as? iPadStudioVC)?.coordinator.existingModel, "Unable to initilaize studio with recent Model")
        }
    }
    
    func test_DimensionsProjectSelected(){
        home.loadViewIfNeeded()
        let studio = home.collectionViewItemSelected(collectionView: home.dimensionsProjectCollection, indexPath: IndexPath(row: 0, section: 0))
        if UIDevice.current.userInterfaceIdiom == .phone{
            XCTAssertNotNil(studio as? StudioVC, "Error creating studio from recent")
            XCTAssertEqual((studio as? StudioVC)!.canvas, Canvas(aspect: .instagram),"Unable to initilaize studio with recent Model")
        }else{
           XCTAssertNotNil(studio as? iPadStudioVC, "Error creating studio from recent")
            XCTAssertEqual((studio as? iPadStudioVC)!.canvas, Canvas(aspect: .instagram),"Unable to initilaize studio with recent Model")
            
        }
    }


}
