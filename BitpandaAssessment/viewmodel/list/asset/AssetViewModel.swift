//
//  AssetViewModel.swift
//  BitpandaAssessment
//
//  Created by Osama Fawzi on 23.04.22.
//

import Foundation
import UIKit

class AssetViewModel: ListBaseViewModel {

    private var assets: AssetsGroup

    init(dataProvider: DataProviderInterface) {
        do {
            assets = try dataProvider.getAssetGroup()
        } catch let error {
            fatalError(error.localizedDescription)
        }

        super.init()
        prepareModels()
        prepareTableViewSections(category: assets)
        setupTableViewDelgate()
        setupTableViewDataSource()
    }

    private func prepareModels() {
        assets.fiats = assets.fiats.filter({ $0.attributes.hasWallets })
    }
}

extension AssetViewModel: ListViewModelInterface {

    var shouldToast: Bool {
        return true
    }

    var hasFilter: Bool {
        return true
    }

    func filterDidChange(indices: [Int], options: [String]) {
        guard !options.isEmpty else {
            tableViewDataSource?.sections = sections
            return
        }

        let filteredSections = self.sections.filter({options.contains($0.type.rawValue)})
        self.tableViewDataSource?.sections = filteredSections
    }

    func setupNavigationItem() -> [UINavigationItem] {
        let walletAction = #selector(showWallet)
        let walletButton = UIBarButtonItem(image: UIImage(named: "wallet"),
                                           style: .plain,
                                           target: self,
                                           action: walletAction)
        walletButton.tintColor = UIColor.systemBlack

        let navigationItem = UINavigationItem(title: "Assets")
        navigationItem.rightBarButtonItems = [walletButton]

        return [navigationItem]
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
