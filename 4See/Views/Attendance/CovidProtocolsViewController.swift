//
//  CovidProtocolsViewController.swift
//  4See
//
//

import UIKit
import SideMenu

class CovidProtocolsViewController: BaseViewController {
    
    @IBOutlet weak var covidProtocolsTableView: UITableView!
    @IBOutlet weak var btnBack: UIButton!
    
    let covidProtocols = ["ALWAYS WEAR A MASK", "WASH WITH SOAP FOR ATLEAST 20 SECONDS", "REGULARLY USE HAND SANITIZER", "AVOID LARGE CROWDS", "AVOID SHAKING HANDS AND PHYSICAL CONTACT"]
    let images = ["Mask", "Wash", "Sanitizer", "Crowds", "ShakingHands"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        covidProtocolsTableView.dataSource = self
        covidProtocolsTableView.delegate = self
        covidProtocolsTableView.reloadData()
        btnBack.setTitle("", for: .normal)
        initSideMenuView()
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
}

extension CovidProtocolsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return covidProtocols.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CovidProtocolTableViewCell") as! CovidProtocolTableViewCell
        cell.protocolLabel.text = covidProtocols[indexPath.row]
        cell.logoImageView.image = UIImage.init(named: images[indexPath.row])
        cell.separatorView.isHidden = (indexPath.row == (covidProtocols.count - 1))
        return cell
    }
}

class CovidProtocolTableViewCell: UITableViewCell {
    @IBOutlet weak var protocolLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var separatorView: UIView!
}
