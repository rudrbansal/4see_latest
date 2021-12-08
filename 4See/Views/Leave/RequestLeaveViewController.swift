//
//  RequestLeaveViewController.swift
//  4See
//
//  Created by Rudr Bansal on 07/12/21.
//

import UIKit

class RequestLeaveViewController: UIViewController {

    @IBOutlet weak var tfStartDate: UITextField!
    @IBOutlet weak var tfEndDate: UITextField!
    @IBOutlet weak var tfLeavetype: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var leavespickerView: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let leaveOptions = ["Annual", "Family responsibility", "Religious", "Other"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.minimumDate = Date()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnActionSubmit(_ sender: UIButton) {
        
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
            textField.inputView = datePicker
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
