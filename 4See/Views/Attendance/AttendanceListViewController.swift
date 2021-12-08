//
//  AttendanceListViewController.swift
//  4See
//
//

import UIKit

class AttendanceListViewController: UIViewController {

    @IBOutlet weak var attendanceListTableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    
    let attendanceOptions = ["Attendance", "Working from home", "Leave", "Running late", "Tools of trade", "Covid 19 protocol", "To do list"]
    let attendanceOptionsImages = ["Attendance", "WorkingFromHome", "Leave", "RunningLate", "ToolsOfTrade", "Covid19Protocol", "ToDoList"]

    override func viewDidLoad() {
        super.viewDidLoad()
        attendanceListTableView.dataSource = self
        attendanceListTableView.delegate = self
        attendanceListTableView.reloadData()
        backButton.setTitle("", for: .normal)
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension AttendanceListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attendanceOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttendanceListTableViewCell") as! AttendanceListTableViewCell
        cell.attendanceOptionLabel.text = attendanceOptions[indexPath.row]
        cell.iconImageView.image = UIImage.init(named: attendanceOptionsImages[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
            
        case 0:
            
            let storyboard = UIStoryboard(name: "Attendance", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "AttendanceViewController") as! AttendanceViewController
            navigationController?.pushViewController(vc, completion: nil)
            break
            
        case 1:
            
            let storyboard = UIStoryboard(name: "Attendance", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "WorkingFromHomeViewController") as! WorkingFromHomeViewController
            navigationController?.pushViewController(vc, completion: nil)
            break
            
        case 2:
            
            let storyboard = UIStoryboard(name: "Leave", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LeaveViewController") as! LeaveViewController
            navigationController?.pushViewController(vc, completion: nil)
            
        case 4:
            let storyboard = UIStoryboard(name: "ToolsOfTrade", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ToolsOfTradeViewController") as! ToolsOfTradeViewController
            navigationController?.pushViewController(vc, completion: nil)

        case 5:
            
            let storyboard = UIStoryboard(name: "Attendance", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "CovidProtocolsViewController") as! CovidProtocolsViewController
            navigationController?.pushViewController(vc, completion: nil)
            break
            
        case 6:
            
            let storyboard = UIStoryboard(name: "ToDoList", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ToDoViewController") as! ToDoViewController
            navigationController?.pushViewController(vc, completion: nil)
            break

        default:
            break
        }
    }
}

class AttendanceListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var attendanceOptionLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
}
