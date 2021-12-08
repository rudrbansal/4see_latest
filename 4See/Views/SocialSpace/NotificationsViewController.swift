//
//  NotificationsViewController.swift
//  4See
//
//  Created by Rudr Bansal on 04/12/21.
//

import UIKit

class NotificationsViewController: UIViewController {
    
    @IBOutlet weak var notificationsTableView: UITableView!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var tableContent = ["Christmas Party 2021", "Tgi Friday", "Charity Walk"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationsTableView.dataSource = self
        notificationsTableView.delegate = self
        notificationsTableView.reloadData()
        backButton.setTitle("", for: .normal)
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        navigationController?.popViewController()
    }
}

extension NotificationsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationsTableViewCell") as! NotificationsTableViewCell
        cell.notificationLabel.text = tableContent[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "SocialSpace", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EventDetailViewController") as! EventDetailViewController
        navigationController?.pushViewController(vc, completion: nil)
    }
}

class NotificationsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var notificationsSelectionImageView: UIImageView!
}
