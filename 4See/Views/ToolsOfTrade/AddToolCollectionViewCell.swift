//
//  AddToolCollectionViewCell.swift
//  4See
//
//  Created by apple on 11/12/21.
//

import UIKit

class AddToolCollectionViewCell: UICollectionViewCell {
    
    var buttonHandler : (() -> ())?
    
    @IBOutlet weak var toolImageView: UIImageView!
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        buttonHandler!()
    }
    
}
