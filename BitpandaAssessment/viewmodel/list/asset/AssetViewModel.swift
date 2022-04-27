//
//  AssetViewModel.swift
//  BitpandaAssessment
//
//  Created by Osama Fawzi on 23.04.22.
//

import Foundation
import UIKit

class AssetViewModel {
    private(set) var tableViewDelegate: TableViewDelegate?
    private(set) var tableViewDataSource: TableViewDataSource?
    lazy var sections: [ListSection] = []
    private var assets: AssetsGroup

    private(set) lazy var navigationBarDelegate = NavigationBarDelegate()

    init(dataProvider: DataProviderInterface) {
        do {
            assets = try dataProvider.getAssetGroup()
        } catch let error {
            fatalError(error.localizedDescription)
        }
        prepareModels()
        sections = prepareTableViewSections(category: assets)
        setupTableViewDelgate()
        setupTableViewDataSource()
    }

    func prepareModels() {
        assets.fiats = assets.fiats.filter({ $0.attributes.hasWallets })
    }
}

extension AssetViewModel: ListViewModelInterface {
    var title: String {
        return "Assets"
    }

    var shouldToast: Bool {
        return true
    }

    var filterState: Position {
        return .left
    }

    var barButtonItem: UIBarButtonItem? {
        UIBarButtonItem(image: UIImage(named: "wallet"),
                        target: self,
                        action: #selector(showWallet),
                        position: .right)
    }
    
    func setupTableViewDataSource() {
        tableViewDataSource = TableViewDataSource(sections: sections)
    }
    
    func setupTableViewDelgate() {
        tableViewDelegate = TableViewDelegate()
    }

    // MARK: - Actions
    @objc
    func showWallet() {
        Coordinator.shared.showWallet()
    }
}
