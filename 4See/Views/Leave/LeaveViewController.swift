//
//  LeaveViewController.swift
//  4See
//
//  Created by Rudr Bansal on 07/12/21.
//

import UIKit

class LeaveViewController: UIViewController {
    
    @IBOutlet weak var leaveTableView: UITableView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leaveTableView.dataSource = self
        leaveTableView.delegate = self
        leaveTableView.reloadData()
        btnBack.setTitle("", for: .normal)
        btnAdd.setTitle("", for: .normal)
    }
    
    @IBAction func btnActionBack(_ sneder: UIButton) {
        navigationController?.popViewController()
    }
    
    @IBAction func btnActionAdd(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Leave", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RequestLeaveViewController") as! RequestLeaveViewController
        navigationController?.pushViewController(vc, completion: nil)
    }
    
    @IBAction func btnActionDelete(_ sender: UIButton) {
        
    }
}
extension LeaveViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaveTableViewCell") as! LeaveTableViewCell
        return cell
    }
}

class LeaveTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var typeOfLeaveLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
}
