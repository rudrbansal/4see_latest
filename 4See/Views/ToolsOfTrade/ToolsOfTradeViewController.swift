//
//  ToolsOfTradeViewController.swift
//  4See
//
//  Created by Rudr Bansal on 07/12/21.
//

import UIKit
import SideMenu

class ToolsOfTradeViewController: BaseViewController {
    
    @IBOutlet weak var toolsTableView: UITableView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnSelectAll: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    var isRemoveItemsSelected = false
    let viewModel = ToolsOfTradeViewModel()
    
    let tools = ["Macbook Pro", "Magic Mouse 2"]
    let toolsImages = ["placeholderMacbook", "placeholderSamsung"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toolsTableView.dataSource = self
        toolsTableView.delegate = self
        toolsTableView.reloadData()
        btnBack.setTitle("", for: .normal)
        btnAdd.setTitle("", for: .normal)
        btnSelectAll.isHidden = !isRemoveItemsSelected
        btnCancel.isHidden = !isRemoveItemsSelected
        initSideMenuView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getSystemsData()
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
    
    @IBAction func btnActionAdd(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "ToolsOfTrade", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddToolViewController") as! AddToolViewController
        navigationController?.pushViewController(vc, completion: nil)
    }
    
    @IBAction func btnActionDelete(_ sender: UIButton) {
        isRemoveItemsSelected = true
        headerLabel.text = "Select tools to remove"
        btnSelectAll.isHidden = !isRemoveItemsSelected
        btnCancel.isHidden = !isRemoveItemsSelected
    }
}

extension ToolsOfTradeViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.systemsList?.data?.count ?? 0
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToolsOfTradeTableViewCell") as! ToolsOfTradeTableViewCell
        cell.toolsLabel.text = viewModel.systemsList?.data?[indexPath.row].title
        //        if viewModel.systemsList?.data?[indexPath.row].images?.count ?? 0 > 0{
        //            cell.logoImageView.image = UIImage.init(named: viewModel.systemsList?.data?[indexPath.row].images?[0] ?? "")
        //        }
        cell.selectionButton.isHidden = !isRemoveItemsSelected
        return cell
    }
}

class ToolsOfTradeTableViewCell: UITableViewCell {
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var toolsLabel: UILabel!
    @IBOutlet weak var selectionButton: UIButton!
}

extension ToolsOfTradeViewController {
    
    func getSystemsData() {
        self.showProgressBar()
        viewModel.getSystemsAPI { (status,message) in
            if status == true
            {
                self.hideProgressBar()
                self.toolsTableView.reloadData()
                self.toolsTableView.delegate = self
                self.toolsTableView.dataSource = self
            }
            else
            {
                self.hideProgressBar()
            }
        }
    }
}
