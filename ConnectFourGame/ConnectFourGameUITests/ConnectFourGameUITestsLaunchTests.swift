//
//  ConnectFourGameUITestsLaunchTests.swift
//  ConnectFourGameUITests
//
//  Created by George Michelon on 02/03/23.
//

import XCTest

final class ConnectFourGameUITestsLaunchTests: XCTestCase {

    func testPlayerTurn() {
//        // Given
//        let gameLogicVM = GameLogicViewModel()
//        gameLogicVM.currentUser = 1
//        gameLogicVM.hole = Array(repeating: .blank, count: 42)
//        let index = 5 // arbitrary index for testing
//
//        // When
//        gameLogicVM.playerTurn(index: index)
//
//        // Then
//        // Check if the turn has been updated to .another
//        XCTAssertEqual(gameLogicVM.turn, .another)
//
//        // Check if currentUser has been decremented by 1
//        XCTAssertEqual(gameLogicVM.currentUser, 0)
//
//        // Check if the correct hole indexes have been updated to .user
//        XCTAssertEqual(gameLogicVM.hole[5], .user)
//        XCTAssertEqual(gameLogicVM.hole[12], .user)
//        XCTAssertEqual(gameLogicVM.hole[19], .user)
//        XCTAssertEqual(gameLogicVM.hole[26], .user)
//        XCTAssertEqual(gameLogicVM.hole[33], .user)
//        XCTAssertEqual(gameLogicVM.hole[40], .user)
//
//        // Check if the other holes have not been updated
//        for i in 0..<gameLogicVM.hole.count {
//            if i != 5 && i != 12 && i != 19 && i != 26 && i != 33 && i != 40 {
//                XCTAssertEqual(gameController.hole[i], .blank)
//            }
//        }
    }
    

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
