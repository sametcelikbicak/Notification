//
//  AppDelegate.swift
//  Notification
//
//  Created by Samet ÇELİKBIÇAK on 24.03.2018.
//  Copyright © 2018 Samet ÇELİKBIÇAK. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            if error != nil {
                application.registerForRemoteNotifications()
            }
        }
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        if UIApplication.shared.applicationIconBadgeNumber > -1 {
            UIApplication.shared.applicationIconBadgeNumber = -1
            UserDefaults.standard.set(0, forKey: "bildirimSayisi")
        }
    }

}

