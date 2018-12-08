//
//  ViewController.swift
//  WordsBestCompany
//
//  Created by Apple on 06/12/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var txtPasswordTextFirld: UITextField!
    @IBOutlet var txtEmailIdTextField: UITextField!
    var login: Login?
    var loginUserData: [LoginUserData?]?
    var catagory: Catagory?
    var catagoryData: [CatagoryData?]?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.getProfileData()
        self.getCatagory()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnSignInOnclickAction(_ sender: Any) {
    }
    
    @IBAction func btnForgotPasswordOnclickAction(_ sender: Any) {
    }
    
    @IBAction func btnFacebookLoginOnclickAction(_ sender: Any) {
    }
    
    @IBAction func btnGoogleLoginOnclickAction(_ sender: Any) {
    }
    @IBAction func btnSignUpLoginOnclickAction(_ sender: Any) {
    }
    
    @IBAction func btnSkipOnclickAction(_ sender: Any) {
    }
    func getProfileData()
    {
        let paramDict = NSMutableDictionary();
//        email_id  : vipul@exceptionaire.co
//        password  :Cyber@8131
//        device_id 123123123
//        imei_no   123123123
//        device      “iOS”

        
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
    
    
    func getCatagory()
    {
        let paramDict = NSMutableDictionary();
        
        paramDict.setValue("216", forKey: "user_id")
        
        print("paramDict is",paramDict)
        
        let user_id = paramDict["user_id"]
     
        
        let parametersDict = ["user_id": user_id!]
        
        
        self.getCatagoryData(urlString: ConstantsClass.GetCategories, paramDict: parametersDict as NSDictionary)
        
    }
    func getCatagoryData(urlString:String , paramDict:NSDictionary)
    {
        //        if Utilities.sharedInstance.isConnectedToNetwork() {
        //            Utilities.sharedInstance.showHUD(view: self.view)
        
        WebServiceManagerClass.sharedInstance.GetDataFromAPI (urlString: urlString, parametersDict: paramDict as! Dictionary <String,AnyObject>, successCallback: { [weak self] (isSuccess, data,responseMessage) in
            if(isSuccess)
            {
                print("ResponseCatagoryDatas%@",data)
                
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

