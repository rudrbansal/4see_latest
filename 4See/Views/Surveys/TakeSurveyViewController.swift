//
//  TakeSurveyViewController.swift
//  4See
//
//

import UIKit

class TakeSurveyViewController: UIViewController {
    
    @IBOutlet weak var surveyQuestionsTableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    
    let surveys = ["Free fruit in the work place", "Do dog see colour?", "Are rainbows real?"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        surveyQuestionsTableView.dataSource = self
        surveyQuestionsTableView.delegate = self
        surveyQuestionsTableView.reloadData()
        backButton.setTitle("", for: .normal)
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        navigationController?.popViewController()
    }
}

extension TakeSurveyViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return surveys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SurveyQuestionsTableViewCell") as! SurveyQuestionsTableViewCell
        cell.lblQuestion.text = surveys[indexPath.row]
        cell.btnCheck.setTitle("", for: .normal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Surveys", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SurveyDetailsViewController") as! SurveyDetailsViewController
        navigationController?.pushViewController(vc, completion: nil)
    }
}

class SurveyQuestionsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var btnCheck: UIButton!
}
