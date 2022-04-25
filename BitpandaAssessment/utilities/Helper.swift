//
//  Helper.swift
//  BitpandaAssessment
//
//  Created by Osama Fawzi on 23.04.22.
//

import Foundation
import UIKit

struct Helper {
    static let shared = Self()

    var isDarkModeEnabled: Bool {
        if let window = UIApplication.shared.delegate?.window {
            let isDark = window?.traitCollection.userInterfaceStyle == .dark
            return isDark
        }
        return false
    }

    func sort<T: ItemInterface>(collection:[T], isAscending: Bool = false) -> [T] {
       return collection.sorted { lhs, rhs in
            if let balance1 = Double(lhs.number ?? ""),
               let balance2 = Double(rhs.number ?? "") {
                return isAscending ? balance1 < balance2 : balance1 > balance2
            }

            return false
        }
    }
}
