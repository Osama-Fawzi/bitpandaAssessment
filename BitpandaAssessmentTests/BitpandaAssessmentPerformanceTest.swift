//
//  BitpandaAssessmentPerformanceTest.swift
//  BitpandaAssessmentTests
//
//  Created by Osama Fawzi on 27.04.22.
//

import XCTest
@testable import BitpandaAssessment

class BitpandaAssessmentPerformanceTest: XCTestCase {
    // All performance test cases toke a place on iPhone 13 Pro Max
    // and baseline calculated accordingly
    // MARK: - ATTENTION: Behaviour of MAXSTDDEV in Xcode is buggy, as sometime it still mesureing in respect to default value (10%) no matter what is the configured value!!

    var dataProvider: DataProviderInterface!
    var viewModel: ListViewModelInterface!
    var viewController: ListViewController!

    func testAssetPrepareModelsPerformance() {
        dataProvider = DataProvider()
        viewModel = AssetViewModel(dataProvider: dataProvider)
        measure(
            metrics: [
                XCTClockMetric(),
                XCTCPUMetric(),
                XCTStorageMetric(),
                XCTMemoryMetric()
            ]
        ) {
            (viewModel as! AssetViewModel).prepareModels()
        }
    }

    func testWalletPrepareModelsPerformance() {
        dataProvider = DataProvider()
        viewModel = WalletViewModel(dataProvider: dataProvider)
        measure(
            metrics: [
                XCTClockMetric(),
                XCTCPUMetric(),
                XCTStorageMetric(),
                XCTMemoryMetric()
            ]
        ) {
            (viewModel as! WalletViewModel).prepareModels()
        }
    }

    override func tearDownWithError() throws {
        dataProvider = nil
        viewModel = nil
        viewController = nil
        try super.tearDownWithError()
    }

}
