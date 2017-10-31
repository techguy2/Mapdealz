//
//  AppDelegate.swift
//  VideoApp
//
//  Created by Soeb on 1/27/17.
//  Copyright © 2017 Soeb. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Create Window Programmatically by assigning Screen Size
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        //Intiate root view controller to use with Window
        
        let mainController = HomeController.init(collectionViewLayout: UICollectionViewFlowLayout())
        
        let navigationController = UINavigationController(rootViewController: mainController)
        
        // Assign root View Controller
        window?.rootViewController = navigationController
        
        // Assign NavigationBar Background Color
        navigationController.navigationBar.barTintColor = UIColor.red
        navigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white,NSFontAttributeName: UIFont.systemFont(ofSize: 22)]
        
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.shadowImage = UIImage()
        let statusBarStyle: UIView = UIView()
        
        statusBarStyle.backgroundColor = UIColor.init(red: 200/255, green: 32/255, blue: 31/255, alpha: 1)
        
        window?.addSubview(statusBarStyle)
        window?.addConstraintFormat(format: "H:|[v0]|", views: statusBarStyle)
        window?.addConstraintFormat(format: "V:|[v0(20)]|", views: statusBarStyle)
        
        
        return true
    }
    
 

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

