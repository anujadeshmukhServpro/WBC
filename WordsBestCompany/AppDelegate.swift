//
//  AppDelegate.swift
//  WordsBestCompany
//
//  Created by Apple on 06/12/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Foundation
import FBSDKCoreKit
import GoogleSignIn
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
   

    var window: UIWindow?

    var orientationLock = UIInterfaceOrientationMask.portrait
    var notificationTitle : String = ""
    var userInfonotificatioin: [AnyHashable: Any]?
    
    let gcmMessageIDKey = "gcm.message_id"
    //orientationcode statrt
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }
    struct AppUtility {
        static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
            if let delegate = UIApplication.shared.delegate as? AppDelegate {
                delegate.orientationLock = orientation
            }
        }
        
        static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
            self.lockOrientation(orientation)
            UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        }
    }
    //orientationcode end
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 28/255, green: 42/255, blue: 68/255, alpha: 1.0)
        
        //Status bar font in white
        UIApplication.shared.statusBarStyle = .lightContent
        let navBackgroundImage:UIImage! = UIImage(named: "00-WBC-splash-screen-.png")
        UINavigationBar.appearance().setBackgroundImage(navBackgroundImage, for: .default)

        GIDSignIn.sharedInstance().clientID = "362505036398-4o0gk4u3j5sbekq55vorva7v4mo3553h.apps.googleusercontent.com"//for google

        //Forfb
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
         GIDSignIn.sharedInstance().signOut()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
          FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    //Fb
    public func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool
    {
        
        if #available(iOS 9.0, *) {
            var yesOrNO: Bool
            
            yesOrNO = FBSDKApplicationDelegate.sharedInstance().application(
                app,
                open: url as URL!,
                sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String,
                annotation: options[UIApplicationOpenURLOptionsKey.annotation]
            )
            
            if yesOrNO {
                
                if (FBSDKAccessToken.current()) != nil{
                    // UserDefaults.standard.set("Yes", forKey: "Login")
                    //self.createMenuView()
                }
                //  UserDefaults.standard.set("Yes", forKey: "Login")
                //self.createMenuView()
            }
            return yesOrNO;
        } else {
            // Fallback on earlier versions
        }
        return true
    }
    
    
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String, annotation: AnyObject?) -> Bool {
        
        FBSDKApplicationDelegate.sharedInstance().application(application, open: url as URL!, sourceApplication: sourceApplication, annotation: annotation)
        return true
    }
    public func application(_ application: UIApplication, open url: URL,     sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(
            application,
            open: url as URL!,
            sourceApplication: sourceApplication,
            annotation: annotation)
    }


}
extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector("statusBar")) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}

