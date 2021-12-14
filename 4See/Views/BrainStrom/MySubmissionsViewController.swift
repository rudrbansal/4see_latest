//
//  MySubmissionsViewController.swift
//  4See
//
//  Created by Rudr Bansal on 14/12/21.
//

import UIKit
import SideMenu

class MySubmissionsViewController: BaseViewController {

    @IBOutlet weak var mySubmissionsTableView: UITableView!
    @IBOutlet weak var btnBack: UIButton!

    let tasks = ["Task 1", "Task 2", "Task 3"]
    let taskDates = ["12-02-21", "12-02-21", "12-02-21"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mySubmissionsTableView.dataSource = self
        mySubmissionsTableView.delegate = self
        mySubmissionsTableView.reloadData()
        btnBack.setTitle("", for: .normal)
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
extension MySubmissionsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MySubmissionsTableViewCell") as! MySubmissionsTableViewCell
        cell.subjectLabel.text = tasks[indexPath.row]
        cell.dateLabel.text = taskDates[indexPath.row]
        cell.backgroundColor = (indexPath.row % 2) == 0 ? UIColor(hexString: "EFECE9") : UIColor.white
        return cell
    }
}

class MySubmissionsTableViewCell: UITableViewCell {
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var emailImageView: UIImageView!
}
