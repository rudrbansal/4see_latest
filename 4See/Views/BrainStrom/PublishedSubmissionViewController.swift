//
//  PublishedSubmissionViewController.swift
//  4See
//
//  Created by Rudr Bansal on 08/12/21.
//

import UIKit

class PublishedSubmissionViewController: UIViewController {

    @IBOutlet weak var btnBack: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        navigationController?.popViewController()
    }
    

}
