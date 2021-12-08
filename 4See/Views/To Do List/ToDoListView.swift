//
//  ToDoViewController.swift
//  4See

//

import UIKit

class ToDoViewController: UIViewController {

    @IBOutlet weak var toDoListTableView: UITableView!
    @IBOutlet weak var tasksCountLabel: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    
    let tasks = ["Task 1", "Task 2", "Task 3"]
    let taskDates = ["12-02-2012", "12-02-2012", "12-02-2012"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoListTableView.dataSource = self
        toDoListTableView.delegate = self
        toDoListTableView.reloadData()
        btnBack.setTitle("", for: .normal)
        btnAdd.setTitle("", for: .normal)
    }


    @IBAction func btnActionAdd(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ToDoList", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddListViewController") as! AddListViewController
        navigationController?.pushViewController(vc, completion: nil)
    }
        
    @IBAction func btnActionDelete(_ sender: Any) {
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
        cell.dateButton.setTitle(taskDates[indexPath.row], for: .normal)
        return cell
    }
}

class ToDoTableViewCell: UITableViewCell {
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var dateButton: UIButton!
}
