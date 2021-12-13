//
//  AddListViewController.swift
//  4See
//
//  Created by Rudr Bansal on 07/12/21.
//

import UIKit
import SideMenu

class AddListViewController: UIViewController {
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnBack.setTitle("", for: .normal)
        initSideMenuView()
    }
    
    func initSideMenuView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        SideMenuManager.default.leftMenuNavigationController = storyboard.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? SideMenuNavigationController
    }
    
    @IBAction func menuBtnAction(_ sender: Any) {
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
    
    @IBAction func btnActionBack(_ sener: UIButton) {
        navigationController?.popViewController()
    }
}

extension AddListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddListCollectionViewCell", for: indexPath) as! AddListCollectionViewCell
        return cell
    }
}

class AddListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var taskImageView: UIImageView!
}
