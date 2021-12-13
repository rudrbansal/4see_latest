//
//  LeaveViewController.swift
//  4See
//
//  Created by Rudr Bansal on 07/12/21.
//

import UIKit
import SideMenu

class LeaveViewController: BaseViewController {
    
    @IBOutlet weak var leaveTableView: UITableView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnConfirmDelete: UIButton!
    @IBOutlet weak var btnCancelDelete: UIButton!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    let viewModel = SickViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableHeight.constant = (self.view.frame.height * 0.5)
        btnBack.setTitle("", for: .normal)
        btnAdd.setTitle("", for: .normal)
        initSideMenuView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getLeavesData()
        btnConfirmDelete.isHidden = true
        btnCancelDelete.isHidden = true
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
    
    func initSideMenuView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        SideMenuManager.default.leftMenuNavigationController = storyboard.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? SideMenuNavigationController
    }
    
    @IBAction func menuBtnAction(_ sender: Any) {
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
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
        btnConfirmDelete.isHidden = false
        btnCancelDelete.isHidden = false
        btnAdd.isHidden = true
        btnDelete.isHidden = true
        leaveTableView.reloadData()
    }
    
    @IBAction func btnActionConfirmDelete(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "PopUp", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PopUpViewController") as! PopUpViewController
        vc.popUpTitle = "Removed items"
        vc.message = "Items have been removed"
        present(vc, animated: false)
    }
    
    @IBAction func btnActionCancelDelete(_ sender: UIButton) {
        btnConfirmDelete.isHidden = true
        btnCancelDelete.isHidden = true
        btnAdd.isHidden = false
        btnDelete.isHidden = false
        leaveTableView.reloadData()
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
        cell.btnSelection.isHidden = btnConfirmDelete.isHidden
        return cell
    }
}

class LeaveTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var typeOfLeaveLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var btnSelection: UIButton!
    
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
        btnSelection.setTitle("", for: .normal)
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
