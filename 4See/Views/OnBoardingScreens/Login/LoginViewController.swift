//
//  loginViewController.swift
//  4See
//
//  Created by Gagan Arora on 03/03/21.
//
import UIKit
import SwiftValidator

class loginViewController: BaseViewController {
    
    @IBOutlet weak var usernameTFT: UITextField!
    @IBOutlet weak var passwordTFT: UITextField!
    
    var viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1.0) {
            self.view.layoutIfNeeded()
        }
    }
  
    @IBAction func loginBtnAction(_ sender: Any) {
        validator.validate(self)
    }
    
    @IBAction func forgotPassBtnAction(_ sender: Any) {
        let objc = forgetPasswordVC()
        self.navigationController?.pushViewController(objc)
    }
    
    @IBAction func privacyPolicyBtnAction(_ sender: Any) {
        let objc = privacyPolicy()
        objc.modalPresentationStyle = .overFullScreen
        self.present(objc, animated: true, completion: nil)
    }
}
// ValidationDelegate Methods
extension loginViewController : ValidationDelegate {
 
    func validationSuccessful() {
        if usernameTFT.text == "" && passwordTFT.text == "" {
            self.showToast("All fields are required.")
        }
        else if usernameTFT.text == "" {
            self.showToast("Username is required.")
        }
        else if passwordTFT.text == "" {
            self.showToast("Password is required.")
        }
        else {
            viewModel.setValues(usernameTFT.text!, passwordTFT.text!)
            self.userLogin()
        }
    }

    func validationFailed(_ errors:[(Validatable ,ValidationError)]) {
        if let errorMessage = errors.first?.1.errorMessage {
            super.showToast(errorMessage)
        }
    }
}

extension loginViewController {
        func userLogin() {
        super.showProgressBar()
        viewModel.loginUser { (status, message) in
            super.hideProgressBar()
            if status {
//                let objc = HomeViewController()
//                self.navigationController?.pushViewController(objc)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                let objLogoutVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//                let navigationController = UINavigationController(rootViewController: objLogoutVC)
    //            let navigationController = UINavigationController(rootViewController: objLogoutVC)
                self.navigationController?.navigationBar.isTranslucent = false
                self.navigationController?.navigationBar.isHidden = true
//                self.window?.rootViewController = navigationController
//                self.window?.makeKeyAndVisible()
                self.navigationController?.pushViewController(objLogoutVC, animated: true)
            } else {
                self.showToast(message)
            }
        }
    }
}
