//
//  BitpandaAssessmentTests.swift
//  BitpandaAssessmentTests
//
//  Created by Osama Fawzi on 26.04.22.
//

import XCTest

@testable import BitpandaAssessment

class BitpandaAssessmentTests: XCTestCase {
    class TestGroup {
        var item1 = [Cryptocoin]()
        var item2 = [CryptocoinWallet]()
        var item3 = [Commodity]()
        var item4 = [FiatWallet]()

        init(_ dataProvider: DataProviderInterface) {
            do {
                let collection = try dataProvider.getCollections()
                item1 = collection.assetGroup.cryptocoins
                item2 = collection.walletGroup.cryptocoinWallets
                item3 = collection.assetGroup.commodities
                item4 = collection.walletGroup.fiatWallets
            } catch let err {
                XCTFail(err.localizedDescription)
            }
        }
    }

    var dataProvider: DataProviderInterface!
    var viewModel: ListViewModelInterface!
    var viewController: ListViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    func testFilterFunctionality() {
        dataProvider = DataProvider()
        viewModel = AssetViewModel(dataProvider: dataProvider)

        viewModel.sections = ItemType.allCases.map({ListSection(type: $0, items: [])})

        let randomIndex = [Int.random(in: 0..<3), Int.random(in: 4..<6)]

        let testInput = [viewModel.sections[randomIndex[0]].type.rawValue, viewModel.sections[randomIndex[1]].type.rawValue]

        viewModel.filterDidChange(indices: randomIndex, options: testInput)

        XCTAssertEqual(viewModel.tableViewDataSource?.sections.map({$0.type.rawValue}), testInput, "Sections previewd from filteratoin are wrong")
    }

    func testPrepareSectionsFunctionality() {
        dataProvider = DataProvider()
        viewModel = WalletViewModel(dataProvider: dataProvider)

        let testGroup = TestGroup(dataProvider)

        let sectionTypes = viewModel.prepareTableViewSections(category: testGroup).map({$0.type})
        let expectedSectionTypes: [ItemType] = [.cryptocoin, .cryptocoinWallet, .commodity, .fiatWallet]

        XCTAssertEqual(sectionTypes, expectedSectionTypes, "Sections generated from prepare sections functionality are wrong")
    }

    func testSortingAscendinlyFunctionality() {
        dataProvider = DataProvider()
        let testGroup = TestGroup(dataProvider)

        let sortedAscendinly = Helper.shared.sort(collection: testGroup.item1, isAscending: true)

        let index = Int.random(in: 0..<(sortedAscendinly.count-1))
        let nextIndex = index + 1

        if sortedAscendinly[index].numberValue > sortedAscendinly[nextIndex].numberValue {
            XCTFail("Sorting Ascendingly did not work out")
        }
    }

    func testSortingDescendinlyFunctionality() {
        dataProvider = DataProvider()
        let testGroup = TestGroup(dataProvider)

        let sortedDescendinly = Helper.shared.sort(collection: testGroup.item2, isAscending: false)

        let index = Int.random(in: 0..<(sortedDescendinly.count-1))
        let nextIndex = index + 1

        if sortedDescendinly[index].numberValue < sortedDescendinly[nextIndex].numberValue {
            XCTFail("Sorting Descendinly did not work out")
        }
    }

    func testHasFilterProperty() {
        dataProvider = DataProvider()
        viewModel = AssetViewModel(dataProvider: dataProvider)
        viewController = ListViewController(viewModel: viewModel)

        let testGroup = TestGroup(dataProvider)

        let sectionTypes = viewModel.prepareTableViewSections(category: testGroup).map({$0.type})
        let expectedSectionTypes: [ItemType] = [.cryptocoin, .cryptocoinWallet, .commodity, .fiatWallet]

        XCTAssertEqual(sectionTypes, expectedSectionTypes, "Sections generated from prepare sections functionality are wrong")
    }

    func testRetrivingValidData() throws {
        let filename = Bundle.main.fileName
        let jsonURL = Bundle.main.url(forResource: filename, withExtension: "json")
        try XCTSkipUnless((jsonURL != nil), "mocekd data is not found")

        dataProvider = DataProvider()
        do {
            try _ = dataProvider.getCollections()
            try _ = dataProvider.getAssetGroup()
            try _ = dataProvider.getWalletGroup()
        } catch let err {
            XCTFail(err.localizedDescription)
        }

    }

    override func tearDownWithError() throws {
        dataProvider = nil
        viewModel = nil
        viewController = nil
        try super.tearDownWithError()
    }
}
