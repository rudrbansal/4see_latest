//
//  SurveyDetailsViewController.swift
//  4See
//
//  Created by Rudr Bansal on 04/12/21.
//

import UIKit

class SurveyDetailsViewController: UIViewController {
    
    @IBOutlet weak var surveyTableView: UITableView!
    @IBOutlet weak var btnBack: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        surveyTableView.dataSource = self
        surveyTableView.delegate = self
        surveyTableView.reloadData()
        btnBack.setTitle("", for: .normal)
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension SurveyDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var tableCell = UITableViewCell()
        if indexPath.row == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SurveyDetailsMultipleOptionsTableViewCell")as! SurveyDetailsMultipleOptionsTableViewCell
        cell.btnStronglyDisagree.setTitle("", for: .normal)
        cell.btnDisagree.setTitle("", for: .normal)
        cell.btnNeutral.setTitle("", for: .normal)
        cell.btnAgree.setTitle("", for: .normal)
        cell.btnStronglyAgree.setTitle("", for: .normal)
        
        cell.stronglyDisagreeSelectionLabel.backgroundColor = .white
        cell.disagreeSelectionLabel.backgroundColor = .white
        cell.neutralSelectionLabel.backgroundColor = .white
        cell.agreeSelectionLabel.backgroundColor = .white
            tableCell = cell
        } else if indexPath.row == 1 {
//            return cell
//        } else if indexPath.row == 1 {
//            let cell = SurveyDetailsDualOptionsTableViewCell()
            let cell = tableView.dequeueReusableCell(withIdentifier: "SurveyDetailsDualOptionsTableViewCell")as! SurveyDetailsDualOptionsTableViewCell
            cell.btnNo.setTitle("", for: .normal)
            cell.btnYes.setTitle("", for: .normal)
            
            
            cell.disagreeSelectionLabel.backgroundColor = .white
            tableCell = cell
////            return cell
        }
        return tableCell
    }
}

class SurveyDetailsMultipleOptionsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblQuestionNumber: UILabel!
    @IBOutlet weak var lblQuestion: UILabel!

    @IBOutlet weak var btnStronglyDisagree: UIButton!
    @IBOutlet weak var btnDisagree: UIButton!
    @IBOutlet weak var btnNeutral: UIButton!
    @IBOutlet weak var btnAgree: UIButton!
    @IBOutlet weak var btnStronglyAgree: UIButton!
    
    @IBOutlet weak var stronglyDisagreeSelectionLabel: UILabel!
    @IBOutlet weak var disagreeSelectionLabel: UILabel!
    @IBOutlet weak var neutralSelectionLabel: UILabel!
    @IBOutlet weak var agreeSelectionLabel: UILabel!
    @IBOutlet weak var stronglyAgreeSelectionLabel:UILabel!
    
    @IBAction func btnActionStronglyDisagree(_ sender: UIButton) {
        
    }
    
    @IBAction func btnActionDisagree(_ sender: UIButton) {
        
    }
    
    @IBAction func btnActionNeutral(_ sender: UIButton) {
        
    }
    
    @IBAction func btnActionAgree(_ sender: UIButton) {
        
    }
    
    @IBAction func btnActionStronglyAgree(_ sender: UIButton) {
        
    }
}

class SurveyDetailsDualOptionsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var btnNo: UIButton!
    
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var stronglyDisagreeSelectionLabel: UILabel!
    @IBOutlet weak var disagreeSelectionLabel: UILabel!

    @IBAction func btnActionYes(_ sender: UIButton) {
        
    }
    
    @IBAction func btnActionNo(_ sender: UIButton) {
        
    }
}
