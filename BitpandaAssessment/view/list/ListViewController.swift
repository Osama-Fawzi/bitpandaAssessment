//
//  ListViewController.swift
//  BitpandaAssessment
//
//  Created by Osama Fawzi on 23.04.22.
//

import UIKit
import Toast_Swift
import DropDown

class ListViewController: UIViewController {
    
    private var viewModel: ListViewModelInterface?
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!

    lazy var filterDropDown: DropDown? = nil
    lazy var generator = UINotificationFeedbackGenerator()

    override func viewDidLoad() {
        super.viewDidLoad()

        toastNotification()
        setupNavigationBar()
        setupFilterDropDown()
        setupTableView()
    }
    
    init(viewModel: ListViewModelInterface) {
        super.init(nibName: String(describing: Self.self), bundle: nil)
        
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func toastNotification() {
        guard let viewModel = viewModel,
        viewModel.shouldToast
        else { return }

        let gifimage = UIImage.gifImageWithName(Helper.shared.isDarkModeEnabled ? "shake_dark" : "shake_white")
        var style = ToastStyle()
        style.backgroundColor = .systemWhite!
        style.titleColor = .systemBlack!
        style.messageColor = .systemBlack!

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [unowned self] in
            view.makeToast("Show/Dismiss Wallet", duration: 3.0, position: .center, title: "Shake Mobile", image: gifimage, style: style, completion: nil)
        }
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

}

// MARK: - DropDown Handling
extension ListViewController {

    private func setupFilterDropDown() {
        guard let viewModel = viewModel,
              viewModel.hasFilter
        else { return }

        let filterBtn = createNavBarItem()

        filterDropDown = DropDown()
        filterDropDown?.textColor = .systemBlack!
        filterDropDown?.backgroundColor = .systemWhite
        filterDropDown?.anchorView = filterBtn
        filterDropDown?.dataSource = viewModel.sections.map({ $0.type.rawValue })
        filterDropDown?.bottomOffset =  CGPoint(x: 0, y: navigationBar.frame.height)

        let filterSelectionAction: MultiSelectionClosure = { [weak self] (indices, options) in
            guard let self = self else { return }
            viewModel.filterDidChange(indices: indices, options: options)
            self.tableView.reloadData()
        }
        filterDropDown?.multiSelectionAction = filterSelectionAction
    }

    func createNavBarItem() -> UIBarButtonItem {
        let filterButton = UIBarButtonItem(image: UIImage(named: "filter"),
                                           style: .plain,
                                           target: self,
                                           action: #selector(filterAction))

        filterButton.tintColor = UIColor.systemBlack

        if let navigationItem = navigationBar.items?.first {
            navigationItem.leftBarButtonItem = filterButton
        } else {
            let navigationItem = UINavigationItem()
            navigationItem.leftBarButtonItem = filterButton
            navigationBar.items = [navigationItem]
        }

        return filterButton
    }

// MARK: - Filter Actions
    @objc
    func filterAction() {
        let animations: (()->Void) = { [weak self] in
            self?.filterDropDown?.show()
        }

        UIView.transition(with: filterDropDown!,
                          duration: 0.5,
                          options: .transitionFlipFromBottom,
                          animations: animations,
                          completion: nil)
    }
}

// MARK: - Motion Handling
extension ListViewController {

    override func becomeFirstResponder() -> Bool {
        return true
    }

    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            if viewModel is AssetViewModel {
                Coordinator.shared.showWallet()
                applyHapticEffect(.show)
            } else {
                Coordinator.shared.dismiss()
                applyHapticEffect(.dismiss)
            }
        }
    }

//    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?){
//        if motion == .motionShake {
//            if viewModel is AssetViewModel {
//                Coordinator.shared.showWallet()
//            } else {
//                Coordinator.shared.dismiss()
//            }
//        }
//    }
}

// MARK: - Happtic Effect
extension ListViewController {

    typealias FeedBackType =  UINotificationFeedbackGenerator.FeedbackType

    enum HapticType {
        case show
        case dismiss

        var feedbackType: FeedBackType {
            switch self {
            case .show:
                return .success
            case .dismiss:
                return .warning
            }
        }
    }

    func applyHapticEffect(_ state: HapticType) {
        self.generator.notificationOccurred(state.feedbackType)

    }
}
