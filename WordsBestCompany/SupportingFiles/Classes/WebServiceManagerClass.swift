//
//  WebServiceManagerClass.swift
//  PGA
//
//  Created by Apple on 24/08/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import AFNetworking
import WebKit
class MyJSONParser {
    private static let webView = WKWebView()
    
    class func parse(jsonString: String, completionHandler: @escaping (Any?, Error?) -> Void) {
        self.webView.evaluateJavaScript(jsonString, completionHandler: completionHandler)
    }
}
class WebServiceManagerClass: NSObject,URLSessionDelegate {
    fileprivate override init(){}
    static let sharedInstance = WebServiceManagerClass()
    var manager : AFURLSessionManager? = nil
    var PreviousTask : URLSessionDataTask? = nil
    
    func GetDataFromAPI(urlString :String ,parametersDict: Dictionary<String, AnyObject>,successCallback:@escaping (Bool, Data, Bool)->Void, failureCallback:@escaping (NSError)->Void) -> Void
    {
     
        let parameters = parametersDict
        let reuestURl = String(format:urlString, ConstantsClass.Login_User)
        
        
        //now create the NSMutableRequest object using the url object
        let request = NSMutableURLRequest(url: NSURL(string:reuestURl)! as URL)
        //create the session object
        let session = URLSession.shared
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 30.0
        sessionConfig.timeoutIntervalForResource = 30.0

        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            
        } catch let error {
            print(error.localizedDescription)
        }
      
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                print(error as Any)
                failureCallback(error! as NSError)
                return
            }
            
            guard let data = data else {
                return
            }
            
            var responseString = String(data: data, encoding: .utf8)
           
            print("Response without string ",responseString)
            
           
           

            let isSuccess : Bool;
            isSuccess = true;
            
            successCallback(isSuccess,data ,true);
            
            
        })
        
        task.resume()
    }
    func convertStringToDictionary(text: String) -> [String:AnyObject]?
    {
        
        print(text)
//        let text1 = text.trimmingCharacters(in: .whitespaces)

        
        if let data = text.data(using: String.Encoding.utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                //  return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                return json
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }
}
