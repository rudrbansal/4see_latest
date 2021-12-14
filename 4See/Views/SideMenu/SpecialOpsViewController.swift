//
//  SpecialOpsViewController.swift
//  4See
//
//  Created by Rudr Bansal on 15/12/21.
//

import UIKit
import SideMenu

class SpecialOpsViewController: BaseViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    
    var headerTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = headerTitle
        initSideMenuView()
        btnBack.setTitle("", for: .normal)
    }
    
    
    func initSideMenuView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        SideMenuManager.default.leftMenuNavigationController = storyboard.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? SideMenuNavigationController
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
            present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
        }
    
    @IBAction func menuBtnAction(_ sender: Any) {
            present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
        }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
