//
//  WorkingFromHomeViewController.swift
//  4See
//
//

import UIKit

class WorkingFromHomeViewController: BaseViewController {

    @IBOutlet weak var timingOptionsTableView: UITableView!
    @IBOutlet weak var btnBack: UIButton!
    
    let timingOptions = ["15 minutes before", "30 minutes before", "60 minutes before"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timingOptionsTableView.dataSource = self
        timingOptionsTableView.delegate = self
        timingOptionsTableView.reloadData()
        btnBack.setTitle("", for: .normal)
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        navigationController?.popViewController()
    }
}
extension WorkingFromHomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timingOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkingFromHomeTableViewCell") as! WorkingFromHomeTableViewCell
        cell.timingLabel.text = timingOptions[indexPath.row]
        cell.btnSelection.setTitle("", for: .normal)
        return cell
    }
}
class WorkingFromHomeTableViewCell: UITableViewCell {

    @IBOutlet weak var timingLabel: UILabel!
    @IBOutlet weak var btnSelection: UIButton!
}
