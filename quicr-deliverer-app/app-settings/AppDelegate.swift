//
//  AppDelegate.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 23/10/2020.
//

import UIKit
import Firebase
import Stripe
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupNavbar()
        FirebaseApp.configure()
        Stripe.setDefaultPublishableKey("pk_test_96kmOXhYEiFVcMa0KRiJAxE0")
        IQKeyboardManager.shared.enable = true
        // push notifications
        if let userId = Auth.auth().currentUser?.uid {
            PushNotificationManager(userId: userId).registerForPushNotifications()
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        if let _ = Auth.auth().currentUser  {
            window?.rootViewController = UINavigationController(rootViewController: HomeViewController())
        }
        else {
            window?.rootViewController = LoginViewController()
        }
        return true
    }
}


extension AppDelegate {
    private func setupNavbar() {
        // Nav-Bar
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = AppTheme.primaryColor
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor :
            AppTheme.primaryColor, NSAttributedString.Key.font : UIFont(name: FontName.SemiBold, size: 16)!]
    }
}
