//
//  SplashViewController.swift
//  BitpandaAssessment
//
//  Created by Osama Fawzi on 23.04.22.
//

import UIKit


class SplashViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!

    private var blinkedCount = 0
    private let maxBlinkingcount = 2
    private let blinkingDuration = 0.75
    
    private var charIndex = 0
    private let writingduration = 0.25
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Coordinator.shared.showAsset()

//        writeInChars("bitpanda")
    }
    
    private func writeInChars(_ text: String) {
        let animations = { [unowned self] in
            let nextChar = Array(text)[charIndex]
            label.text! += "\(nextChar)"
        }
        let onComplete: ((Bool) -> Void) = { [unowned self] _ in
            charIndex += 1
            if charIndex < text.count {
                writeInChars(text)
            } else {
                startLogoAnimation()
            }
        }
        UIView.transition(with: label,
                          duration: writingduration,
                          options: .transitionFlipFromTop,
                          animations: animations,
                          completion: onComplete)
    }
    
    private func startLogoAnimation() {
        let animations = { [unowned self] in
            let desiredAlpha: CGFloat = (label.alpha == 0) ? 1 : 0
            label.alpha = desiredAlpha
        }
        let onComplete: ((Bool) -> Void) = { [unowned self]_ in
            blinkedCount += 1
            if blinkedCount < (maxBlinkingcount*2) {
                startLogoAnimation()
            } else {
                Coordinator.shared.showAsset()
            }
        }
        UIView.animate(withDuration: blinkingDuration,
                       delay: 0,
                       options: .curveLinear,
                       animations: animations,
                       completion: onComplete)
    }
}
