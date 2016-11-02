//
//  LaunchImageView.swift
//  AppLaunchADExample
//
//  Created by 童星 on 2016/11/2.
//  Copyright © 2016年 童星. All rights reserved.
//

import UIKit
import Kingfisher
let LaunchImagePath: String = "launchImagePath"

class LaunchImageView: UIView {

   fileprivate var imageViewDefault: UIImageView!
   fileprivate var bgImageView: LaunchImageAction!
   fileprivate var timeButton: UIButton!
   fileprivate var isImageDownLoad: Bool?
   fileprivate var timer: Timer?
   fileprivate var timeNum: Int!
    
    
    var imageClickAction: () -> () = {
    
        Void in
    }
    
    var adsViewCompletion: (LaunchImageView) -> Void = {
    
        (launchImageView: LaunchImageView) in
    }
    
    init(imageUrl: String, clickImageAction: @escaping () -> ()) {
        super.init(frame: UIScreen.main.bounds)
        isImageDownLoad = false
        imageClickAction = clickImageAction
        imageViewDefault = UIImageView(frame: UIScreen.main.bounds)
        imageViewDefault.contentMode = UIViewContentMode.scaleToFill
        imageViewDefault.image = LaunchImage.getSystemLaunchImage()
        addSubview(imageViewDefault)
        bgImageView = LaunchImageAction.init(frame: UIScreen.main.bounds)
        bgImageView.alpha = 0.0
        bgImageView.contentMode = UIViewContentMode.scaleToFill
        bgImageView.addTarget(target: self, action: #selector(imageClick(sender:)))
        addSubview(bgImageView)
        
        timeButton = UIButton.init(frame: CGRect.init(x: UIScreen.main.bounds.size.width - 13 - 52, y: 20, width: 52, height: 25))
        timeButton.layer.cornerRadius = 25 / 2.0
        timeButton.clipsToBounds = true
        timeButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        timeButton.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
        timeButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        timeButton.addTarget(self, action: #selector(loadAds(sender:)), for: UIControlEvents.touchUpInside)
        bgImageView.addSubview(timeButton)
        
        // 缓存图片
        let imageCacheMgr = ImageCache.init(name: LaunchImagePath, path: nil)
        let cacheResult = imageCacheMgr.isImageCached(forKey: imageUrl)
        if cacheResult.cached {
            timeButton.isHidden = false
            bgImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: imageUrl)!), placeholder: LaunchImage.getSystemLaunchImage(), options: [.transition(ImageTransition.fade(1))], progressBlock: nil, completionHandler: nil)
            isImageDownLoad = true
            
        }else{
            timeButton.isHidden = true
            bgImageView.image = LaunchImage.getSystemLaunchImage()
            KingfisherManager.shared.retrieveImage(with: ImageResource.init(downloadURL: URL.init(string: imageUrl)!, cacheKey: LaunchImagePath), options: [.targetCache(ImageCache.init(name: LaunchImagePath))], progressBlock: nil, completionHandler: nil)
            isImageDownLoad = false
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func removeAdsView() {
     
        if (timer?.isValid)! {
            timer?.invalidate()
        }
        
        timer = nil
        UIView.animate(withDuration: 0.7, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { [weak self] in
            self?.bgImageView.alpha = 0.0
            self?.bgImageView.frame = CGRect.init(x: UIScreen.main.bounds.size.width / 20, y: -(UIScreen.main.bounds.size.height / 20), width: 1.1 * (UIScreen.main.bounds.size.width), height: 1.1 * (UIScreen.main.bounds.size.height))
            self?.alpha = 0.0
        }) { (finish : Bool) in
            
            self.removeFromSuperview()
            self.adsViewCompletion(self)
        }
        
    }
    
    // MARK: public method
    
    public class func startAdsWith(imageUrl: String, clickImageAction: @escaping () -> ()) -> Any {
        return LaunchImageView.init(imageUrl: imageUrl, clickImageAction: clickImageAction)
    }
    
    func startAnimationTime(time: Int, completionBlock: @escaping (LaunchImageView) -> Void) {
        timeNum = time
        adsViewCompletion = completionBlock
        UIApplication.shared.keyWindow?.addSubview(self)
        UIApplication.shared.keyWindow?.bringSubview(toFront: self)
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.bgImageView.alpha = 1
        }
        
        timeButton.setTitle("跳过\(timeNum!)", for: UIControlState.normal)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction(timer:)), userInfo: nil, repeats: true)
    }
    
    public class func downLoadAdsImage(imageUrl: String) {
        
        let imageCacheMgr = ImageCache.init(name: LaunchImagePath, path: nil)
        let cacheResult = imageCacheMgr.isImageCached(forKey: imageUrl)
        if cacheResult.cached {
    
        }else{
        
            KingfisherManager.shared.retrieveImage(with: ImageResource.init(downloadURL: URL.init(string: imageUrl)!, cacheKey: imageUrl), options: [.targetCache(ImageCache.init(name: LaunchImagePath))], progressBlock: nil, completionHandler: nil)
        }
        
    }
    

    
    
    // MARK: -- action
    
    func imageClick(sender: UIView) {
        if isImageDownLoad! {
            self.imageClickAction()
            self.removeFromSuperview()
        }
    }
    
    func loadAds(sender: Any) {
        removeAdsView()
    }
    
    func timerAction(timer: Timer) {
        if timeNum == 0 {
            removeAdsView()
            return
        }
        
        timeNum = timeNum - 1
        if isImageDownLoad! {
            timeButton.setTitle("跳过\(timeNum!)", for: UIControlState.normal)
        }
    }
    
    
    
    
    
    
}
