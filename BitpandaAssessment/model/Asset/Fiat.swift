//
//  Fiat.swift
//  BitpandaAssessment
//
//  Created by Osama Fawzi on 24.04.22.
//

import Foundation


class Fiat: Codable {
    let id: String
    let attributes: Attributes
    var type: ItemType {
        return .fiat
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey:.id)
        attributes = try container.decode(Attributes.self, forKey:.attributes)
    }

    class Attributes: Codable {
        var name, symbol: String
        let logo, logoDark: String
        let hasWallets: Bool

        var icon: String {
            return Helper.shared.isDarkModeEnabled ? logoDark : logo
        }

        enum CodingKeys: String, CodingKey {
            case name, symbol, logo
            case logoDark = "logo_dark"
            case hasWallets = "has_wallets"
        }
    }
}

extension Fiat: ItemInterface {
    var icon: String {
        return attributes.icon
    }

    var title: String {
        return "\(attributes.name)(\(attributes.symbol))"
    }

    var numberValue: Double {
        return 0.0
    }

    var number: String? {
        return nil
    }
}
