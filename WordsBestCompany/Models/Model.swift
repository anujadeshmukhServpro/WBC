//
//  LoginUser.swift
//  WordsBestCompany
//
//  Created by Apple on 07/12/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
struct LoginUserData : Decodable{
    var userId : String?
    var firstName : String?
    var lastName : String?
    var emailId : String?
    var userPicture : String?
    
    init(userId: String, firstName: String, lastName: String ,emailId: String,userPicture: String) { // default struct initializer
        self.userId = userId
        self.firstName = firstName
        self.lastName = lastName
        self.emailId = emailId
        self.userPicture = userPicture
    }
        enum MyStructKeys: String, CodingKey { // declaring our keys
            case userId = "user_id"
            case firstName = "first_name"
            case lastName = "last_name"
            case emailId = "email_id"
            case userPicture = "user_picture"
            case convertFromSnakeCase

            
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: MyStructKeys.self) // defining our (keyed) container
            let userid: String = try container.decode(String.self, forKey: .userId)
            let firstname: String = try container.decode(String.self, forKey: .firstName)

            let lastname: String = try container.decode(String.self, forKey: .lastName)
            let emailid: String = try container.decode(String.self, forKey: .emailId)
            let userpicture: String = try container.decode(String.self, forKey: .userPicture)
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
           
            self.init(userId: userid, firstName: firstname, lastName: lastname, emailId: emailid, userPicture: userpicture)

        }
}
struct Login : Decodable{
    var message : String?
    var status: String?
    var data: [LoginUserData?]?
    
}
struct CatagoryData : Decodable{
    var category_id : Int?
    var category_name : String?
    var category_image : String?
    
}
struct Catagory : Decodable{
    var status: String?
    var data: [CatagoryData?]?
    var notification_count : String?

    
}
