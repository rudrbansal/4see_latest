//
//  menuVC.swift
//  4See
//
//  Created by Gagan Arora on 04/03/21.
//

import UIKit

class menuVC: UIViewController {
    var viewModel = LoginViewModel()
    
    //    @IBOutlet weak var logoImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(UrlConfig.IMAGE_URL+(AppConfig.loggedInUser!.userInfo!.companyId!.image!))
    }
    
    @IBAction func changePassBtn(_ sender: Any) {
        let objc = changePasswordVC()
        self.navigationController?.pushViewController(objc)
    }
    
    @IBAction func menuBtnAction(_ sender: Any) {
        switch (sender as AnyObject).tag{
        case 1:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            navigationController?.pushViewController(vc, completion: nil)
        case 2:
            let storyboard = UIStoryboard(name: "Attendance", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "AttendanceListViewController") as! AttendanceListViewController
            navigationController?.pushViewController(vc, completion: nil)
        case 3:
            let objc = messageVC()
            self.navigationController?.pushViewController(objc)
        case 4:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "SpecialOpsViewController") as! SpecialOpsViewController
            vc.headerTitle = "Vision & Mission"
            navigationController?.pushViewController(vc, completion: nil)
        case 5:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "SpecialOpsViewController") as! SpecialOpsViewController
            vc.headerTitle = "Special Ops"
            navigationController?.pushViewController(vc, completion: nil)
        case 6:
            let objc = policiesVC()
            self.navigationController?.pushViewController(objc)
//        case 7:
            
            
        default:
            print("No Button Selected")
            
        }
    }
    
    @IBAction func btnLogout(_ sender: UIButton) {
        let alertController = UIAlertController(title: "4See", message: "Are you sure you want to logout?", preferredStyle: .alert)
                    let btnYes = UIAlertAction(title: "Yes", style: .default) { (action:UIAlertAction!) in
                        self.userLogout()
                    }
                    let btnCancel = UIAlertAction(title: "Cancel", style: .default)
                    { (action:UIAlertAction!) in
                        
                    }
                    alertController.addAction(btnYes)
                    alertController.addAction(btnCancel)
                    self.present(alertController, animated: true, completion:nil)
    }
}
extension menuVC {
    func userLogout() {
        viewModel.logout { (status, message) in
            if status {
                Global.userLogOut()
            } else {
            }
        }
    }
}
