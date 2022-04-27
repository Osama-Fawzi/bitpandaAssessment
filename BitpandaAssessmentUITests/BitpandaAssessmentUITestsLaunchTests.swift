//
//  BitpandaAssessmentUITestsLaunchTests.swift
//  BitpandaAssessmentUITests
//
//  Created by Osama Fawzi on 27.04.22.
//

import XCTest

class BitpandaAssessmentUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
