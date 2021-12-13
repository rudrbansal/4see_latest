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
    
    let viewModel = attendanceViewModel()
    var type = ""
    var slots: timeSlots = .fifteenMins
    
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
        cell.btnSelection.backgroundColor = .white
        switch slots {
        case .fifteenMins:
            cell.btnSelection.backgroundColor = (indexPath.row == 0) ? .green : .white
        case .thirtyMins:
            cell.btnSelection.backgroundColor = (indexPath.row == 1) ? .green : .white
        case .sixtyMins:
            cell.btnSelection.backgroundColor = (indexPath.row == 2) ? .green : .white
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            slots = .fifteenMins
        case 1:
            slots = .thirtyMins
        case 2:
            slots = .sixtyMins
        default:
            break
        }
        
        let storyboard = UIStoryboard(name: "Attendance", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AttendanceViewController") as! AttendanceViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}
class WorkingFromHomeTableViewCell: UITableViewCell {

    @IBOutlet weak var timingLabel: UILabel!
    @IBOutlet weak var btnSelection: UIButton!
}
