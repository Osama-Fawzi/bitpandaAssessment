//
//  UIBarButtonITem+Position.swift
//  BitpandaAssessment
//
//  Created by Osama Fawzi on 26.04.22.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    private static var positionTypeKey: UInt = 0

    var position: Position {
        get {
            return objc_getAssociatedObject(self, &UIBarButtonItem.positionTypeKey) as! Position
        }
        set {
            objc_setAssociatedObject(self, &UIBarButtonItem.positionTypeKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}

extension UIBarButtonItem {
    convenience init(image: UIImage?, target: Any?, action: Selector?, position: Position) {
        self.init(image: image, style: .plain, target: target, action: action)
        self.position = position
   }

    convenience init(title: String?, target: Any?, action: Selector?, position: Position) {
        self.init(title: title, style: .plain, target: target, action: action)
        self.position = position
   }
}
