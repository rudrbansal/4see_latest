//
//  SelectCategoryViewController.swift
//  4See
//
//  Created by Rudr Bansal on 08/12/21.
//

import UIKit
import SideMenu

class SelectCategoryViewController: UIViewController {
    
    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var btnBack: UIButton!
    
    let categories = ["IT", "Systems", "Product ", "Customer Interaction", "Staff Happiness"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTableView.dataSource = self
        categoryTableView.delegate = self
        categoryTableView.reloadData()
        btnBack.setTitle("", for: .normal)
        initSideMenuView()
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        navigationController?.popViewController()
    }
    
    func initSideMenuView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        SideMenuManager.default.leftMenuNavigationController = storyboard.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? SideMenuNavigationController
    }
    
    @IBAction func menuBtnAction(_ sender: Any) {
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
}

extension SelectCategoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectCategoryTableViewCell") as! SelectCategoryTableViewCell
        cell.categoryLabel.text = categories[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "BrainStrom", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SubmitIdeaViewController") as! SubmitIdeaViewController
        navigationController?.pushViewController(vc, completion: nil)
    }
}

class SelectCategoryTableViewCell: UITableViewCell {
    @IBOutlet weak var categoryLabel: UILabel!
}
