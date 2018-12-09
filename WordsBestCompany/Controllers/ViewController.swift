//
//  ViewController.swift
//  WordsBestCompany
//
//  Created by Apple on 06/12/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn

class ViewController: UIViewController,GIDSignInUIDelegate,GIDSignInDelegate{
    
    @IBOutlet var txtPasswordTextFirld: UITextField!
    @IBOutlet var txtEmailIdTextField: UITextField!
    var login: Login?
//    var loginUserData: [LoginUserData?]?

    var dict : [String : AnyObject]!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        GIDSignIn.sharedInstance().delegate = self as! GIDSignInDelegate
        GIDSignIn.sharedInstance().uiDelegate = self
        // Do any additional setup after loading the view, typically from a nib.
//        self.getProfileData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSignInOnclickAction(_ sender: Any) {
        self.performSegue(withIdentifier: "signUpProceedseg", sender: self)

        if self.txtEmailIdTextField.text == ""
        {
            Utilities.sharedInstance.showErrorMessage("", message: "Please Enter email id", controller: self)
        }
        else if self.txtPasswordTextFirld.text == ""
        {
            Utilities.sharedInstance.showErrorMessage("", message: "Please Enter password", controller: self)
        }
        else if (Utilities.sharedInstance.isValidEmail(txtEmailIdTextField.text ?? "") == false)
        {
            let resultMessage = "Please enter valid email id"
            Utilities.sharedInstance.showErrorMessage("", message: resultMessage,controller: self)

        }
        if (self.txtEmailIdTextField.text == "vipul@exceptionaire.co") && (self.txtPasswordTextFirld.text == "Cyber@8131")
        {
             self.getProfileData()

        }
        else
        {
             Utilities.sharedInstance.showErrorMessage("", message: "Invalid Credentials!", controller: self)
        }
    }
    
    @IBAction func btnForgotPasswordOnclickAction(_ sender: Any) {
    }
    //Facebook Login
    @IBAction func btnFacebookLoginOnclickAction(_ sender: Any) {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil {
                    if(fbloginresult.grantedPermissions.contains("email"))
                    {
                        self.getFBUserData()
                        fbLoginManager.logOut()
                    }
                }
            }
        }
    }
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as! [String : AnyObject]
                    print(result!)
                    var fbPopUpVAlues :String = ""
                    if let email = self.dict!["email"] as? String {
                        // no error
                        print(email)
                        fbPopUpVAlues = email
                        
                    }
                    if let last_name = self.dict!["last_name"] as? String {
                        // no error
                        print(last_name)
                        fbPopUpVAlues = fbPopUpVAlues + "\n" + last_name
                        
                    }
                    if let first_name = self.dict!["first_name"] as? String {
                        // no error
                        fbPopUpVAlues = fbPopUpVAlues + "\n" + first_name
                        
                    }
                    Utilities.sharedInstance.showErrorMessage("Facebook Login Credentials", message: fbPopUpVAlues, controller: self)
