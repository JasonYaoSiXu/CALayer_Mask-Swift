//
//  CustomView.swift
//  CALayer_Mask
//
//  Created by yaosixu on 16/6/8.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

@IBDesignable
class CustomView : UIView {
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    @IBInspectable
    var rect : CGRect! {
        didSet {
            self.frame = rect
        }
    }
    
    @IBInspectable
    var backGroudnColor = {
        return UIColor.greenColor()
    }()
    
    @IBInspectable
    var name = {
        return "asd"
    }()
    
    override func didMoveToWindow() {
        print("\(#function)")
        self.layer.contents = UIImage(named: "avatar-1")?.CGImage
        
    }
    
    func changeBackGroundColor() {
        self.backgroundColor = backGroudnColor
    }
    
}
