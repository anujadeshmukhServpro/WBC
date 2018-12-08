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
    func GetDataFromAPI(urlString :String ,parametersDict: Dictionary<String, AnyObject>,successCallback:@escaping (Bool, String, Bool)->Void, failureCallback:@escaping (NSError)->Void) -> Void
    {
     
        let parameters = parametersDict
        let reuestURl = String(format:urlString,ConstantsClass.baseUrl)
        
        
        //now create the NSMutableRequest object using the url object
        let request = NSMutableURLRequest(url: NSURL(string:reuestURl)! as URL)
//        sessionConfig.timeoutIntervalForResource = 60.0
//        let session = URLSession(configuration: sessionConfig)
        //create the session object
//        let session = URLSession.shared
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 30.0
        sessionConfig.timeoutIntervalForResource = 30.0
//        var session = URLSession(configuration: sessionConfig , del)
       let session = URLSession(
            configuration: sessionConfig,
            
            delegate: NSURLSessionPinningDelegate(),
          
            delegateQueue: nil)
//        session.configuration.timeoutIntervalForRequest = 60.0
//        session.configuration.timeoutIntervalForResource = 30.0

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
            
            responseString = self.aesDecryption(to: responseString)
           
           

            let isSuccess : Bool;
            isSuccess = true;
            
            successCallback(isSuccess,responseString ?? "{}",true);
            
//            self.ssldemo()
            
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
    func ssldemo()
    {
        if let url = NSURL(string: "https://falcon.nxglabs.in/api/User/GetSplashScreenImages") {
            
            let session = URLSession(
                configuration: URLSessionConfiguration.ephemeral,
                delegate: NSURLSessionPinningDelegate(),
                delegateQueue: nil)
            
            
            let task = session.dataTask(with: url as URL, completionHandler: { (data, response, error) -> Void in
                if error != nil {
                    print("error: \(error!.localizedDescription): \(error!)")
                } else if data != nil {
                    if let str = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) {
                        print("Received data:\n\(str)")
                    } else {
                        print("Unable to convert data to text")
                    }
                }
            })
            
            task.resume()
        } else {
            print("Unable to create NSURL")
        }
    }
}
class NSURLSessionPinningDelegate: NSObject, URLSessionDelegate {
//    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
//        let serverTrust = challenge.protectionSpace.serverTrust
//        let certificate =  SecTrustGetCertificateAtIndex(serverTrust!, 0)
//
//        //set ssl polocies for domain name check
//        let policies = NSMutableArray()
//        policies.add(SecPolicyCreateSSL(true, challenge.protectionSpace.host as CFString))
//        SecTrustSetPolicies(serverTrust!, policies)
//
//        //evaluate server certifiacte
//        var result:SecTrustResultType =  SecTrustResultType(rawValue: 0)!
//        SecTrustEvaluate(serverTrust!, &result)
//        let isServerTRusted:Bool =  (result == SecTrustResultType.unspecified || result == SecTrustResultType.proceed)
//
//        //get Local and Remote certificate Data
//
//        let remoteCertificateData:NSData =  SecCertificateCopyData(certificate!)
//        let pathToCertificate = Bundle.main.path(forResource: "b5718d309b9e07a", ofType: "crt")
//        let localCertificateData:NSData = NSData(contentsOfFile: pathToCertificate!)!
//
//        //Compare certificates
//        if(isServerTRusted && remoteCertificateData.isEqual(to: localCertificateData as Data)){
//            let credential:URLCredential =  URLCredential(trust:serverTrust!)
//            completionHandler(.useCredential,credential)
//        }
//        else{
//            completionHandler(.cancelAuthenticationChallenge,nil)
//        }
//    }
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Swift.Void) {

        // Adapted from OWASP https://www.owasp.org/index.php/Certificate_and_Public_Key_Pinning#iOS

        if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
            if let serverTrust = challenge.protectionSpace.serverTrust {
                var secresult = SecTrustResultType.invalid
                let status = SecTrustEvaluate(serverTrust, &secresult)

                if(errSecSuccess == status) {
                    if let serverCertificate = SecTrustGetCertificateAtIndex(serverTrust, 0) {
                        let serverCertificateData = SecCertificateCopyData(serverCertificate)
                        let data = CFDataGetBytePtr(serverCertificateData);
                        let size = CFDataGetLength(serverCertificateData);
                        let cert1 = NSData(bytes: data, length: size)
                        let file_der = Bundle.main.path(forResource: "Certificate", ofType: "der")
                       
                        if let file = file_der {
                            if let cert2 = NSData(contentsOfFile: file) {
                                if cert1.isEqual(to: cert2 as Data) {
                                    completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust:serverTrust))
                                    return
                                }
                            }
                        }
                    }
                }
            }
        }

        // Pinning failed
        completionHandler(URLSession.AuthChallengeDisposition.cancelAuthenticationChallenge, nil)
    }
    func reject(with completionHandler: ((URLSession.AuthChallengeDisposition, URLCredential?) -> Void)) {
        completionHandler(.cancelAuthenticationChallenge, nil)
    }
    
    func accept(with serverTrust: SecTrust, _ completionHandler: ((URLSession.AuthChallengeDisposition, URLCredential?) -> Void)) {
        completionHandler(.useCredential, URLCredential(trust: serverTrust))
    }
    
}

