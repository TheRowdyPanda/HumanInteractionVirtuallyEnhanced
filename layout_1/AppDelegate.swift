//
//  AppDelegate.swift
//  layout_1
//
//  Created by Rijul Gupta on 3/4/15.
//  Copyright (c) 2015 Rijul Gupta. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        FBLoginView.self
        FBProfilePictureView.self
        
        
      //  [GAI sharedInstance].trackUncaughtExceptions = YES;
        GAI.sharedInstance().trackUncaughtExceptions = true
        // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
        //[GAI sharedInstance].dispatchInterval = 20;
        GAI.sharedInstance().dispatchInterval = 40
        
        // Optional: set Logger to VERBOSE for debug information.
        //[[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
        GAI.sharedInstance().logger.logLevel =  GAILogLevel.Verbose;
        
        // Initialize tracker. Replace with your tracking ID.
        //[[GAI sharedInstance] trackerWithTrackingId:@"UA-XXXX-Y"];
        GAI.sharedInstance().trackerWithTrackingId("UA-58702464-2")
        
        //registering for sending user various kinds of notifications

        
        // not for iOS 7
       // let notificationType = UIUserNotificationType.Alert | UIUserNotificationType.Badge | UIUserNotificationType.Sound
       // let settings = UIUserNotificationSettings(forTypes: notificationType, categories: nil)
       // application.registerUserNotificationSettings(settings)
        
        let notify : UIUserNotificationSettings = UIUserNotificationSettings(forTypes:[.Alert, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notify)
        UIApplication.sharedApplication().registerForRemoteNotifications()
        
        let alaume = AMConnect.sharedInstance()
        
        
        // For debugging purposes only
        alaume.isLoggingEnabled = true
        
        alaume.initializeWithAppId("s9", apiKey: "fff5a48b7c7e4999b7a5691d7458eed7")
        
        
//        let pageController = UIPageControl.appearance()
//        pageController.pageIndicatorTintColor = UIColor.lightGrayColor()
//        pageController.currentPageIndicatorTintColor = UIColor.blackColor()
//        pageController.backgroundColor = UIColor.clearColor()
//        pageController.frame = CGRectMake(0, 0, pageController.frame.width, pageController.frame.height)
        
        
          Instabug.startWithToken("882ce2b68fad34d8104d66fbbb42f839", captureSource: IBGCaptureSourceUIKit, invocationEvent: IBGInvocationEventShake)
        
        return true
    }

    //FB Method handles what happens after authentication
//    func application (application:UIApplication, openURL url:NSURL, sourceApplication:NSString?, annotation:AnyObject) -> Bool {
//        //test var
//        var wasHandled:Bool = FBAppCall.handleOpenURL(url, sourceApplication: sourceApplication)
//        // attempt to extract a token from the url
//        return wasHandled
//        
//    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        let wasHandled:Bool = FBAppCall.handleOpenURL(url, sourceApplication: sourceApplication)
        
        return wasHandled
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
       // self.saveContext()
    }


    //pragma mark - notifications
//    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        application.registerForRemoteNotifications()
    }
    
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [NSObject : AnyObject], completionHandler: () -> Void) {
        if(identifier == "declineAction"){
            
        }
        else if(identifier == "answerAction"){
            
        }
    }
    
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        NSLog("My device token is: %@", deviceToken)
        
        let dString = NSString(format: "%@", deviceToken)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(dString, forKey: "userDeviceToken")
        
        
        
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        NSLog("Failed to get token %@", error)
        
        let dToke = "none"
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(dToke, forKey: "userDeviceToken")
    }


}

