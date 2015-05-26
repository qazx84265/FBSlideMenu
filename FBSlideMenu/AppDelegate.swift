//
//  AppDelegate.swift
//  FBSlideMenu
//
//  Created by bluesky on 15/5/26.
//  Copyright (c) 2015年 bluesky. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    var slideMenu:FBSlideMenuVC!
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.backgroundColor = UIColor.whiteColor()
        
        var firstVC = UIViewController()
        firstVC.view.backgroundColor = UIColor.lightGrayColor()
        firstVC.title = "first"
        var secondVC = UIViewController()
        secondVC.view.backgroundColor = UIColor.orangeColor()
        secondVC.title = "second"
        
        var tabbarController = UITabBarController()
        tabbarController.addChildViewController(firstVC)
        tabbarController.addChildViewController(secondVC)
        
        var leftMenuVC = UIViewController()
        leftMenuVC.view.backgroundColor = UIColor .blueColor()
        
        var rightMenuVC = UIViewController()
        rightMenuVC.view.backgroundColor = UIColor .redColor()
        
        
        var nav = UINavigationController(rootViewController: tabbarController)
        nav.view.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        nav.view.layer.shadowOpacity = 0.7
        nav.view.layer.shadowRadius = 10.0
        nav.view.layer.shadowColor = UIColor.blackColor().CGColor
        
        var shadowPath = UIBezierPath(rect: nav.view.bounds)
        nav.view.layer.shadowPath = shadowPath.CGPath
        
        var barBtn = UIBarButtonItem(title: "left", style: UIBarButtonItemStyle.Plain, target: self, action: "openLeft:")
        tabbarController.navigationItem.leftBarButtonItem = barBtn
        var barBtnr = UIBarButtonItem(title: "right", style: UIBarButtonItemStyle.Plain, target: self, action: "openRight:")
        tabbarController.navigationItem.rightBarButtonItem = barBtnr
        
        //-------------slide
        slideMenu = FBSlideMenuVC(leftVC: leftMenuVC, mainVC: nav,rightVC: rightMenuVC)
        
        
        self.window!.rootViewController = slideMenu
        
        self.window!.makeKeyAndVisible()
        
        
        // Override point for customization after application launch.
        return true
    }
    
    func openLeft(button:UIButton) {
        if slideMenu.slideMenuOpenState == FBSlideMenuSate.SlideMenuStateClosed {
            slideMenu.showLeft()
        } else if slideMenu.slideMenuOpenState == FBSlideMenuSate.SlideMenuStateOpen {
            slideMenu.showMain()
        }
    }
    
    func openRight(button:UIButton) {
        if slideMenu.slideMenuOpenState == FBSlideMenuSate.SlideMenuStateClosed {
            slideMenu.showRight()
        } else {
            slideMenu.showMain()
        }
    }


    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

