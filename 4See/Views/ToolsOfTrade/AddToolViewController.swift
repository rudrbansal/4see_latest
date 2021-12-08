//
//  AddToolViewController.swift
//  4See
//
//  Created by Rudr Bansal on 08/12/21.
//

import UIKit

class AddToolViewController: UIViewController {

    @IBOutlet weak var btnBack: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnBack.setTitle("", for: .normal)
    }
    
    @IBAction func btnActionBack() {
        navigationController?.popViewController()
    }

}
