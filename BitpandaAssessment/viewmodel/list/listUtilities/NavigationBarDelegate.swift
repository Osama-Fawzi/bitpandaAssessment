//
//  NavigationBarDelegate.swift
//  BitpandaAssessment
//
//  Created by Osama Fawzi on 23.04.22.
//

import Foundation
import UIKit

class NavigationBarDelegate: NSObject {
    
    private var barPosition: UIBarPosition
    
    init(barPosition: UIBarPosition = .topAttached) {
        self.barPosition = barPosition
    }
}

extension NavigationBarDelegate: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        barPosition
    }
}
