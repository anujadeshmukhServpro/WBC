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
        self.getProfileData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnSignInOnclickAction(_ sender: Any) {
        
        self.performSegue(withIdentifier: "signUpProceedseg", sender: self)
    }
    
    @IBAction func btnForgotPasswordOnclickAction(_ sender: Any) {
    }
    
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
                    if let email = self.dict!["email"] as? String {
                        // no error
                        print(email)
//                        self.txtEmailIdTextField.text = email ?? ""
                        
                    }
                    if let last_name = self.dict!["last_name"] as? String {
                        // no error
                        print(last_name)
//                        self.txtLastNameTextField.text = last_name ?? ""
                        
                    }
                    if let first_name = self.dict!["first_name"] as? String {
                        // no error
//                        self.txtFirstNameTextField.text = first_name ?? ""
                        
                    }
//                    self.txtLastNameTextField.isEnabled = false
//                    self.txtFirstNameTextField.isEnabled = false
//                    self.txtEmailIdTextField.isEnabled = false
//                    print(self.dict)
                }
            })
        }
    }
    @IBAction func btnGoogleLoginOnclickAction(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("error",error.localizedDescription)
        } else {
            
            let fullName = user.profile.name
            
            let email = user.profile.email
            UserDefaults.standard.set(fullName, forKey: "GoogleFullName")
            UserDefaults.standard.set(email, forKey: "GoogleEmail")
            //            let fullNameGoogleLogin    = UserDefaults.standard.string(forKey: "GoogleFullName")
            //            let fullNameArr = fullNameGoogleLogin?.components(separatedBy: " ")
            //
            //            let firstName    = fullNameArr![0]
            //            let surname = fullNameArr![1]
            //            self.txtEmailIdTextField.text = UserDefaults.standard.string(forKey: "GoogleEmail")
            //            self.txtFirstNameTextField.text = firstName
            //            self.txtLastNameTextField.text = surname
            //            self.txtLastNameTextField.isEnabled = false
            //            self.txtFirstNameTextField.isEnabled = false
            //            self.txtEmailIdTextField.isEnabled = false
            
            
            // ...
        }
    }
    
    @IBAction func btnSignUpLoginOnclickAction(_ sender: Any) {
    }
    
    @IBAction func btnSkipOnclickAction(_ sender: Any) {
    }
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
        
        
        
        //5EC8E10330447FD1278A4691C3CB724B
        
        let parametersDict = ["imei_no": imei_no!,"device_id": device_id!,"email_id": email_id!,"password": password!]
        
        
        self.getMyProfile(urlString: ConstantsClass.Login_User, paramDict: parametersDict as NSDictionary)
        
    }
    
    func getMyProfile(urlString:String , paramDict:NSDictionary)
    {
//        if Utilities.sharedInstance.isConnectedToNetwork() {
//            Utilities.sharedInstance.showHUD(view: self.view)
        
            WebServiceManagerClass.sharedInstance.GetDataFromAPI (urlString: urlString, parametersDict: paramDict as! Dictionary <String,AnyObject>, successCallback: { [weak self] (isSuccess, data,responseMessage) in
                if(isSuccess)
                {
                    print("ResponseMyprofile%@",data)
                    if let data = data.data(using: String.Encoding.utf8) {

                    do {
                        
                        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                        //  return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        print("json%@",json)
                        if let dictionary = json as? [String: Any] {
                         var dict = dictionary["data"]
                            print("Something went dict",dict)
//                            let mirror = Mirror(reflecting: dict)
//                            for child in mirror.children  {
//                                print("key: \(child.label), value: \(child.value)")
//                            }
                           
                            
                        }
                    }
                        catch {
                        print("Something went wrong")
                    }
                    }
                    var trimmedString = data.trimmingCharacters(in: .whitespaces)
                    
                    
                    let possibleWhiteSpace:NSArray = ["\t", "\n\r", "\n","\r","\r\n\r\n", "  "] //here you add other types of white space
                    
                    possibleWhiteSpace.enumerateObjects { (whiteSpace, idx, stop) -> Void in
                        trimmedString = trimmedString.replacingOccurrences(of: whiteSpace as! String, with: "")
                    }
                   
                        do
                        {
                            let decoder = JSONDecoder()
                            self?.login = try decoder.decode(Login.self, from: trimmedString.data(using: .utf8) ?? Data(capacity: 1))
//                            decoder.keyDecodingStrategy = .convertFromSnakeCase

                            guard let status = self?.login?.status else {
                                return
                            }
                            print("Status",status)
                            if status == "Fail"
                            {
                                DispatchQueue.main.async {
                                    //                            Utilities.sharedInstance.hideHUD(view: (self?.view)!);
                                    //                            let result =  self?.updateAddress?.message
                                    //                            Utilities.sharedInstance.showErrorMessage("", message: result!, controller: self!)
                                    
                                }
                            }
                            else if status == "Success" {
                                
                               /*
                                guard let login = self?.login?.data else{
                                    return
                                }
                                
                                self?.loginUserData = login
                                DispatchQueue.main.async {
                                    
                                    //                            Utilities.sharedInstance.hideHUD(view: (self?.view)!);
                                    //                            let result =  self?.updateAddress?.message
                                    //                            Utilities.sharedInstance.showErrorMessage("", message: result!, controller: self!)
                                    //                            let userName = (self?.txtUserNameEditTextField.text)! + (self?.txtSirnameTextField.text)!
                                    //
                                    //
                                    //                            UserDefaults.standard.set(userName , forKey: "UserName")
                                    //                            self?.navigationItem.rightBarButtonItem = nil
                                    
                                    
                                }
                                */
                                
                            }
                        }
                        catch {
                            print(error.localizedDescription)
                            DispatchQueue.main.async {
                                //                        Utilities.sharedInstance.hideHUD(view: (self?.view)!);
                                //                        Utilities.sharedInstance.showErrorMessage("", message: error.localizedDescription, controller: self!)
                            }
                        }
                    
                    }
                    else
                    {
                        
                    }
                },  failureCallback: { [weak self] (error) in
                    
//                    DispatchQueue.main.async {
//                        Utilities.sharedInstance.hideHUD(view: (self?.view)!);
//
//                        if self != nil {
//                            ErrorUtils.showErrorForServerWithCode(error, controller: self!)
//                        }
//                        Utilities.sharedInstance.showErrorMessage("", message: AlertMessages.NETWORK_ERROR_MESSAGE, controller: self!)
//                    }
            })
//        }
//        else {
//            DispatchQueue.main.async {
//                Utilities.sharedInstance.showErrorMessage("", message:AlertMessages.NETWORK_ERROR_MESSAGE, controller: self)
//                Utilities.sharedInstance.hideHUD(view: (self.view)!);
//            }
//        }
        
    }
    
    
    
}

