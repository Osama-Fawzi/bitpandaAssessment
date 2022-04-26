//
//  UIImage+sd_webImage.swift
//  BitpandaAssessment
//
//  Created by Osama Fawzi on 24.04.22.
//

import Foundation
import SDWebImage

protocol ImageViewLoaderInterface {
    func loadImage(with url: URL?, completed: SDExternalCompletionBlock?)
}

extension UIImageView: ImageViewLoaderInterface {
    func loadImage(with url: URL?, completed: SDExternalCompletionBlock?) {
            self.sd_setImage(with: url, completed: completed)
    }
}

