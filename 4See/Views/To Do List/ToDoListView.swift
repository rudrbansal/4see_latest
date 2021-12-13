//
//  ToDoViewController.swift
//  4See

//

import UIKit
import SideMenu

class ToDoViewController: UIViewController {
    
    @IBOutlet weak var toDoListTableView: UITableView!
    @IBOutlet weak var tasksCountLabel: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var dateSelectionHeight: NSLayoutConstraint!
    @IBOutlet weak var selectToDeleteView: UIView!
    @IBOutlet weak var btnSelectAll: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnTapToSee: UIButton!
    
    let tasks = ["Task 1", "Task 2", "Task 3"]
    let taskDates = ["12-02-2012", "12-02-2012", "12-02-2012"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoListTableView.dataSource = self
        toDoListTableView.delegate = self
        toDoListTableView.reloadData()
        btnBack.setTitle("", for: .normal)
        btnAdd.setTitle("", for: .normal)
        initSideMenuView()
        selectToDeleteView.isHidden = true
    }
    
    @IBAction func btnActionAdd(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ToDoList", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddListViewController") as! AddListViewController
        navigationController?.pushViewController(vc, completion: nil)
    }
    
    func initSideMenuView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        SideMenuManager.default.leftMenuNavigationController = storyboard.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? SideMenuNavigationController
    }
    
    @IBAction func menuBtnAction(_ sender: Any) {
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
    
    @IBAction func btnActionSelectAll(_ sender: Any) {
    }
    
    @IBAction func btnActionCancel(_ sender: Any) {
        selectToDeleteView.isHidden = true
        btnTapToSee.isHidden = false
        dateSelectionHeight.constant = 16
        toDoListTableView.reloadData()
    }
    
    @IBAction func btnActionDelete(_ sender: Any) {
        selectToDeleteView.isHidden = false
        btnTapToSee.isHidden = true
        dateSelectionHeight.constant = 80
        toDoListTableView.reloadData()
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        navigationController?.popViewController()
    }
}

extension ToDoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableViewCell") as! ToDoTableViewCell
        cell.taskLabel.text = tasks[indexPath.row]
        cell.dateLabel.text = taskDates[indexPath.row]
        cell.dateLabel.isHidden = !selectToDeleteView.isHidden
        cell.btnSelection.isHidden = selectToDeleteView.isHidden
        cell.btnSelection.setTitle("", for: .normal)
        cell.backgroundColor = (indexPath.row % 2) == 0 ? UIColor(hexString: "EFECE9") : UIColor.white
        return cell
    }
}

class ToDoTableViewCell: UITableViewCell {
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var btnSelection: UIButton!
}
