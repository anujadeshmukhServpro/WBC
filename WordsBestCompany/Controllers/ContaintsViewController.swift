//
//  ContaintsViewController.swift
//  WordsBestCompany
//
//  Created by Apple on 07/12/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import LCBannerView
import Kingfisher


class ContaintsViewController: UIViewController ,LCBannerViewDelegate   {

    @IBOutlet var CollectionView: UICollectionView!
    @IBOutlet var bannerView: LCBannerView!
    @IBOutlet var btnMenu: UIBarButtonItem!
    var catagory: Catagory?
    var catagoryData: [CatagoryData?]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getBannerImages()
        self.getCatagory()

//        if revealviewcontroller() != nil {
//
//            btnMenu.target = self.revealviewcontroller()
//            btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
//            self.view.addGestureRecognizer(self.revealviewcontroller().panGestureRecognizer())
//                    }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
func getBannerImages()
{

    let imageURLs: [String] = ["https://rrewmsexceptionaire.s3.amazonaws.com/wbc/WBC_one.jpg","https://rrewmsexceptionaire.s3.amazonaws.com/wbc/WBC_two.jpg","https://rrewmsexceptionaire.s3.amazonaws.com/wbc/WBC_three.jpg"]
                                // Initialize bannerView
    
    self.bannerView = LCBannerView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.bannerView.frame.height), delegate: self, imageURLs: imageURLs, placeholderImageName:  "Concert", timeInterval: 3, currentPageIndicatorTintColor: UIColor.blue, pageIndicatorTintColor: UIColor.white)
    
         self.view.addSubview(self.bannerView!)
   
                          
    }
    func getCatagory()
    {
        let paramDict = NSMutableDictionary();
        
        paramDict.setValue("216", forKey: "user_id")
        
        print("paramDict is",paramDict)
        
        let user_id = paramDict["user_id"]
        
        
        let parametersDict = ["user_id": user_id!]
        
        
        self.getCatagoryData(urlString: ConstantsClass.GetCategories, paramDict: parametersDict as NSDictionary)
        
    }
    func getCatagoryData(urlString:String , paramDict:NSDictionary)
    {
        //        if Utilities.sharedInstance.isConnectedToNetwork() {
        //            Utilities.sharedInstance.showHUD(view: self.view)
        
        WebServiceManagerClass.sharedInstance.GetDataFromAPI (urlString: urlString, parametersDict: paramDict as! Dictionary <String,AnyObject>, successCallback: { [weak self] (isSuccess, data,responseMessage) in
            if(isSuccess)
            {
                print("ResponseCatagoryDatas%@",data)
                if let data = data.data(using: String.Encoding.utf8) {

                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                    //  return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print("json%@",json)
                    
                    
                    

                }
                catch {
                    print("Something went wrong")
                }
            }
                var trimmedString = data.trimmingCharacters(in: .whitespaces)
             
                
                let possibleWhiteSpace:NSArray = ["\t", "\n\r", "\n","\r","\r\n\r\n", "  ", "//","/"] //here you add other types of white space
                
                possibleWhiteSpace.enumerateObjects { (whiteSpace, idx, stop) -> Void in
                    trimmedString = trimmedString.replacingOccurrences(of: whiteSpace as! String, with: "")
                }
                do
                {
                    self?.catagory = try JSONDecoder().decode(Catagory.self, from: trimmedString.data(using: .utf8) ?? Data(capacity: 1))
                    guard let status = self?.catagory?.status else {
                        return
                    }
                  
                    if status == "Fail"
                    {
                        DispatchQueue.main.async {
//                            Utilities.sharedInstance.hideHUD(view: (self?.view)!);
//                            let result =  self?.updateAddress?.message
//                            Utilities.sharedInstance.showErrorMessage("", message: result!, controller: self!)
                            
                        }
                    }
                    else if status == "Success" {
                        
                        
                        guard let catagory = self?.catagory?.data else{
                            return
                        }
                        
                        self?.catagoryData = catagory
                        DispatchQueue.main.async {
                            self?.CollectionView.reloadData()
//                            Utilities.sharedInstance.hideHUD(view: (self?.view)!);
//                            let result =  self?.updateAddress?.message
//                            Utilities.sharedInstance.showErrorMessage("", message: result!, controller: self!)
//                            let userName = (self?.txtUserNameEditTextField.text)! + (self?.txtSirnameTextField.text)!
//
//
//                            UserDefaults.standard.set(userName , forKey: "UserName")
//                            self?.navigationItem.rightBarButtonItem = nil
                            
                            
                        }
                    }
                    
                    
                    
                }
                catch {
                    print(error.localizedDescription)
                    DispatchQueue.main.async {
//                        Utilities.sharedInstance.hideHUD(view: (self?.view)!);
//                        Utilities.sharedInstance.showErrorMessage("", message: error.localizedDescription, controller: self!)
                    }
                }
                
            }
            else
            {
                
            }
            },  failureCallback: { [weak self] (error) in
                
                //                    DispatchQueue.main.async {
                //                        Utilities.sharedInstance.hideHUD(view: (self?.view)!);
                //
                //                        if self != nil {
                //                            ErrorUtils.showErrorForServerWithCode(error, controller: self!)
                //                        }
                //                        Utilities.sharedInstance.showErrorMessage("", message: AlertMessages.NETWORK_ERROR_MESSAGE, controller: self!)
                //                    }
        })
        //        }
        //        else {
        //            DispatchQueue.main.async {
        //                Utilities.sharedInstance.showErrorMessage("", message:AlertMessages.NETWORK_ERROR_MESSAGE, controller: self)
        //                Utilities.sharedInstance.hideHUD(view: (self.view)!);
        //            }
        //        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
//Collection Views extention
    extension ContaintsViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
                     return self.catagoryData?.count ?? 0
            
            
        }
      
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let yourWidth = self.CollectionView.bounds.width/2.0
            let yourHeight = yourWidth
            
            return CGSize(width: yourWidth, height: yourHeight)
            
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets.zero
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewCell", for: indexPath) as? ContentCollectionViewCell
                let catagoryData = self.catagoryData?[indexPath.row]
//
            cell?.lblHeadingLAbel.text = catagoryData?.category_name
            let imageUrlString = catagoryData?.category_image
//                imageUrlString = ConstantsClass.FeaturesBaseImgUrl  + imageUrlString!
                let imageUrl:NSURL = NSURL(string: imageUrlString!)!
                let resourse = ImageResource(downloadURL: imageUrl as URL, cacheKey: imageUrlString)
                DispatchQueue.main.async {
                    cell?.imgCatagoryImage.kf.setImage(with: resourse)
                    cell?.imgCatagoryImage.contentMode = UIViewContentMode.scaleAspectFit
                }
//                return cell!
            
            
                return cell!
            
            
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
            
//                let confirmVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VideoPlayViewController") as! VideoPlayViewController
//                if let topicdataArray = self.topicdataArray  {
//                    confirmVC.topicData = topicdataArray[indexPath.row]
//                    confirmVC.VCIDString = "TopicData"
//                }
//                self.present(confirmVC, animated: true, completion: nil)
           
            
        }
    }

