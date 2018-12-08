//
//  ConstantsClass.swift
//  PGA
//
//  Created by Apple on 24/08/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class ConstantsClass: NSObject {
 
static let Login_User = "http://18.188.206.83:3001/login_user"
static let GetCategories =  "http://18.188.206.83:3001/getCategories"
static let imgUrl =  "https://rrewmsexceptionaire.s3.amazonaws.com/wbc/"

}

struct AlertMessages {
    static let NETWORK_ERROR_MESSAGE = "No Network. Please try again later."
    static let ENTER_AN_KEY = "Please enter key."
    static let ENTER_CONTACT_NUMBER = "Please enter valid contact number."
    static let INVALID_RESPONSE = "Oops! Something went wrong. Please try again in a bit."
    static let INVALID_RESPONSE_CHECKSTATUS = "Oops! Something went wrong."

    static let Task_Completed = "Task completed successfully."
}
struct Validations {
    static let VALID_EMAIL_REGEX = "[A-Za-z0-9._%$+-]+@[A-Za-z0-9._]+\\.[A-Za-z]{2,}"
}
