//
//  MenuViewController.swift
//  WordsBestCompany
//
//  Created by Apple on 08/12/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Kingfisher


class MenuViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet var lblIDLabel: UILabel!
    @IBOutlet var lblEmailIdLabel: UILabel!
    @IBOutlet var imgProfileImage: UIImageView!
    @IBOutlet var lblFirstNameLAbel: UILabel!
    @IBOutlet var imgProfileImageView: RoundUIView!
    @IBOutlet var tblMenuTableView: UITableView!
    var ManuNameArray:Array = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
       
 ManuNameArray = ["Home","Logout"]
        print(UserDefaults.standard.value(forKey: "ProfileData"))
        guard let dict = UserDefaults.standard.value(forKey: "ProfileData") as? [String: Any?],let name = dict["first_name"] as? String, let lastname = dict["last_name"] as? String, let id = dict["user_id"] as? Int, let profile = dict["user_picture"] as? String, let email_id = dict["email_id"] as? String else { return }
        
        print(dict)
        self.lblFirstNameLAbel.text = name + " " + lastname
        self.lblEmailIdLabel.text = email_id
        self.lblIDLabel.text = String(id)
        let imageUrlString = profile
        //                imageUrlString = ConstantsClass.FeaturesBaseImgUrl  + imageUrlString!
        let imageUrl:NSURL = NSURL(string: imageUrlString)!
        let resourse = ImageResource(downloadURL: imageUrl as URL, cacheKey: imageUrlString as! String)
        DispatchQueue.main.async {
            self.imgProfileImage.kf.setImage(with: resourse)
            self.imgProfileImage.contentMode = UIViewContentMode.scaleAspectFit
        }
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ManuNameArray.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        
        cell.lblMenuHeadingLabel.text! = ManuNameArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let revealviewcontroller:SWRevealViewController = self.revealViewController()
        
        let cell:MenuTableViewCell = tableView.cellForRow(at: indexPath) as! MenuTableViewCell
        print(cell.lblMenuHeadingLabel.text!)
        if cell.lblMenuHeadingLabel.text! == "Home"
        {
            print("Home Tapped")
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "ContaintsViewController") as! ContaintsViewController
            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
            
            revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
            
        }
        else if cell.lblMenuHeadingLabel.text! == "Logout"
        {
            if let delegate = UIApplication.shared.delegate as? AppDelegate {
                delegate.switchBack()
            }
        }
        
      
    }
}
