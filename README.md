# FBSlideMenu
slide menu for ios using swift.there are both left and right menu


# How to use

step 1:
  Add the 'FBSlideMenuVC.swift' to your own project
  
step 2:
  Init some viewcontrollers and add them to the FBSlideMenuVC.
  Here wo do this in the 'AppDelegate.swift'
  At first:declare the slideMenuVC
    var slideMenu:FBSlideMenuVC!
    
  then declare some viewControllers include the left menu and right menu controllers
  
    var firstVC = UIViewController()
        firstVC.view.backgroundColor = UIColor.lightGrayColor()
        firstVC.title = "first"
        var secondVC = UIViewController()
        secondVC.view.backgroundColor = UIColor.orangeColor()
        secondVC.title = "second"
        
        //tabbar controller
        var tabbarController = UITabBarController()
        tabbarController.addChildViewController(firstVC)
        tabbarController.addChildViewController(secondVC)
        
        //the left menu controller
        var leftMenuVC = UIViewController()
        leftMenuVC.view.backgroundColor = UIColor .blueColor()
        
        
        the right menu controller
        var rightMenuVC = UIViewController()
        rightMenuVC.view.backgroundColor = UIColor .redColor()
        
        //add navigation controller
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
        
  finally,create the slideMenu and make it as the rootController of the app.
        //-------------slide
        slideMenu = FBSlideMenuVC(leftVC: leftMenuVC, mainVC: nav,rightVC: rightMenuVC)
        
        self.window!.rootViewController = slideMenu
