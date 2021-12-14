//
//  SubmitIdeaViewController.swift
//  4See
//
//  Created by Rudr Bansal on 08/12/21.
//

import UIKit
import SideMenu

class SubmitIdeaViewController: UIViewController {
    
    @IBOutlet weak var publishedSubmissionsTableView: UITableView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnAddIdea: UIButton!
    
    let ideas = ["Product design", "New hardware"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        publishedSubmissionsTableView.dataSource = self
        publishedSubmissionsTableView.delegate = self
        publishedSubmissionsTableView.reloadData()
        btnBack.setTitle("", for: .normal)
        btnAddIdea.setTitle("", for: .normal)
        initSideMenuView()
    }
    
    @IBAction func btnActionAdd(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "BrainStrom", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SubmitAnIdeaViewController") as! SubmitAnIdeaViewController
        navigationController?.pushViewController(vc, completion: nil)
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
    
    @IBAction func btnActionMySubmissions(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "BrainStrom", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MySubmissionsViewController") as! MySubmissionsViewController
        navigationController?.pushViewController(vc, completion: nil)
    }
}

extension SubmitIdeaViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ideas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubmitIdeaTableViewCell") as! SubmitIdeaTableViewCell
        cell.lblIdeas.text = ideas[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "BrainStrom", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PublishedSubmissionViewController") as! PublishedSubmissionViewController
        navigationController?.pushViewController(vc, completion: nil)
    }
}

class SubmitIdeaTableViewCell: UITableViewCell {
    @IBOutlet weak var lblIdeas: UILabel!
}
