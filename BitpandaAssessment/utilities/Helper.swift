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
                return isAscending ? lhs.numberValue < rhs.numberValue : lhs.numberValue > rhs.numberValue
        }
    }
}
