//
//  AppDelegate.swift
//  AppLaunchADExample
//
//  Created by 童星 on 2016/11/2.
//  Copyright © 2016年 童星. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        
        let vc = ViewController()
        let nvc = UINavigationController.init(rootViewController: vc)
        window?.rootViewController = nvc
        
        let picUrl = "http://ww3.sinaimg.cn/mw690/937882b5gw1f9alr6oysjj20hs0qowg0.jpg"
        let userDefaultKey = "launchImageKey"
        
        if UserDefaults.standard.string(forKey: userDefaultKey) == "1" {
            let startView: LaunchImageView = LaunchImageView.startAdsWith(imageUrl: picUrl, clickImageAction: {[weak self] in
                let vc = LoadAdsWebViewViewController()
                vc.title = "广告加载页面"
                (self?.window?.rootViewController as! UINavigationController).pushViewController(vc, animated: true)
            }) as! LaunchImageView
            
            startView.startAnimationTime(time: 5, completionBlock: { (adsView: LaunchImageView) in
                print("广告执行结束")
            })
            
        }else{
        
            LaunchImageView.downLoadAdsImage(imageUrl: picUrl)
            UserDefaults.standard.set("1", forKey: userDefaultKey)
            _ = UserDefaults.standard.synchronize()
        }
        
        
        
        
        
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

