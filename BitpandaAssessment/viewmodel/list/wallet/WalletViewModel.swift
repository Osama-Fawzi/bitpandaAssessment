//
//  WalletViewModel.swift
//  BitpandaAssessment
//
//  Created by Osama Fawzi on 24.04.22.
//

import Foundation
import UIKit

class ListBaseViewModel {

    var tableViewDelegate: TableViewDelegate?
    var tableViewDataSource: TableViewDataSource?
    lazy var navigationBarDelegate = NavigationBarDelegate()
    lazy var sections: [ListSection] = []

    var filterDidChange: (()->())?

    func prepareTableViewSections(category: Any) {
        Mirror(reflecting: category).children.forEach { child in
            if let asset = child.value as? [ItemInterface],
               let type = asset.first?.type {

                let viewModels = asset.map({ item -> ItemCellViewModel in
                    ItemCellViewModel(item: item)
                })
                sections.append(ListSection(type: type, items: viewModels))
            }
        }
    }
}

class WalletViewModel: ListBaseViewModel {

    private var assets: AssetsGroup
    private var wallets: WalletsGroup

    init(dataProvider: DataProviderInterface) {
        do {
            let collections = try dataProvider.getCollections()
            assets = collections.assetGroup
            wallets = collections.walletGroup
        } catch let error {
            fatalError(error.localizedDescription)
        }

        super.init()
        prepareModels()
        prepareTableViewSections(category: wallets)
        setupTableViewDelgate()
        setupTableViewDataSource()
    }

    private func prepareModels() {
        wallets.cryptocoinWallets = wallets.cryptocoinWallets.filter { item in
            let cryptocoin = assets.cryptocoins.first(where: {$0.id == item.attributes.cryptocoinID})
            item.attributes.logo = cryptocoin?.attributes.logo
            item.attributes.logoDark = cryptocoin?.attributes.logoDark
            return !item.attributes.isDeleted
        }
        wallets.cryptocoinWallets = Helper.shared.sort(collection: wallets.cryptocoinWallets)

        wallets.commodityWallets = wallets.commodityWallets.filter { item in
            let commodity = assets.commodities.first(where: {$0.id == item.attributes.cryptocoinID})
            item.attributes.logo = commodity?.attributes.logo
            item.attributes.logoDark = commodity?.attributes.logoDark
            return !item.attributes.isDeleted
        }
        wallets.commodityWallets = Helper.shared.sort(collection: wallets.commodityWallets)

        wallets.fiatWallets.forEach { item in
            let fiat = assets.fiats.first(where: {$0.id == item.attributes.fiatID})
            item.attributes.logo = fiat?.attributes.logo
            item.attributes.logoDark = fiat?.attributes.logoDark
        }
        wallets.fiatWallets = Helper.shared.sort(collection: wallets.fiatWallets)
    }
}

extension WalletViewModel: ListViewModelInterface {
    func setupNavigationItem() -> [UINavigationItem] {


        let backAction = #selector(backAction)
        let backButton = UIBarButtonItem(title: "Dismiss",
                                         style: .plain,
                                         target: self,
                                         action: backAction)
        backButton.tintColor = UIColor.systemBlack

        let navigationItem = UINavigationItem(title: "Wallet")
        navigationItem.leftBarButtonItems = [backButton]

        return [navigationItem]
    }

    func setupTableViewDataSource() {
        tableViewDataSource = TableViewDataSource(sections: sections)
    }

    func setupTableViewDelgate() {
        tableViewDelegate = TableViewDelegate()
    }

    @objc
    func backAction() {
        Coordinator.shared.dismiss()
    }

}
