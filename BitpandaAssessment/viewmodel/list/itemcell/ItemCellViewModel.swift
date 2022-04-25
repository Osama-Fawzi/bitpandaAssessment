//
//  ItemCellViewModel.swift
//  BitpandaAssessment
//
//  Created by Osama Fawzi on 24.04.22.
//

import Foundation

protocol ItemCellViewModelInterface {
    var icon: String { get set }
    var title: String { get set }
    var number: String? { get set }
    var isNumberFieldExist: Bool { get set }
    var isIconExist: Bool { get set }
    var isDefault: Bool { get set }
    var isDifferent: Bool { get set }
}

class ItemCellViewModel: ItemCellViewModelInterface {

    var item: ItemInterface
    var icon: String
    var title: String
    var number: String?
    var isNumberFieldExist: Bool = true
    var isIconExist: Bool = true
    var isDefault: Bool
    var isDifferent: Bool

    init(item: ItemInterface) {
        self.item = item
        icon = item.icon
        title = item.title

        if let number = item.number {
            self.number = number
        } else {
            isNumberFieldExist = false
        }

        isIconExist = !item.icon.isEmpty
        isDefault = (item as? CryptocoinWallet)?.attributes.isDefault ?? false
        isDifferent = item is FiatWallet
    }
}
