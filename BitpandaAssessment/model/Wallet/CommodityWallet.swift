//
//  CommodityWallet.swift
//  BitpandaAssessment
//
//  Created by Osama Fawzi on 24.04.22.
//

import Foundation

class CommodityWallet: CryptocoinWallet {
    override var type: ItemType {
        .commodityWallet
    }
}
