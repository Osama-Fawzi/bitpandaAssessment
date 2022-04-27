//
//  FiatWallet.swift
//  BitpandaAssessment
//
//  Created by Osama Fawzi on 24.04.22.
//

import Foundation

class FiatWallet: Codable {
    let id: String
    let attributes: Attributes
    var type: ItemType {
        .fiatWallet
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        attributes = try container.decode(Attributes.self, forKey: .attributes)
    }

    class Attributes: Codable {
        var fiatID, name, symbol: String
        var logo, logoDark: String?
        var balance: String

        var icon: String? {
            return Helper.shared.isDarkModeEnabled ? logoDark : logo
        }

        enum CodingKeys: String, CodingKey {
            case name, balance
            case fiatID = "fiat_id"
            case symbol = "fiat_symbol"
        }
    }
}

extension FiatWallet: ItemInterface {
    var icon: String {
        return attributes.icon ?? ""
    }

    var title: String {
        return "\(attributes.name)(\(attributes.symbol))"
    }

    var numberValue: Double {
        return Double(attributes.balance) ?? 0.0
    }

    var number: String? {
        return attributes.balance
    }
}

extension FiatWallet: Equatable {
    static func == (lhs: FiatWallet, rhs: FiatWallet) -> Bool {
        lhs.id == rhs.id && lhs.attributes.balance == rhs.attributes.balance
    }
}

extension FiatWallet: Comparable {
    static func < (lhs: FiatWallet, rhs: FiatWallet) -> Bool {
        lhs.attributes.balance < rhs.attributes.balance
    }
}
