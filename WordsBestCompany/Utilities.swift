//
//  Utilities.swift
//  EPA
//
//  Created by Pradip Walghude on 2017-06-29.
//  Copyright © 2017 Pradip Walghude Protected Technology. All rights reserved.
//

import UIKit
import MBProgressHUD

class Utilities: NSObject {

    
        static let sharedInstance: Utilities = {
            let instance = Utilities()
            return instance
        }()

    
    // Show Progress HUD
    func showHUD(view : UIView)  {
   
            MBProgressHUD.showAdded(to: view, animated: true)
    }
    
    /// Hide Progress HUD
    func hideHUD (view : UIView) {
     
//         MBProgressHUD.hideAllHUDs(for: view, animated: true)
        MBProgressHUD.hide(for: view, animated: true)
        
    }
    
    
    /// show error message
    ///
    /// - Parameters:
    ///   - title: title for alert
    ///   - message: message for alert
    ///   - controller: which controller to display
    func showErrorMessage (_ title: String, message: String, controller: UIViewController){
       
        let alertMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertMessage.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        controller.present(alertMessage, animated: true, completion: nil)
    }
        
        /// Check internet connectivity.
        func isConnectedToNetwork() -> Bool {
            var zeroAddress = sockaddr_in()
            zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
            zeroAddress.sin_family = sa_family_t(AF_INET)
            guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                    SCNetworkReachabilityCreateWithAddress(nil, $0)
                }
            }) else {
                return false
            }
            var flags : SCNetworkReachabilityFlags = []
            if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
                return false
            }
            let isReachable = flags.contains(.reachable)
            let needsConnection = flags.contains(.connectionRequired)
            return (isReachable && !needsConnection)
        }

    

    func convertDateFormat (taskDate:String)-> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //Your date format
        let date = dateFormatter.date(from: taskDate)
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "dd-MM-yyyy"
        let newDate = dateFormatter1.string(from: date!)
        
        return newDate
    }
    
    
    func convertDateFormat1 (taskDate:String)-> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //Your date format
        let date = dateFormatter.date(from: taskDate)
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy-MM-dd"
        let newDate = dateFormatter1.string(from: date!)
        
        return newDate
    }
    
    
     func getCalendarConvertedDate (eventDate:Date)-> String
     {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:MM:ss" //Your date format
        let dateStr = dateFormatter.string(from: eventDate)
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //Your date format
        let date1 = dateFormatter.date(from: dateStr)
        
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let formattedDate = dateFormatter.string(from: date1!)
        
        return formattedDate
    }
    
    func getCalendarConvertedDateToTime (eventDate:Date)-> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //Your date format
        let dateStr = dateFormatter.string(from: eventDate)
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //Your date format
      //  dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00")! as TimeZone
        let date1 = dateFormatter.date(from: dateStr)
        
        dateFormatter.dateFormat = "HH:mm"
        let formattedDate = dateFormatter.string(from: date1!)
        
        return formattedDate;
    }
    
    func ConvertedDateMiliSecondToDate (second:NSString)-> String
    {
    let milisecond = 1479714427;
        let dateVar = Date.init(timeIntervalSinceNow: TimeInterval(second as String)!/1000);
        let dateFormatter = DateFormatter();
    dateFormatter.dateFormat = "dd-mm-yyyy HH:mm";
    print(dateFormatter.string(from: dateVar));
        
        return dateFormatter.string(from: dateVar);
    }
    
    
    /// email validation
    ///
    /// - Parameter emailStr: email id
    /// - Returns: true if validation successful otherwise false
    func isValidEmail(_ emailStr:String) -> Bool{
        let emailRegex = Validations.VALID_EMAIL_REGEX
        let checkEmail = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return checkEmail.evaluate(with: emailStr)
    }
    
    
}