//                    print(self.dict)
                }
            })
        }
    }
    
    //Google Login
    @IBAction func btnGoogleLoginOnclickAction(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("error",error.localizedDescription)
        } else {
            
            let fullName = user.profile.name ?? "" as String
            
            let email = user.profile.email ?? "" as String
            UserDefaults.standard.set(fullName, forKey: "GoogleFullName")
            UserDefaults.standard.set(email, forKey: "GoogleEmail")
            var googlePopup = fullName + email

            Utilities.sharedInstance.showErrorMessage("Google Login Credentials", message: googlePopup, controller: self)
            

        }
    }
    
    @IBAction func btnSignUpLoginOnclickAction(_ sender: Any) {
    }
    
    @IBAction func btnSkipOnclickAction(_ sender: Any) {
    }
    
    //Login and get ProfileData
    func getProfileData()
    {
        let paramDict = NSMutableDictionary();

        let IMEINo = UIDevice.current.identifierForVendor!.uuidString
        paramDict.setValue("123123123", forKey: "imei_no")
        
        paramDict.setValue("123123123"  , forKey: "device_id")
        paramDict.setValue("vipul@exceptionaire.co"  , forKey: "email_id")
        paramDict.setValue("Cyber@8131"  , forKey: "password")
        paramDict.setValue("iOS"  , forKey: "device")


        
        print("paramDict is",paramDict)
        
        let imei_no = paramDict["imei_no"]
        let device_id = paramDict["device_id"]
        let email_id = paramDict["email_id"]
        let password = paramDict["password"]
        
        
        
        let parametersDict = ["imei_no": imei_no!,"device_id": device_id!,"email_id": email_id!,"password": password!]
        
        
        self.getMyProfile(urlString: ConstantsClass.Login_User, paramDict: parametersDict as NSDictionary)
        
    }
    
    func getMyProfile(urlString:String , paramDict:NSDictionary)
    {
        if Utilities.sharedInstance.isConnectedToNetwork() {
            Utilities.sharedInstance.showHUD(view: self.view)
        
            WebServiceManagerClass.sharedInstance.GetDataFromAPI (urlString: urlString, parametersDict: paramDict as! Dictionary <String,AnyObject>, successCallback: { [weak self] (isSuccess, data,responseMessage) in
                if(isSuccess)
                {
                    print("ResponseMyprofile%@",data)
//                    if let data = data.data(using: String.Encoding.utf8) {
//
                    do {

                        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                        //  return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

                        if let dictionary = json {
                            let status = dictionary["status"] as! String
                            if status == "success"
                            {
                         let dict = dictionary["data"]
                            let name = dict!["first_name"] as! String
                            let lastname = dict!["last_name"] as! String
                            let id = dict!["user_id"] as! Int
                            let profile = dict!["user_picture"] as! String
                            let email_id = dict!["email_id"] as! String
                            UserDefaults.standard.set(name, forKey: "name")
                            UserDefaults.standard.set(profile, forKey: "profile")

                            UserDefaults.standard.set(dict, forKey: "GoogleFullName")
                            UserDefaults.standard.set(dict, forKey: "ProfileData")
                            print("Something went dict",dict)
                                DispatchQueue.main.async {
                                    Utilities.sharedInstance.hideHUD(view: (self?.view)!);
                                    
                            var localNotification = UILocalNotification()
                            localNotification.fireDate = NSDate(timeIntervalSinceNow: 5) as Date
                            localNotification.alertBody = "Wellcome to WBC App"
                            localNotification.timeZone = NSTimeZone.default
                            UIApplication.shared.scheduleLocalNotification(localNotification)
                            self?.performSegue(withIdentifier: "signUpProceedseg", sender: self)
                                }
                            }
                            else
                            {
                                DispatchQueue.main.async {
                                                                                                    Utilities.sharedInstance.hideHUD(view: (self?.view)!);
                                    
                                                                                                    Utilities.sharedInstance.showErrorMessage("", message: "Fail!", controller: self!)
                                    
                                                                    }
                                
                            }
                            }

                        
                    }
                        catch {
                        print("Something went wrong")
                    }
                }
                    else
                    {
                        
                    }
                },  failureCallback: { [weak self] (error) in
                    
                    DispatchQueue.main.async {
                        Utilities.sharedInstance.hideHUD(view: (self?.view)!);

                        if self != nil {
                            ErrorUtils.showErrorForServerWithCode(error, controller: self!)
                        }
                        Utilities.sharedInstance.showErrorMessage("", message: AlertMessages.NETWORK_ERROR_MESSAGE, controller: self!)
                    }
            })
        }
        else {
            DispatchQueue.main.async {
                Utilities.sharedInstance.showErrorMessage("", message:AlertMessages.NETWORK_ERROR_MESSAGE, controller: self)
                Utilities.sharedInstance.hideHUD(view: (self.view)!);
            }
        }
        
    }
    
    
    
}

