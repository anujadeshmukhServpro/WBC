

import UIKit
import MBProgressHUD
import SystemConfiguration

/*enum TextFieldErrorType: String{
    case emailMessage = "Please Enter email id"
    case passwordMessage = "Please Enter password"
    case invalidCredentials = "Please enter valid email id"
}*/

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
