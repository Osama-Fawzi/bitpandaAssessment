//
//  AppDelegate.swift
//  BitpandaAssessment
//
//  Created by Osama Fawzi on 23.04.22.
//

import UIKit
import SDWebImage
import SDWebImageSVGCoder

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // setRoot ViewController
        self.window = UIWindow(frame: UIScreen.main.bounds)
        Coordinator.shared.start()
        self.window?.makeKeyAndVisible()

        // plugin to support svg
        let SVGCoder = SDImageSVGCoder.shared
        SDImageCodersManager.shared.addCoder(SVGCoder)

        return true
    }

}
