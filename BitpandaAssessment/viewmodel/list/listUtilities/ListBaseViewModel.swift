//
//  ListBaseViewModel.swift
//  BitpandaAssessment
//
//  Created by Osama Fawzi on 25.04.22.
//

import Foundation

class ListBaseViewModel {

    var tableViewDelegate: TableViewDelegate?
    var tableViewDataSource: TableViewDataSource?
    lazy var sections: [ListSection] = []

    lazy var navigationBarDelegate = NavigationBarDelegate()

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
