//
//  LeaveViewController.swift
//  4See
//
//  Created by Rudr Bansal on 07/12/21.
//

import UIKit

class LeaveViewController: BaseViewController {
    
    @IBOutlet weak var leaveTableView: UITableView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    
    let viewModel = SickViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnBack.setTitle("", for: .normal)
        btnAdd.setTitle("", for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getLeavesData()
    }
    
    func getLeavesData() {
        self.showProgressBar()
        viewModel.gettLeavesAPI { (status,message) in
            if status == true {
                self.hideProgressBar()
                self.leaveTableView.delegate = self
                self.leaveTableView.dataSource = self
                self.leaveTableView.reloadData()
            } else {
                self.hideProgressBar()
            }
        }
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
        return viewModel.leavesList!.data!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaveTableViewCell") as! LeaveTableViewCell
        let data = viewModel.leavesList!.data![indexPath.row]
        cell.setupCellData(data: data)
        return cell
    }
}

class LeaveTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var typeOfLeaveLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    func setupCellData(data: leaveInfo) {
        self.typeOfLeaveLabel.text = data.reason
        if data.status == "0" {
            statusLabel.text = "Pending"
        } else if data.status == "1" {
            statusLabel.text = "Approved"
        } else if data.status == "2" {
            statusLabel.text = "Declined"
        }
        
        let date = data.updatedAt
        dateLabel.text = createDateStamp(dateFromBackEnd: date ?? "")
    }
    
    func createDateStamp(dateFromBackEnd:String)->String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        let date = formatter.date(from: dateFromBackEnd)
        formatter.dateFormat = "yyyy-MM-dd"
        let requiredDate = formatter.string(from: date ?? Date())
        return requiredDate
    }
}
