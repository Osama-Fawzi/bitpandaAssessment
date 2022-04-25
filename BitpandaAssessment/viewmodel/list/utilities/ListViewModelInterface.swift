//
//  ListInterface.swift
//  BitpandaAssessment
//
//  Created by Osama Fawzi on 23.04.22.
//

import Foundation
import UIKit

protocol ListViewModelInterface {
    var tableViewDelegate: TableViewDelegate? { get }
    var tableViewDataSource: TableViewDataSource? { get }
    var navigationBarDelegate: NavigationBarDelegate  { get }
    var filterDidChange: (()->())? { get set }

    func setupNavigationItem() -> [UINavigationItem]
    func setupTableViewDataSource()
    func setupTableViewDelgate()
    func setupFilterDataSource()
    func setupFilterDelegate()
}

extension ListViewModelInterface {
    var navigationItem: [UINavigationItem] {
        setupNavigationItem()
    }

    func setupFilterDataSource() {}
    func setupFilterDelegate() {}
}
