//
//  Coordinator.swift
//  BitpandaAssessment
//
//  Created by Osama Fawzi on 23.04.22.
//

import Foundation
import UIKit

class Coordinator {
    static let shared = Coordinator()

    public var lastParentVC: UIViewController?

    func start() {
        let skipTo = ProcessInfo.processInfo.environment["SKIP_SPLASH_TO"]
        if skipTo == "Asset" {
            showAsset()
        } else if skipTo == "Wallet" {
            showAsset()
            showWallet()
        } else {
            showIntro()
        }
    }
    
    func showIntro() {
        let vc = SplashViewController()
        setRootViewController(vc)
    }

    func showAsset(isRoot: Bool = true) {
        let dp = DataProvider()
        let vm = AssetViewModel(dataProvider: dp)
        let vc = ListViewController(viewModel: vm)

        if isRoot {
            setRootViewController(vc, animated: true)
        } else {
            show(vc, into: topViewController()!)
        }
    }

    func showWallet(isRoot: Bool = false) {
        let dp = DataProvider()
        let vm = WalletViewModel(dataProvider: dp)
        let vc = ListViewController(viewModel: vm)

        if isRoot {
            setRootViewController(vc, animated: true)
        } else {
            show(vc, into: topViewController()!)
        }
    }
    
    func pop(_ viewController: UIViewController) {
        DispatchQueue.main.async {
            viewController.navigationController?.popViewController(animated: true)
        }
    }
    
    func push(_ viewController: UIViewController, into parentVC: UIViewController) {
        DispatchQueue.main.async {
            parentVC.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func show(_ viewController: UIViewController, into parentVC: UIViewController) {
        self.lastParentVC = parentVC
        _show(viewController, into: parentVC)
    }

    private func _show(_ viewController: UIViewController, into parentVC: UIViewController) {
        DispatchQueue.main.async {
            parentVC.present(viewController, animated: true, completion: nil)
        }
    }

    func dismiss() {
        DispatchQueue.main.async { [weak self] in
            self?.topViewController()?.dismiss(animated: true, completion: nil)
        }
    }

    func dismiss(_ viewController: UIViewController) {
        DispatchQueue.main.async {
            viewController.dismiss(animated: true, completion: nil)
        }
    }
    
    func getRootViewController() -> UIViewController? {
        if let window = UIApplication.shared.delegate?.window {
            if let root = window?.rootViewController {
                return root
            }
        }
        return nil
    }
    
    func setRootViewController(_ rootViewController: UIViewController, animated: Bool = false, duration: TimeInterval = 1.0, options: UIView.AnimationOptions = .transitionCrossDissolve) {
            if let window = UIApplication.shared.delegate?.window {
                window?.rootViewController = rootViewController
                if animated {
                    UIView.transition(with: window!, duration: duration, options: options, animations: {}, completion: nil)
                }
            }
        
    }
    
    func topViewController(base: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
