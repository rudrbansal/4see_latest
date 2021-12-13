//
//  ViewController.swift
//  4See
//
//  Created by Unwanted User on 28/11/21.
//

import UIKit

class AttendanceViewController: UIViewController {
    
    @IBOutlet weak var optionsCollectionView: UICollectionView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var checkinTextField: UITextField!
    @IBOutlet weak var checkoutTextField: UITextField!
    @IBOutlet weak var breakTimeLabel: UILabel!
    @IBOutlet weak var toDoListTableView: UITableView!
    @IBOutlet weak var toDoTasksCountLabel: UILabel!
    @IBOutlet weak var btnManage: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    
    let options = ["Take a break", "Add Notes", "Attendance Register", "Clock Out"]
    let optionsImage = ["cupWhite", "notesWhite", "attendanceWhite", "clockOutWhite"]

    override func viewDidLoad() {
        super.viewDidLoad()
        optionsCollectionView.dataSource = self
        optionsCollectionView.delegate = self
        optionsCollectionView.reloadData()
        toDoListTableView.dataSource = self
        toDoListTableView.delegate = self
        toDoListTableView.reloadData()
        btnBack.setTitle("", for: .normal)
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        navigationController?.popViewController()
    }
    
    @IBAction func btnActionViewMore(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "ToDoList", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ToDoViewController") as! ToDoViewController
        navigationController?.pushViewController(vc, completion: nil)
    }
}

extension AttendanceViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttendanceTableViewCell") as! AttendanceTableViewCell
        cell.toDoListLabel.text = options[indexPath.row]
        cell.dropDownButton.setTitle("", for: .normal)
        return cell
    }
}

extension AttendanceViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AttendanceCollectionViewCell", for: indexPath) as! AttendanceCollectionViewCell
        cell.optionLabel.text = options[indexPath.row]
        cell.iconImageView.image = UIImage.init(named: optionsImage[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2) - 5, height: 48)
    }
}

class AttendanceTableViewCell: UITableViewCell {
    @IBOutlet weak var toDoListLabel: UILabel!
    @IBOutlet weak var dropDownButton: UIButton!
}

class AttendanceCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
}
