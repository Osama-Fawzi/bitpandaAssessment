//
//  ListViewController.swift
//  BitpandaAssessment
//
//  Created by Osama Fawzi on 23.04.22.
//

import UIKit

class ListViewController: UIViewController {
    
    private var viewModel: ListViewModelInterface?
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTableView()
        bind()
    }
    
    init(viewModel: ListViewModelInterface) {
        super.init(nibName: String(describing: Self.self), bundle: nil)
        
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupNavigationBar() {
        navigationBar.delegate = viewModel?.navigationBarDelegate
        navigationBar.items = viewModel?.navigationItem
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.register(UINib(nibName: ItemCell.identifer, bundle: nil), forCellReuseIdentifier: ItemCell.identifer)
        tableView.delegate = viewModel?.tableViewDelegate
        tableView.dataSource = viewModel?.tableViewDataSource
    }

    private func bind() {
        viewModel?.filterDidChange = { [weak self] in
            self?.tableView.reloadData()
        }
    }

    override func becomeFirstResponder() -> Bool {
        return true
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?){
        if motion == .motionShake {
            if viewModel is AssetViewModel {
                Coordinator.shared.showWallet()
            } else {
                Coordinator.shared.dismiss()
            }
        }
    }
}
