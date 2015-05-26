//
//  FBSlideMenuVC.swift
//  Park
//
//  Created by bluesky on 15/5/25.
//  Copyright (c) 2015年 bluesky. All rights reserved.
//

import UIKit

let FBSlideMenuPan2OpenOffset:CGFloat = 60
let FBSlideMenuOffset:CGFloat = 200

enum FBSlideMenuSate {
    case SlideMenuStateOpen
    case SlideMenuStateClosed
}

var speed:CGFloat = 0.5
var scale:CGFloat = 0

class FBSlideMenuVC: UIViewController {
    
    //------------------variables
    //点击隐藏侧滑菜单
    var mainViewTapGestureRecognizer : UITapGestureRecognizer!
    
    //拖拽手势
    var mainViewPanGestureRecognizer : UIPanGestureRecognizer!
    //拖拽点位置
    var panGestureStartLocation : CGPoint!
    
    var leftSlideMenuVC : UIViewController?
    var mainVC : UIViewController?
    var rightSlideMenuVC : UIViewController?
    
    
    var slideMenuOpenState : FBSlideMenuSate!
    //----------------------
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.slideMenuOpenState  = FBSlideMenuSate.SlideMenuStateClosed
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(leftVC:UIViewController,mainVC:UIViewController,rightVC:UIViewController) {
        super.init()
        
        self.leftSlideMenuVC = leftVC
        self.mainVC = mainVC
        self.rightSlideMenuVC = rightVC
        
        self.leftSlideMenuVC?.view.hidden = true
        self.rightSlideMenuVC?.view.hidden = true
        
        
        if self.leftSlideMenuVC != nil {
            if self.leftSlideMenuVC?.view.superview == nil {
                self.addChildViewController(self.leftSlideMenuVC!)
                self.view.addSubview(self.leftSlideMenuVC!.view)
            }
        }
        
        if self.rightSlideMenuVC != nil {
            if self.rightSlideMenuVC?.view.superview == nil {
                self.addChildViewController(rightSlideMenuVC!)
                self.view.addSubview(self.rightSlideMenuVC!.view)
            }
        }
        
        if self.mainVC != nil {
            if self.mainVC?.view.superview == nil {
                self.addChildViewController(self.mainVC!)
                self.view.addSubview(self.mainVC!.view)
            }
        }
        
        
        
        self.mainViewPanGestureRecognizer = UIPanGestureRecognizer()
        self.mainViewPanGestureRecognizer.addTarget(self, action: "mainViewPan:")
        self.mainVC?.view.addGestureRecognizer(self.mainViewPanGestureRecognizer)
        
        
    }
    
    
    func mainViewPan(panGestureRecognizer:UIPanGestureRecognizer) {
        //拖拽状态
        var panState = panGestureRecognizer.state
        var location = panGestureRecognizer.locationInView(self.view)
        
        
        scale = panGestureRecognizer.translationInView(self.view).x * speed + scale
        
        switch (panState) {
        case UIGestureRecognizerState.Began:
            self.panGestureStartLocation = location
            
        case UIGestureRecognizerState.Changed:
            var frame = self.mainVC!.view.frame
            //if (panGestureRecognizer.translationInView(self.mainVC!.view).x > 0) {
            if panGestureRecognizer.view!.frame.origin.x >= 0 {
                //if self.slideMenuOpenState == FBSlideMenuSate.SlideMenuStateClosed {   //右滑
                //frame.origin.x = location.x - self.panGestureStartLocation.x
                panGestureRecognizer.view!.center = CGPointMake((panGestureRecognizer.view!.center.x + panGestureRecognizer.translationInView(self.view).x * speed), panGestureRecognizer.view!.center.y)
                panGestureRecognizer.view!.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1-scale/1000, 1-scale/1000)
                panGestureRecognizer .setTranslation(CGPointMake(0, 0), inView: self.view)
                
                
                
                self.leftSlideMenuVC?.view.hidden = false
                self.rightSlideMenuVC?.view.hidden = true
                //}
            } else {
                panGestureRecognizer.view!.center = CGPointMake(panGestureRecognizer.view!.center.x + panGestureRecognizer.translationInView(self.view).x * speed, panGestureRecognizer.view!.center.y)
                panGestureRecognizer.view!.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1+scale/1000, 1+scale/1000)
                panGestureRecognizer .setTranslation(CGPointMake(0, 0), inView: self.view)
                
                
                
                self.leftSlideMenuVC?.view.hidden = true
                self.rightSlideMenuVC?.view.hidden = false
            }
        case UIGestureRecognizerState.Ended:
            if scale > 150*speed {
                self.showLeft()
            } else if scale < -150*speed {
                self.showRight()
            } else {
                self.showMain()
                scale  = 0
            }
        default:
            break;
        }
    }
    
    
    func mainViewTap(tapGestureRecognizer:UITapGestureRecognizer) {
        self.showMain()
    }
    
    
    func showLeft() {
        UIView.beginAnimations(nil, context: nil)
        self.mainVC?.view!.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8, 0.8)
        self.mainVC?.view!.center = CGPointMake(340, UIScreen.mainScreen().bounds.size.height/2)
        UIView .commitAnimations()
        
        self.leftSlideMenuVC?.view.hidden = false
        self.rightSlideMenuVC?.view.hidden = true
        
        self.slideMenuOpenState = FBSlideMenuSate.SlideMenuStateOpen
        
        if self.mainViewTapGestureRecognizer == nil {
            self.mainViewTapGestureRecognizer = UITapGestureRecognizer()
            self.mainViewTapGestureRecognizer.addTarget(self, action: "mainViewTap:")
        }
        self.mainVC!.view.addGestureRecognizer(self.mainViewTapGestureRecognizer)
    }
    
    func showRight() {
        UIView.beginAnimations(nil, context: nil)
        self.mainVC?.view!.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8, 0.8)
        self.mainVC?.view!.center = CGPointMake(-60, UIScreen.mainScreen().bounds.size.height/2)
        UIView .commitAnimations()
        
        self.leftSlideMenuVC?.view.hidden = true
        self.rightSlideMenuVC?.view.hidden = false
        
        self.slideMenuOpenState = FBSlideMenuSate.SlideMenuStateOpen
        
        
        if self.mainViewTapGestureRecognizer == nil {
            self.mainViewTapGestureRecognizer = UITapGestureRecognizer()
            self.mainViewTapGestureRecognizer.addTarget(self, action: "mainViewTap:")
        }
        self.mainVC!.view.addGestureRecognizer(self.mainViewTapGestureRecognizer)
    }
    
    func showMain() {
        UIView.beginAnimations(nil, context: nil)
        self.mainVC?.view!.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0)
        self.mainVC?.view!.center = CGPointMake(UIScreen.mainScreen().bounds.size.width/2, UIScreen.mainScreen().bounds.size.height/2)
        UIView .commitAnimations()
        
        
        //self.leftSlideMenuVC?.view.hidden = true
        //self.rightSlideMenuVC?.view.hidden = true
        
        scale = 0
        self.slideMenuOpenState = FBSlideMenuSate.SlideMenuStateClosed
        
        self.mainVC!.view.removeGestureRecognizer(self.mainViewTapGestureRecognizer)
    }
    
    
    
    
    //隐藏状态栏
    //override func prefersStatusBarHidden() -> Bool {
    //return true
    //}
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
