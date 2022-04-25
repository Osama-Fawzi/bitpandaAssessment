//
//  Cryptocoin.swift
//  BitpandaAssessment
//
//  Created by Osama Fawzi on 24.04.22.
//

import Foundation
class Cryptocoin: Codable {
    let id: String
    let attributes: Attributes
    var type: ItemType {
        return .cryptocoin
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey:.id)
        attributes = try container.decode(Attributes.self, forKey:.attributes)
    }

    class Attributes: Codable {
        var name, symbol: String
        let logo, logoDark: String
        var price, avgPrice: String
        var precisionForFiatPrice: Int

        var icon: String {
            return Helper.shared.isDarkModeEnabled ? logoDark : logo
        }

        enum CodingKeys: String, CodingKey {
            case name, symbol, logo
            case avgPrice = "avg_price"
            case logoDark = "logo_dark"
            case precisionForFiatPrice = "precision_for_fiat_price"
        }

        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            name = try container.decode(String.self, forKey:.name)
            logo = try container.decode(String.self, forKey:.logo)
            logoDark = try container.decode(String.self, forKey:.logoDark)
            symbol = try container.decode(String.self, forKey:.symbol)
            avgPrice = try container.decode(String.self, forKey:.avgPrice)
            precisionForFiatPrice = try container.decode(Int.self, forKey:.precisionForFiatPrice)
            price = avgPrice.toCurrancy(precision: precisionForFiatPrice)
        }
    }
}

extension Cryptocoin: ItemInterface {
    var icon: String {
        return attributes.icon
    }

    var title: String {
        return "\(attributes.name)(\(attributes.symbol))"
    }

    var number: String? {
        return attributes.price
    }
}
