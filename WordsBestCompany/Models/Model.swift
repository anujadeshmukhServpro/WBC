//
//  LoginUser.swift
//  WordsBestCompany
//
//  Created by Apple on 07/12/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
struct LoginUserData : Decodable{
    var user_id : String?
    var first_name : String?
    var last_name : String?
    var email_id : String?
    var user_picture : String?
    
}
struct Login : Decodable{
    var message : String?
    var status: String?
    var data: [LoginUserData?]?
    
}
struct CatagoryData : Decodable{
    var category_id : String?
    var category_name : String?
    var category_image : String?
    
}
struct Catagory : Decodable{
    var status: String?
    var data: [CatagoryData?]?
    var notification_count : String?

    
}
