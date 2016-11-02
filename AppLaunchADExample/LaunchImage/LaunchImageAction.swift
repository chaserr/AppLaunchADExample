//
//  LaunchImageAction.swift
//  AppLaunchADExample
//
//  Created by 童星 on 2016/11/2.
//  Copyright © 2016年 童星. All rights reserved.
//

import UIKit

class LaunchImageAction: UIImageView {

    var target: AnyObject?
    var action: Selector?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTarget(target: AnyObject, action: Selector) {
        
        self.target = target
        self.action = action
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if (self.target?.responds(to: self.action))! {
            target?.perform(self.action!, with: self, afterDelay: 0.0)
        }
    }
    
    
}
