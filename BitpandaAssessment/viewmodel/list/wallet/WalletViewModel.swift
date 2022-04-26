//
//  WalletViewModel.swift
//  BitpandaAssessment
//
//  Created by Osama Fawzi on 24.04.22.
//

import Foundation
import UIKit

class WalletViewModel: ListBaseViewModel {

    var tableViewDelegate: TableViewDelegate?
    var tableViewDataSource: TableViewDataSource?
    lazy var sections: [ListSection] = []
    private var assets: AssetsGroup
    private var wallets: WalletsGroup

    lazy var navigationBarDelegate = NavigationBarDelegate()
    
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
        sections = prepareTableViewSections(category: wallets)
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
    var title: String {
        "Wallet"
    }

    var barButtonItem: UIBarButtonItem? {
        UIBarButtonItem(title: "Dismiss", image: nil, target: self, action: #selector(backAction), position: .left)
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
