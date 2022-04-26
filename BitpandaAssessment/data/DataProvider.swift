//
//  DataProvider.swift
//  BitpandaAssessment
//
//  Created by Osama Fawzi on 23.04.22.
//

import Foundation

protocol DataProviderInterface {
    func getCollections() throws -> Collections
    func getAssetGroup() throws -> AssetsGroup
    func getWalletGroup() throws -> WalletsGroup

}

class DataProvider {
    private let fileName = "Mastrerdata"
}

extension DataProvider: DataProviderInterface {
    enum DecodingError {
        case fileNotFound
        case codingKeys
        case missingAssets
        case missingWallets
    }

    func getCollections() throws -> Collections {
        do {
            if let jsonURL = Bundle.main.url(forResource: fileName, withExtension: "json"),
               let jsonData = try? Data(contentsOf: jsonURL) {
                let service = try JSONDecoder().decode(Response.self, from: jsonData)
                return service.data.attributes
            }
        } catch let error {
            throw Error(with: DecodingError.codingKeys, underlyingError: error)
        }

        throw Error(with: DecodingError.fileNotFound, underlyingError: nil)
    }

    func getAssetGroup() throws ->  AssetsGroup {
        do {
            return try getCollections().assetGroup
        } catch let error {
            throw Error(with: DecodingError.missingAssets, underlyingError: error)
        }
    }

    func getWalletGroup() throws ->  WalletsGroup {
        do {
            return try getCollections().walletGroup
        } catch let error {
            throw Error(with: DecodingError.missingWallets, underlyingError: error)
        }
    }
}

extension DataProvider.DecodingError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .codingKeys:
            return "item couldn't be decoded due to missing codingkey(s)"

        case .missingAssets:
            return "Assets are missed"

        case .missingWallets:
            return "Wallets are missed"

        case .fileNotFound:
            return "Could not find file at given path"
        }
    }
}
