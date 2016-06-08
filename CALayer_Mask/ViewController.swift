//
//  ViewController.swift
//  CALayer_Mask
//
//  Created by yaosixu on 16/6/8.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

//延时
func delay(seconds: Double, complition: () -> ()) {
    let timer = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(NSEC_PER_SEC) * seconds))
    dispatch_after(timer, dispatch_get_main_queue(), {
        complition()
    })
}


class ViewController: UIViewController {

    @IBOutlet weak var AvtarImageView: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var cVuew: CustomView!
    @IBOutlet weak var changButton: UIButton!
    
    let maskView = CAShapeLayer()
    let circleMask = CAShapeLayer()
    let infoMaskView = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor ( red: 0.8353, green: 0.7608, blue: 0.6549, alpha: 1.0 )
        let rect = CGRect(x: 0, y: 0, width: AvtarImageView.bounds.width, height: AvtarImageView.bounds.height)
        maskView.path = UIBezierPath(ovalInRect: rect).CGPath
        changButton.hidden = true
        infoLabel.textColor = UIColor.whiteColor()
        infoLabel.backgroundColor = UIColor.clearColor()
        infoLabel.text = "123456"
        
        circleMask.path = maskView.path
        circleMask.fillColor = UIColor.clearColor().CGColor
        circleMask.strokeColor = UIColor.whiteColor().CGColor
        circleMask.lineWidth = 6.0
        
        AvtarImageView.layer.mask = maskView
        AvtarImageView.layer.insertSublayer(circleMask, below: maskView)
        
        print("cVuew.name = \(cVuew.name)")
        
        delay(2, complition: { [unowned self] _ in
            self.customViewPro()
        })
        
        delay(6, complition: { [unowned self] _ in
            self.animation()
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let infoBackLabel = UILabel()
        infoBackLabel.frame = infoLabel.frame
        infoBackLabel.textColor = UIColor.greenColor()
        infoBackLabel.backgroundColor = UIColor.clearColor()
        infoBackLabel.text = infoLabel.text
        infoBackLabel.textAlignment = .Center
        infoBackLabel.layer.mask = infoMaskView
        view.addSubview(infoBackLabel)
        delay(6, complition: { [unowned self] _ in
            self.labelMask()
        })
    }
    
    @IBAction func TapChangeButton(sender: UIButton) {
        changButton.hidden = true
        UIApplication.sharedApplication().keyWindow!.rootViewController = storyboard!.instantiateViewControllerWithIdentifier("ViewController") as UIViewController
    }
    
    
    //给蒙板和边框添加动画
    func animation() {
        let bascAni = CABasicAnimation(keyPath: "transform.scale")
        bascAni.fromValue = 1.0
        bascAni.toValue = 0.8
        bascAni.duration = 4.0
        bascAni.repeatCount = 4
        bascAni.autoreverses = true
        bascAni.delegate = self
        maskView.addAnimation(bascAni, forKey: nil)
        circleMask.addAnimation(bascAni, forKey: nil)
    }
    
    //注水效果
    func labelMask() {
        infoMaskView.path = UIBezierPath(ovalInRect: infoLabel.bounds).CGPath
        let maskView = CABasicAnimation(keyPath: "position.x")
        maskView.fromValue =  -infoLabel.layer.position.x
        maskView.toValue = infoLabel.layer.position.x
        maskView.duration = 7
        infoMaskView.addAnimation(maskView, forKey: nil)
    }
    
    //给自定义视图添加圆角，阴影效果
    func customViewPro() {
        print("\(#function)")
        cVuew.backGroudnColor = UIColor.blueColor()
        cVuew.changeBackGroundColor()
        cVuew.rect = CGRect(x: 100, y: 150, width: 100, height: 100)
        cVuew.name = "customView"
        
        cVuew.layer.cornerRadius = cVuew.rect.width / 2
        cVuew.layer.masksToBounds = true
        
        //利用图层让一个视图的圆角和阴影同时存在
        let shadow = CALayer()
        shadow.frame = cVuew.frame
        shadow.shadowPath = UIBezierPath(ovalInRect: cVuew.bounds).CGPath
        shadow.shadowOffset = CGSize(width: -4, height: 2)
        shadow.shadowColor = UIColor.orangeColor().CGColor
        shadow.shadowOpacity = 0.8
        view.layer.insertSublayer(shadow, below: cVuew.layer)
        
        
    }
    
    override func animationDidStart(anim: CAAnimation) {
        
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        print("\(#function)")
        changButton.hidden = false
    }

}

