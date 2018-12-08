//
//  LoginUser.swift
//  WordsBestCompany
//
//  Created by Apple on 07/12/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
struct LoginUserData : Decodable{
    let userId : Int?
    let firstName : String?
    let lastName : String?
    let emailId : String?
    let userPicture : String?

       enum CodingKeys : String,CodingKey { // declaring our keys
            case userId = "user_id"
            case firstName = "first_name"
            case lastName = "last_name"
            case emailId = "email_id"
            case userPicture = "user_picture"

        }
 
}
struct Login : Decodable{
    let status: String?
    let data: [LoginUserData?]?
    let message : String?
  
    enum CodingKeys : String, CodingKey {
        case status = "status"
//        case data = "data"
//        case message = "message"
        case message, data
      
    }
    
}
struct CatagoryData : Decodable{
    let categoryId : Int?
    let categoryName : String?
    let categoryImage : String?
    
    enum CodingKeys : String, CodingKey {
        case categoryId = "category_id"
        case categoryName = "category_name"
        case categoryImage = "category_image"
        
    }
    
}
struct Catagory : Decodable{
    let status: String?
    let data: [CatagoryData?]?
    let notificationCount : Int?
    
   enum CodingKeys : String, CodingKey {
//        case status = "status"
//        case data = "data"
        case notificationCount = "notification_count"
        case status, data
    }
    
}
