//
//  AppDelegate.swift
//  Github
//
//  Created by Ramy Ayman Sabry on 12/25/19.
//  Copyright © 2019 Ramy Ayman Sabry. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Kingfisher
import KeychainSwift
import BackgroundTasks
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate{

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = SplashRouter.createModule()
        config()
        attempRegisterForNotifications(application: application)
        
        return true
    }
    

    
    func config()
    {
        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplication.backgroundFetchIntervalMinimum)
        KingfisherManager.shared.cache.diskStorage.config.expiration = .seconds(60 * 60 * 24 * 7)
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = true
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysHide
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
//         let keyChain = KeychainSwift()
//       SharedKeychain.start(withKeychain: keyChain, accessGroup: LocalizableWords.privateMesseges.keyChainGroup)
    }
    
    
    
    
    
    
    
  // MARK:- Notifications
   //
  private func attempRegisterForNotifications(application: UIApplication)
  {
    UNUserNotificationCenter.current().delegate = self
      
      // User notification authorization
      let options: UNAuthorizationOptions = [.alert, .badge, .sound]
      UNUserNotificationCenter.current().requestAuthorization(options: options) { (granted, err) in
          if let error = err {
            print("Failed to request authorization",error)
              return
          }
        
          if granted {
              print("Notifications auth granted!!")
          }
          else {
              print("Notifications auth denied!!")
          }
      }
      
      application.registerForRemoteNotifications()
  }
   
   func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
   {

       completionHandler([.alert,.sound])
   }
    
    
    
    
    
    
    
    
    // MARK:- Background Fetch
    //
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)
    {
        if let repoListViewController = UIApplication.topViewController() as? RepoListViewController {
            repoListViewController.presenter?.refreshData(showLocalNotification: true)
        }
    }
    
    
    
    
    
    
    
    // MARK:- APP LIfe Cycle
    //
    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
       
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
       
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }


}

