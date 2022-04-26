//
//  Bundle+Extensions.swift
//  BitpandaAssessment
//
//  Created by Osama Fawzi on 27.04.22.
//

import Foundation

extension Bundle {
    var fileName: String {
        return object(forInfoDictionaryKey: "filename") as? String ?? ""
    }
}
