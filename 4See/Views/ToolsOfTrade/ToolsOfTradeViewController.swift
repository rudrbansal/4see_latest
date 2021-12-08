//
//  ToolsOfTradeViewController.swift
//  4See
//
//  Created by Rudr Bansal on 07/12/21.
//

import UIKit

class ToolsOfTradeViewController: UIViewController {

    @IBOutlet weak var toolsTableView: UITableView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnSelectAll: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    var isRemoveItemsSelected = false
    
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
        return tools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToolsOfTradeTableViewCell") as! ToolsOfTradeTableViewCell
        cell.toolsLabel.text = tools[indexPath.row]
        cell.logoImageView.image = UIImage.init(named: toolsImages[indexPath.row])
        cell.selectionButton.isHidden = !isRemoveItemsSelected
        return cell
    }
}

class ToolsOfTradeTableViewCell: UITableViewCell {
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var toolsLabel: UILabel!
    @IBOutlet weak var selectionButton: UIButton!
}
