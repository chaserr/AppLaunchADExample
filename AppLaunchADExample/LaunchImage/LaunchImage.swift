//
//  LaunchImage.swift
//  AppLaunchADExample
//
//  Created by 童星 on 2016/11/2.
//  Copyright © 2016年 童星. All rights reserved.
//

import UIKit

class LaunchImage: NSObject {

    class public func getSystemLaunchImage() -> UIImage {
       
        let viewSize = UIScreen.main.bounds.size
        let viewOrientation: String?
        if UIApplication.shared.statusBarOrientation == UIInterfaceOrientation.portraitUpsideDown || UIApplication.shared.statusBarOrientation == UIInterfaceOrientation.portrait {
        
            viewOrientation = "Portrait"
            
        }else{
        
            viewOrientation = "Landscape"
        }
        
        var launchImage: String?
        let imageDict: [[AnyHashable: Any]] = Bundle.main.infoDictionary?["UILaunchImages"] as! [[AnyHashable : Any]]
        
        for dict: [AnyHashable: Any] in imageDict {
            let imageSize = CGSizeFromString(dict["UILaunchImageSize"] as! String)
            
            if __CGSizeEqualToSize(imageSize, viewSize) && viewOrientation == (dict["UILaunchImageOrientation"] as! String){
                
                launchImage = dict["UILaunchImageName"] as! String?
            }
        }
        
        return UIImage(named: launchImage!)!
        
    }
}
