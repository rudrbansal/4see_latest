//
//  AddToolViewController.swift
//  4See
//
//  Created by Rudr Bansal on 08/12/21.
//

import UIKit
import SideMenu

class AddToolViewController: BaseViewController {
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var addToolCollectionView: UICollectionView!
    
    var tools : [UIImage] = [UIImage(named:"checkmark")!,UIImage(named:"notify_bell")!,UIImage(named:"Thanks")!,UIImage(named:"uncheck")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnBack.setTitle("", for: .normal)
        initSideMenuView()
    }
    
    @IBAction func btnActionBack() {
        navigationController?.popViewController()
    }
    
    func initSideMenuView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        SideMenuManager.default.leftMenuNavigationController = storyboard.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? SideMenuNavigationController
    }
    
    @IBAction func menuBtnAction(_ sender: Any) {
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
}

extension AddToolViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tools.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if tools.count - 1 == indexPath.row {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddToolPlusCollectionViewCell", for: indexPath) as! AddToolPlusCollectionViewCell
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addTollCollectionView", for: indexPath) as! AddToolCollectionViewCell
            cell.buttonHandler = {
                print("delete")
                self.tools.remove(at: indexPath.row)
            }
            cell.toolImageView.image = tools[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView.cellForItem(at: indexPath) as? AddToolPlusCollectionViewCell) != nil{
            print("Add")
            let imagePickerController = UIImagePickerController()
            imagePickerController.allowsEditing = true //If you want edit option set "true"
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.delegate = self
            present(imagePickerController, animated: true, completion: nil)
        }
        if (collectionView.cellForItem(at: indexPath) as? AddToolCollectionViewCell) != nil{
            print("normal")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
    }
    
    override func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        tools.append(tempImage)
        addToolCollectionView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    
    override func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
