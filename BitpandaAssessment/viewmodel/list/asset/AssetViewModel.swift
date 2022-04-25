//
//  AssetViewModel.swift
//  BitpandaAssessment
//
//  Created by Osama Fawzi on 23.04.22.
//

import Foundation
import UIKit
import DropDown

class AssetViewModel: ListBaseViewModel {

    private lazy var filterDropDown = DropDown()
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
    func setupNavigationItem() -> [UINavigationItem] {
        let walletAction = #selector(showWallet)
        let walletButton = UIBarButtonItem(image: UIImage(named: "wallet"),
                                           style: .plain,
                                           target: self,
                                           action: walletAction)
        walletButton.tintColor = UIColor.systemBlack

        let filterAction = #selector(showfilterDropDown)
        let filterButton = UIBarButtonItem(image: UIImage(named: "filter"),
                                         style: .plain,
                                         target: self,
                                         action: filterAction)
        filterButton.tintColor = UIColor.systemBlack
        setupDropDown(to: filterButton)

        let navigationItem = UINavigationItem(title: "Assets")
        navigationItem.rightBarButtonItems = [walletButton]
        navigationItem.leftBarButtonItems = [filterButton]

        return [navigationItem]
    }
    
    func setupTableViewDataSource() {
        tableViewDataSource = TableViewDataSource(sections: sections)
    }
    
    func setupTableViewDelgate() {
        tableViewDelegate = TableViewDelegate()
    }


    private func setupDropDown(to barItmem: UIBarButtonItem) {
        filterDropDown.textColor = .systemBlack!
        filterDropDown.backgroundColor = .systemWhite
        filterDropDown.anchorView = barItmem
        filterDropDown.dataSource = sections.map({ $0.type.rawValue })
        filterDropDown.bottomOffset = CGPoint(x: 0, y: 50)
        filterDropDown.width = 100

        let filterSelectionAction: MultiSelectionClosure = { [weak self] (indces, options) in
            guard let self = self else { return }

            guard !options.isEmpty else {
                self.tableViewDataSource?.sections = self.sections
                if let filterDidChange = self.filterDidChange {
                    filterDidChange()
                }
                return
            }

            let filteredSections = self.sections.filter({options.contains($0.type.rawValue)})
            self.tableViewDataSource?.sections = filteredSections

            if let filterDidChange = self.filterDidChange {
                filterDidChange()
            }
        }
        filterDropDown.multiSelectionAction = filterSelectionAction
    }

    // MARK: - Actions
    @objc
    func showfilterDropDown() {
        filterDropDown.show()
    }

    @objc
    func showWallet() {
        Coordinator.shared.showWallet()
    }
}
