//
//  AddEntryUnitTest.swift
//  dda-tapTests
//
//  Created by Kushagra Sharma on 2020-01-18.
//  Copyright © 2020 Code the Change. All rights reserved.
//

import XCTest
@testable import dda_tap


class AddEntryUnitTest: XCTestCase {
    
    var vc: dda_tap.AddEntryViewController!
    

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        //let storyboard = UIStoryboard(name: "UIViewController-r0p-QC-M8W", bundle: nil)
        let storyboard = UIStoryboard(name: "AddEntry", bundle: nil)
        
        vc = storyboard.instantiateViewController(withIdentifier: "UIViewController-r0p-QC-M8W") as? dda_tap.AddEntryViewController
        // Call viewDidLoad
        vc.loadView()
        vc.viewDidLoad()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSaveEntryButtonWithMissingImageAudio() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //vc.onSaveEntryButton(nil)
        vc.onSaveEntryButton(self)
        assert(true)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
