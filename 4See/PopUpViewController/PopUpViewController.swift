//
//  PopUpViewController.swift
//  4See
//
//  Created by Rudr Bansal on 12/12/21.
//

import UIKit

class PopUpViewController: BaseViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    
    var popUpTitle = ""
    var message = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        btnBack.setTitle("", for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lblTitle.text = popUpTitle
        lblMessage.text = message
    }
    
    @IBAction func crossBtnAction(_ sender: Any) {
        dismiss(animated: false)
    }
    
}
