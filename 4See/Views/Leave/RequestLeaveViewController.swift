//
//  RequestLeaveViewController.swift
//  4See
//
//  Created by Rudr Bansal on 07/12/21.
//

import UIKit

class RequestLeaveViewController: BaseViewController {
    
    @IBOutlet weak var tfStartDate: UITextField!
    @IBOutlet weak var tfEndDate: UITextField!
    @IBOutlet weak var tfLeavetype: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var leavespickerView: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var btnBack: UIButton!
    
    let leaveOptions = ["Annual", "Family responsibility", "Religious", "Other"]
    var isFromDate = false
    var isToDate = false
    let viewModel = SickViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.minimumDate = Date()
        btnBack.setTitle("", for: .normal)
        btnSubmit.setTitleColor(UIColor.init(hexString: "#C7C7C7"), for: .normal)
        btnSubmit.isUserInteractionEnabled = false
    }
    
    func showPopUp(title: String, message: String) {
        let storyboard = UIStoryboard(name: "PopUp", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PopUpViewController") as! PopUpViewController
        vc.popUpTitle = title
        vc.message = message
        present(vc, animated: false)
    }
    
    func applySickLeaveAPI() {
        self.showProgressBar()
        viewModel.applyLeaveApi{ (status,message) in
            self.hideProgressBar()
            if status == true {
                self.showPopUp(title: "SUBMISSION COMPLETE", message: "Your submission has been sent for review")
                self.navigationController?.popViewController(animated: true)
            } else {
                self.showToast(message)
            }
        }
    }
    
    @IBAction func btnActionSubmit(_ sender: UIButton) {
        if tfStartDate.text == "" || tfEndDate.text == "" {
            showToast("Date field is required.")
        } else if tfLeavetype.text == "" {
            showToast("Reason field is required.")
        } else {
            viewModel.setApplyLeaveValues(tfStartDate.text!,tfLeavetype.text!,"","", "0","0")
            applySickLeaveAPI()
        }
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        navigationController?.popViewController()
    }
    
    @IBAction func datePickerChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let strDate = dateFormatter.string(from: datePicker.date)
        if isFromDate {
            tfStartDate.text = strDate
        }
        if isToDate {
            tfEndDate.text = strDate
        }
    }
    
    func getAlert() {
        let alert = UIAlertController(title: "Other", message: "", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.text = ""
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            self.tfLeavetype.text = textField?.text ?? ""
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension RequestLeaveViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == tfLeavetype {
            tfLeavetype.inputView = leavespickerView
        } else {
            if textField == tfStartDate {
                isFromDate = true
                isToDate = false
            }
            if textField == tfEndDate {
                isFromDate = false
                isToDate = true
            }
            textField.inputView = datePicker
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if tfLeavetype.text == "" || tfStartDate.text == "" || tfEndDate.text == "" {
            btnSubmit.setTitleColor(UIColor.init(hexString: "#C7C7C7"), for: .normal)
            btnSubmit.isUserInteractionEnabled = false
        } else {
            btnSubmit.setTitleColor(UIColor.init(hexString: "#090742"), for: .normal)
            btnSubmit.isUserInteractionEnabled = true
        }
    }
}

extension RequestLeaveViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return leaveOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        leaveOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if leaveOptions[row] == "Other" {
            getAlert()
        } else {
            tfLeavetype.text = leaveOptions[row]
        }
    }
}
