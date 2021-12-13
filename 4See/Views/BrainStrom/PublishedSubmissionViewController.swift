//
//  PublishedSubmissionViewController.swift
//  4See
//
//  Created by Rudr Bansal on 08/12/21.
//

import UIKit
import SideMenu

class PublishedSubmissionViewController: UIViewController {
    
    @IBOutlet weak var btnBack: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSideMenuView()
        // Do any additional setup after loading the view.
    }
    
    
    func initSideMenuView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        SideMenuManager.default.leftMenuNavigationController = storyboard.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? SideMenuNavigationController
    }
    
    @IBAction func menuBtnAction(_ sender: Any) {
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
    
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        navigationController?.popViewController()
    }
    
    
}
