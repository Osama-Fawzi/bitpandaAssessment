//
//  Commodity.swift
//  BitpandaAssessment
//
//  Created by Osama Fawzi on 24.04.22.
//

import Foundation

class Commodity: Cryptocoin {
    override var type: ItemType {
        return .commodity
    }
}
