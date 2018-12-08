//
//  ErrorUtils.swift
//  EPA
//
//  Created by Pradip Walghude on 7/2/17.
//  Copyright © 2017 Pradip Walghude Protected Technology. All rights reserved.
//

import Foundation


class ErrorUtils
{
    static func showErrorForServerWithCode(_ error: NSError, controller: UIViewController)
    {
        if error.code == -1009 || error.code == -1005 {
            Utilities.sharedInstance.showErrorMessage("", message: AlertMessages.NETWORK_ERROR_MESSAGE, controller: controller)
        } else if error.code == -1001 || error.code == -999 {
            
        } else {
            Utilities.sharedInstance.showErrorMessage("", message: AlertMessages.INVALID_RESPONSE, controller: controller)
        }
    }
}
