//
//  EventDetailViewController.swift
//  4See
//
//  Created by Rudr Bansal on 04/12/21.
//

import UIKit
import SideMenu

class EventDetailViewController: UIViewController {
    
    @IBOutlet weak var descriptionImageView: UIImageView!
    @IBOutlet weak var eventDetailsTableView: UITableView!
    
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var btnIgnore: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    
    let titles = ["Description", "Date", "Time", "Location"]
    let values = ["Description dummy data", "20/12/2021", "18h00 - 22h30", "123 office street, sandtron 2191"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventDetailsTableView.dataSource = self
        eventDetailsTableView.delegate = self
        eventDetailsTableView.reloadData()
        btnBack.setTitle("", for: .normal)
        btnConfirm.setTitleColor(UIColor.init(_colorLiteralRed: 91/255, green: 178/255, blue: 36/255, alpha: 1), for: .normal)
        btnIgnore.setTitleColor(UIColor.init(_colorLiteralRed: 241/255, green: 0/255, blue: 5/255, alpha: 1), for: .normal)
    }
    
    func initSideMenuView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        SideMenuManager.default.leftMenuNavigationController = storyboard.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? SideMenuNavigationController
    }
    
    @IBAction func menuBtnAction(_ sender: Any) {
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
    
    
    @IBAction func btnActionConfirm(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "PopUp", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PopUpViewController") as! PopUpViewController
        vc.popUpTitle = "GREAT! SEE YOU THERE"
        vc.message = "WE’RE LOOKING FORWARD TO IT"
        present(vc, animated: false)
    }
    
    @IBAction func btnActionCancel(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "PopUp", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PopUpViewController") as! PopUpViewController
        vc.popUpTitle = "Sorry you can’t make it"
        vc.message = "Maybe next time"
        present(vc, animated: false)
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        navigationController?.popViewController()
    }
}

extension EventDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventDetailTableViewCell") as! EventDetailTableViewCell
        cell.titleLabel.text = titles[indexPath.row]
        cell.descriptionLabel.text = values[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

class EventDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
}
