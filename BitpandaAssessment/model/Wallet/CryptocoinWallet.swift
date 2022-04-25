//
//  CryptocoinWallet.swift
//  BitpandaAssessment
//
//  Created by Osama Fawzi on 24.04.22.
//

import Foundation

class CryptocoinWallet: Codable {
    let id: String
    let attributes: Attributes
    var type: ItemType {
        .cryptocoinWallet
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey:.id)
        attributes = try container.decode(Attributes.self, forKey:.attributes)
    }

    class Attributes: Codable {
        var cryptocoinID, name, symbol: String
        var logo, logoDark: String?
        var balance: String
        let isDeleted, isDefault: Bool

        var icon: String? {
            return Helper.shared.isDarkModeEnabled ? logoDark : logo
        }

        enum CodingKeys: String, CodingKey {
            case name, balance
            case cryptocoinID = "cryptocoin_id"
            case symbol = "cryptocoin_symbol"
            case isDeleted = "deleted"
            case isDefault = "is_default"
        }

        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            cryptocoinID = try container.decode(String.self, forKey:.cryptocoinID)
            name = try container.decode(String.self, forKey:.name)
            balance = try container.decode(String.self, forKey:.balance)
            symbol = try container.decode(String.self, forKey:.symbol)
            isDeleted = try container.decode(Bool.self, forKey:.isDeleted)
            isDefault = try container.decode(Bool.self, forKey:.isDefault)
        }
    }
}

extension CryptocoinWallet: ItemInterface {
    var icon: String {
        return attributes.icon ?? ""
    }

    var title: String {
        return "\(attributes.name)(\(attributes.symbol))"
    }

    var number: String? {
        return attributes.balance
    }
}

extension CryptocoinWallet: Equatable {
    static func == (lhs: CryptocoinWallet, rhs: CryptocoinWallet) -> Bool {
        lhs.id == rhs.id && lhs.attributes.balance == rhs.attributes.balance
    }
}

extension CryptocoinWallet: Comparable {
    static func < (lhs: CryptocoinWallet, rhs: CryptocoinWallet) -> Bool {
        lhs.attributes.balance < rhs.attributes.balance
    }
}
