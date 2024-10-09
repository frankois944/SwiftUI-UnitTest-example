//
//  ViewTestTests.swift
//  ViewTestTests
//
//  Created by Francois Dabonot on 04/10/2024.
//

import XCTest
import ViewInspector
import SnapshotTesting
@testable import ViewTest

extension Inspection: @retroactive InspectionEmissary { }


final class ViewTestTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    @MainActor
    func testSample() throws {
        let sut = ContentView()
        let value = try sut.inspect().implicitAnyView().vStack().text(0).string()
        XCTAssertEqual(value, "Current status: Waiting for action!")
    }
    
    
    @MainActor
    func testStateTap() throws {
        let sut = ContentView()
        let exp = sut.inspection.inspect { view in
            let value = try view.implicitAnyView().vStack().text(0).string()
            XCTAssertEqual(value, "Current status: Waiting for action!")
            try view.implicitAnyView().vStack().button(1).tap()
            let value2 = try view.implicitAnyView().vStack().text(0).string()
            XCTAssertEqual(value2, "Current status: Action done!")
        }
        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 0.1)
    }

    @MainActor
    func testSnapshotTap() throws {
        let sut = ContentView()
        let exp = sut.inspection.inspect { view in
            assertSnapshot(of: try view.actualView().body, as: .image(layout: .device(config: .iPhoneSe)))
            try view.implicitAnyView().vStack().button(1).tap()
            assertSnapshot(of: try view.actualView().body, as: .image(layout: .device(config: .iPhoneSe)))
        }
        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 0.1)
    }
}
