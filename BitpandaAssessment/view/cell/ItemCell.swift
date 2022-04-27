//
//  ItemCell.swift
//  BitpandaAssessment
//
//  Created by Osama Fawzi on 24.04.22.
//

import UIKit
import SDWebImage

protocol ItemCellInterface {
    static var identifer: String { get }
    func configure(with viewModel: ItemCellViewModelInterface)
}

class ItemCell: UITableViewCell, ItemCellInterface {
    var viewModel: ItemCellViewModelInterface?

    static var identifer: String {
            String(describing: Self.self)
    }

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var number: UILabel!

    func configure(with viewModel: ItemCellViewModelInterface) {
        self.viewModel = viewModel

        cardView.backgroundColor = .systemGray6
        cardView.layer.cornerRadius = 5
        cardView.clipsToBounds = true

        icon.loadImage(with: URL(string: viewModel.icon), completed: nil)
        icon.isHidden = !viewModel.isIconExist

        title.text = viewModel.title

        number.text = viewModel.number
        number.isHidden = !viewModel.isNumberFieldExist

        cardView.backgroundColor = viewModel.isDefault ? .systemGray2 : .systemGray6

        cardView.layer.borderWidth = viewModel.isDifferent ? 2 : 0
        cardView.layer.borderColor = UIColor.systemMoneyGreen?.cgColor
    }
}
