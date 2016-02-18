//
//  FirstSceneViewController.swift
//  layout_1
//
//  Created by Rijul Gupta on 3/13/15.
//  Copyright (c) 2015 Rijul Gupta. All rights reserved.
//NEW
//The first controller seen. This will either send you to the login screen or to the people view sceen.

import UIKit



class FirstSceneViewController: UIViewController{
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

   
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
       //startIt()
        let delayTime2 = dispatch_time(DISPATCH_TIME_NOW,
            Int64(0.01 * Double(NSEC_PER_SEC)))
        
        
        dispatch_after(delayTime2, dispatch_get_main_queue(), {
                           self.startIt()
                        })
    }
    
    func startIt(){
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let fbid = defaults.stringForKey("saved_fb_id")
        let numHashtags = defaults.stringForKey("numHashtags")
        if(fbid != nil){
            
            if(fbid == "none"){
                let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                //let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("test_view_switcher") as UIViewController
                let mainView = mainStoryboard.instantiateViewControllerWithIdentifier("fb_login_scene_id")
                
                
                //   self.dismissViewControllerAnimated(true, completion: nil)
                
                self.presentViewController(mainView, animated: false, completion: nil)
            }
            else{
                if(numHashtags == nil){
                    
                    let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                    //let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("test_view_switcher") as UIViewController
                    //let mainView = mainStoryboard.instantiateViewControllerWithIdentifier("main_tab_bar_scene_id") as! UITabBarController
                    let mainView = mainStoryboard.instantiateViewControllerWithIdentifier("pick_hashtags_id") as! pickHashtagsInitialViewController
                    
                    mainView.commingFrom = "firstView"
                    // self.dismissViewControllerAnimated(true, completion: nil)
                    
                    self.presentViewController(mainView, animated: false, completion: nil)
                    
                }
                else{
                    
                    let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                    //let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("test_view_switcher") as UIViewController
                    let mainView = mainStoryboard.instantiateViewControllerWithIdentifier("main_tab_bar_scene_id") as! UITabBarController
                   // let mainView = mainStoryboard.instantiateViewControllerWithIdentifier("pick_hashtags_id") as! pickHashtagsInitialViewController
                    
                   // mainView.commingFrom = "firstView"
                    // self.dismissViewControllerAnimated(true, completion: nil)
                    
                    self.presentViewController(mainView, animated: false, completion: nil)
                    
                    
                }
                
            }
            
            
        }
        else{
            let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            //let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("test_view_switcher") as UIViewController
            let mainView = mainStoryboard.instantiateViewControllerWithIdentifier("fb_login_scene_id")
            
            
           // self.dismissViewControllerAnimated(true, completion: nil)
            
            self.presentViewController(mainView, animated: false, completion: nil)
            
            
            
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
    func testUserLogin(){
        
        
    }
    
}