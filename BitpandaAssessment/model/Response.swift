//
//  Response.swift
//  BitpandaAssessment
//
//  Created by Osama Fawzi on 23.04.22.
//

import Foundation
import UIKit

protocol ItemInterface {
    var type: ItemType { get }
    var icon: String { get }
    var title: String { get }
    var numberValue: Double { get }
    var number: String? { get }
}

enum ItemType: String, Codable, CaseIterable {
    case cryptocoin
    case commodity
    case fiat
    case cryptocoinWallet = "cryptocoin wallet"
    case commodityWallet = "commodity wallet"
    case fiatWallet = "fiat wallet"
}

typealias Collections = Response.Data.Attributes

struct Response: Codable {

    let data:Data

    struct Data: Codable {

        let attributes: Data.Attributes

        struct Attributes: Codable {
            var assetGroup = AssetsGroup()
            var walletGroup = WalletsGroup()

            enum CodingKeys: String, CodingKey {
                case cryptocoins, commodities, fiats
                case wallets, commodity_wallets, fiatwallets
            }

            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                assetGroup.cryptocoins = try container.decode([Cryptocoin].self, forKey:.cryptocoins)
                assetGroup.commodities = try container.decode([Commodity].self, forKey:.commodities)
                assetGroup.fiats = try container.decode([Fiat].self, forKey:.fiats)

                walletGroup.cryptocoinWallets = try container.decode([CryptocoinWallet].self, forKey:.wallets)
                walletGroup.commodityWallets = try container.decode([CommodityWallet].self, forKey:.commodity_wallets)
                walletGroup.fiatWallets = try container.decode([FiatWallet].self, forKey:.fiatwallets)
            }

            func encode(to encoder: Encoder) throws {
                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(assetGroup.cryptocoins, forKey: .cryptocoins)
                try container.encode(assetGroup.commodities, forKey: .commodities)
                try container.encode(assetGroup.fiats, forKey: .fiats)

                try container.encode(walletGroup.cryptocoinWallets, forKey: .wallets)
                try container.encode(walletGroup.commodityWallets, forKey: .commodity_wallets)
                try container.encode(walletGroup.fiatWallets, forKey: .fiatwallets)

            }
        }
    }
}


class AssetsGroup: Codable {
    var cryptocoins = [Cryptocoin]()
    var commodities = [Commodity]()
    var fiats = [Fiat]()
}

class WalletsGroup: Codable {
    var cryptocoinWallets = [CryptocoinWallet]()
    var commodityWallets = [CommodityWallet]()
    var fiatWallets = [FiatWallet]()
}
