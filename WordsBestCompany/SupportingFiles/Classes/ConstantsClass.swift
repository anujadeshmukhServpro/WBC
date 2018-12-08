//
//  ConstantsClass.swift
//  PGA
//
//  Created by Apple on 24/08/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class ConstantsClass: NSObject {
 
static let baseUrl = "https://falcon.nxglabs.in/api/"//production
//static let baseUrl = "https://uatfalcon.nxglabs.in/api/"//uat
static let loginUrl = "%@Login/LoginOTP"
static let sugnUpUrl = "%@User/SignUp"
static let signUpVarifyOtp = "%@User/VerifyOtp"
static let VerifyLoginOtp = "%@Login/VerifyLoginOtp"//    Login/VerifyLoginOtp
static let GetBannerImg = "%@User/getBannerImage"//   User/getBannerImage
static let ImageBaseUrl = "https://falconadmin.nxglabs.in/uploadedimg/banners/"
static let SpashScreenImgBaseUrl = "https://uatfalconadmin.nxglabs.in/uploadedimg/splashscreen/"
static let ResendVerficationPin = "%@User/ResendVerficationPin"
static let ResendLoginVerficationPin = "%@Login/ResendLoginVerficationPin"
static let GetSplashScreenImages = "%@User/GetSplashScreenImages"
static let LogOutFromPanel = "%@User/LogOutFromPanel"
static let GetAllCourses = "%@Courses/GetAllCourses"
static let CoursesBAseImgUrl = "https://falconadmin.nxglabs.in/uploadedimg/courses/"
static let GetFeatureList = "%@Videos/GetFeatureList"
static let FeaturesBaseImgUrl = "https://falconadmin.nxglabs.in/videos/"//adduatif want uat vdo
static let TopicBaseImgUrl = "https://falconadmin.nxglabs.in/uploadedimg/subjects/"
static let  GetAllSubjectByCourses =  "%@Courses/GetAllSubjectByCourses"
static let SubjectsBaseImgUrl = "https://falconadmin.nxglabs.in/uploadedimg/subjects/"
static let  GetAllVideosBySubject =  "%@Subject/GetAllVideosBySubject"
//static let SubjectsVideoBaseImgUrl = "http://falconadmin.nxglabs.in/videos/" same as features base url
static let GetVideoDetails = "%@Videos/GetVideoDetails"
static let GetMyProfile = "%@User/getMyProfile"
static let GetPageContent = "%@Content/GetPageContent"
static let SubmitQuery = "%@Query/submitQuery"
static let AddUpdateAddress = "%@User/addUpdateAddress"
static let GetSearchResult = "%@search/GetSearchResult"
static let GetCourseSearch = "%@search/GetCourseSearch"
static let UpdateMyProfileName = "%@User/updateMyProfileName"
static let GetSubscriptionPlans = "%@Subscription/GetSubscriptionPlans"
static let GetMySubscriptionHistory = "%@Subscription/getMySubscriptionHistory"
static let AdddefaultAddress = "%@User/adddefaultAddress"
static let AddToSubscription = "%@Subscription/AddToSubscription"
static let checkSubscriptionStatus = "%@Subscription/checkSubscriptionStatus"
static let SendEmailInvoice = "%@Subscription/SendEmailInvoice"
static let GetRecentVideos = "%@Videos/GetRecentVideos"
static let MyFavourites = "%@Favourite/myFavourites"
static let AddVideoToWatchList = "%@Videos/AddVideoToWatchList"
static let GetRecentWatchHistory = "%@Videos/GetRecentWatchHistory"
static let AddToFavourites = "%@Favourite/addToFavourites"
static let RemoveFromFavourites = "%@Favourite/removeFromFavourites"
static let GenerateSessionId = "%@User/GenerateSessionId"//not done
static let GetNotifications = "%@Notification/GetNotifications"
static let GetAllFreeVideos = "%@Subject/GetAllFreeVideos"//for new dashboardfor free user
static let GetAllSubjects = "%@Subject/GetAllSubjects"//for new dashboardfor subscribed user
//https://falcon.nxglabs.in/api/
static let checkVersion = "%@versioncheck/checkVersion"
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
