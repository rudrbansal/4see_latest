//
//  editProfileViewController.swift
//  4See
//
//  Created by Gagan Arora on 04/03/21.
//

import UIKit
import SideMenu

class EditProfileViewController: BaseViewController {
    override class var storyboardIdentifier: String {
        return "EditProfileViewController"
    }
    
    @IBOutlet weak var profileImg: UIImageView!
//    @IBOutlet weak var nameLbl: UILabel!
//    @IBOutlet weak var postLBL: UILabel!
    @IBOutlet weak var contactTFT: UITextField!
//    @IBOutlet weak var emailTFT: UITextField!
//    @IBOutlet weak var addressTFT: UITextField!
//    @IBOutlet weak var typeTFT: UITextField!
    @IBOutlet weak var deptLBL: UILabel!
    @IBOutlet weak var reportLineLbl: UILabel!
    @IBOutlet weak var payrollLbl: UILabel!
    @IBOutlet weak var idnrLbl: UILabel!
    @IBOutlet weak var jobTitleLbl: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    
    var viewModel = editProfileViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        initSideMenuView()
        dataSetup()
        btnBack.setTitle("", for: .normal)
    }
    //MARK:- SideMenu Function
    
    func initSideMenuView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        SideMenuManager.default.leftMenuNavigationController = storyboard.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? SideMenuNavigationController
        
    }

    func dataSetup() {
        Global.getDataFromUserDefaults(.userData)
        contactTFT.text = AppConfig.loggedInUser!.userInfo!.phone//UserDefaults.standard.value(forKey: "phone") as! String
        deptLBL.text = AppConfig.loggedInUser!.userInfo!.department!
        reportLineLbl.text = AppConfig.loggedInUser!.userInfo!.reportLine!
        payrollLbl.text = String(describing: AppConfig.loggedInUser!.userInfo!.payroll!)
        idnrLbl.text = AppConfig.loggedInUser!.userInfo!.idNr!
        jobTitleLbl.text = AppConfig.loggedInUser!.userInfo!.jobTitle!
    
        let img = UserDefaults.standard.value(forKey: "image") as! String
        profileImg.setImageOnView(UrlConfig.IMAGE_URL+(img ))
    }
    
    @IBAction func btnActionBack(_ sender: Any) {
        self.navigationController?.popViewController()
    }
    
    @IBAction func menuBtnAction(_ sender: Any) {
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)

    }
    
    @IBAction func openImagePickerBtn(_ sender: Any) {
        self.openImagePopUp { (pickerImage) in
            if let image = pickerImage {
                self.viewModel.attachments.append(image)
                self.profileImg.image = image
            }
        }
    }
    
    @IBAction func editBtnAction(_ sender: Any) {
        switch (sender as AnyObject).tag {
        case 1:
            contactTFT.becomeFirstResponder()
//        case 2:
//            emailTFT.becomeFirstResponder()
//        case 3:
//            addressTFT.becomeFirstResponder()
//        case 4:
//            typeTFT.becomeFirstResponder()
        default:
            print("no button clicked.")
        }
    }
    
    @IBAction func saveAction(_ sender: Any)
    {
        updateUserProfile()
    }
    
    @IBAction func actionGender(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            viewModel.gender = "Male"
        } else {
            viewModel.gender = "Female"
        }
    }
    
}

extension EditProfileViewController {
    
    func updateUserProfile() {
        viewModel.setValues( contactTFT.text!, contactTFT.text!, contactTFT.text!, contactTFT.text!)
        self.showProgressBar()
        viewModel.updateProfileAPI { (status, message) in
            self.hideProgressBar()
            if status == true {
                super.showToast("User updated successfully.")
                self.dataSetup()
            } else {
                self.hideProgressBar()
                super.showToast(message)
            }
        }
    }
    
}
