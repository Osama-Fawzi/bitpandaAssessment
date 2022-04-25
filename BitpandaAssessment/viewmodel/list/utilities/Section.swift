//
//  Section.swift
//  BitpandaAssessment
//
//  Created by Osama Fawzi on 24.04.22.
//

import Foundation

class ListSection {
    var type: ItemType
    var items: [ItemCellViewModel]

    init(type: ItemType, items: [ItemCellViewModel]) {
        self.type = type
        self.items = items
    }
}
