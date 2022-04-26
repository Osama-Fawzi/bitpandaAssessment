//
//  ListInterface.swift
//  BitpandaAssessment
//
//  Created by Osama Fawzi on 23.04.22.
//

import Foundation
import UIKit

enum Position {
    case left, right, none

    var isExist: Bool {
        switch self {
        case .none:
            return false
        default:
            return true
        }
    }

    var isRight: Bool {
        switch self {
        case .right:
            return true
        default:
            return false
        }
    }

    var isLeft: Bool {
        switch self {
        case .left:
            return true
        default:
            return false
        }
    }
}

protocol ListViewModelInterface {
    var title: String { get }
    var shouldToast: Bool { get }
    var tableViewDelegate: TableViewDelegate? { get }
    var tableViewDataSource: TableViewDataSource? { get }
    var sections: [ListSection] { get set }
    var navigationBarDelegate: NavigationBarDelegate  { get }
    var filterState: Position { get }
    var barButtonItem: UIBarButtonItem? { get }

    func setupTableViewDataSource()
    func setupTableViewDelgate()
    func filterDidChange(indices: [Int], options: [String])

}

extension ListViewModelInterface {
    var title: String {
        ""
    }

    var shouldToast: Bool {
        return false
    }

    var filterState: Position {
        return .none
    }

    var barButtonItem: UIBarButtonItem? {
        nil
    }

    func filterDidChange(indices: [Int], options: [String]) {
        guard !options.isEmpty else {
            tableViewDataSource?.sections = sections
            return
        }

        let filteredSections = self.sections.filter({options.contains($0.type.rawValue)})
        self.tableViewDataSource?.sections = filteredSections
    }

    func prepareTableViewSections(category: Any) -> [ListSection] {
        Mirror(reflecting: category).children.compactMap { child -> ListSection? in
            if let asset = child.value as? [ItemInterface],
               let type = asset.first?.type {

                let viewModels = asset.map({ item -> ItemCellViewModel in
                    ItemCellViewModel(item: item)
                })
                return ListSection(type: type, items: viewModels)
            }
            return nil
        }
    }
}
