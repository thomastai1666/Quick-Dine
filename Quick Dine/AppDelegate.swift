//
//  AppDelegate.swift
//  Quick Dine
//
//  Created by Thomas Tai on 11/21/19.
//  Copyright © 2019 Thomas Tai. All rights reserved.
//

import UIKit
import Firebase
import Stripe
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print("Application didFinishLaunchingWithOptions called")
        FirebaseApp.configure()
        Stripe.setDefaultPublishableKey("pk_test_qny5F9cVHRGGFh3d2UnKnzBJ00ePJZjoY9")
        let center = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.sound, .alert, .badge]
        center.requestAuthorization(options: options, completionHandler: { (granted, error) in
            if error != nil{
                print(error.debugDescription)
            }
        })
        center.delegate = self
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        //Appears to have be deprecated??
        return false
    }

}

