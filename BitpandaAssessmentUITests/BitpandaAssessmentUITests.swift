//
//  BitpandaAssessmentUITests.swift
//  BitpandaAssessmentUITests
//
//  Created by Osama Fawzi on 27.04.22.
//

import XCTest
@testable import BitpandaAssessment

class BitpandaAssessmentUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
    }

    func testAssetScreenBehaviour() {
        app.launchEnvironment["SKIP_SPLASH_TO"] = "Asset"
        app.launch()

        let assetsNavigationBar = app.navigationBars["Assets"]
        let walletNavigationBar = app.navigationBars["Wallet"]

        let walletItem = assetsNavigationBar.buttons["wallet"]
        let filterItem = assetsNavigationBar.buttons["filter"]
        let dismissItem = walletNavigationBar.buttons["Dismiss"]

        let filterOption1 = app.tables.staticTexts["cryptocoin"]
        let filterOption2 = app.tables.staticTexts["commodity"]
        let filterOption3 = app.tables.staticTexts["fiat"]


        XCTAssertTrue(assetsNavigationBar.exists)
        XCTAssertTrue(walletItem.exists)
        XCTAssertTrue(filterItem.exists)

        filterItem.tap()
        XCTAssertTrue(filterOption1.exists)
        XCTAssertTrue(filterOption2.exists)
        XCTAssertTrue(filterOption3.exists)

        walletItem.tap()
        XCTAssertTrue(walletNavigationBar.exists)
        XCTAssertTrue(dismissItem.exists)

        dismissItem.tap()

    }

    func testWalletScreenBehaviour() {
        app.launchEnvironment["SKIP_SPLASH_TO"] = "Wallet"
        app.launch()

        let assetsNavigationBar = app.navigationBars["Assets"]
        let walletNavigationBar = app.navigationBars["Wallet"]

        let walletItem = assetsNavigationBar.buttons["wallet"]
        let filterItem = assetsNavigationBar.buttons["filter"]
        let dismissItem = walletNavigationBar.buttons["Dismiss"]

        let filterOption1 = app.tables.staticTexts["cryptocoin"]
        let filterOption2 = app.tables.staticTexts["commodity"]
        let filterOption3 = app.tables.staticTexts["fiat"]

        XCTAssertTrue(walletNavigationBar.exists)
        XCTAssertTrue(dismissItem.exists)

        dismissItem.tap()
        XCTAssertTrue(assetsNavigationBar.exists)
        XCTAssertTrue(walletItem.exists)
        XCTAssertTrue(filterItem.exists)

        filterItem.tap()
        XCTAssertTrue(filterOption1.exists)
        XCTAssertTrue(filterOption2.exists)
        XCTAssertTrue(filterOption3.exists)
    }
}
