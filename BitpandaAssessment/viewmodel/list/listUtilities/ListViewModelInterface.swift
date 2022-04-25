//
//  ListInterface.swift
//  BitpandaAssessment
//
//  Created by Osama Fawzi on 23.04.22.
//

import Foundation
import UIKit

protocol ListViewModelInterface {
    var shouldToast: Bool { get }
    var tableViewDelegate: TableViewDelegate? { get }
    var tableViewDataSource: TableViewDataSource? { get }
    var sections: [ListSection] { get set }
    var navigationBarDelegate: NavigationBarDelegate  { get }
    var hasFilter: Bool { get }

    func setupTableViewDataSource()
    func setupTableViewDelgate()
    func setupNavigationItem() -> [UINavigationItem]
    func filterDidChange(indices: [Int], options: [String])

}

extension ListViewModelInterface {
    var shouldToast: Bool {
        return false
    }
    var hasFilter: Bool {
        return false
    }
    var navigationItem: [UINavigationItem] {
        setupNavigationItem()
    }

    func filterDidChange(indices: [Int], options: [String]) {

    }
}
