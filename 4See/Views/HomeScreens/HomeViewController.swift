//
//  HomeViewController.swift
//  4See
//
//  Created by Gagan Arora on 03/03/21.
//

import UIKit
import SideMenu
import MarqueeLabel
import WebKit
import CoreLocation
//import GoogleMaps
//import UPCarouselFlowLayout

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var headerImageCollectionView: UICollectionView!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var brainstormBtn: UIButton!
    @IBOutlet weak var surveyBtn: UIButton!
    @IBOutlet weak var socialSpaceBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var profileImageView: UIImageView!
    
    let viewModel = announcementViewModel()
    let vModel = attendanceViewModel()
    private let locationManager = CLLocationManager()
//    var marker : GMSMarker!
//    var map_view: GMSMapView!
    var current_latitude : CLLocationDegrees!
    var current_longitude : CLLocationDegrees!
    var company_lat : Double = 0.0
    var company_lng : Double = 0.0
    var homeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationBtn.setTitle("", for: .normal)
        profileBtn.setTitle("", for: .normal)
        brainstormBtn.setTitle("", for: .normal)
        surveyBtn.setTitle("", for: .normal)
        socialSpaceBtn.setTitle("", for: .normal)
        
//        let layout = UPCarouselFlowLayout()
//        layout.itemSize = CGSize(width: headerImageCollectionView.frame.width - 60, height: headerImageCollectionView.frame.height)
//        layout.scrollDirection = .horizontal
//        layout.sideItemAlpha = 0.4
//        layout.sideItemScale = 0.6
//        layout.sideItemShift = 0
//        headerImageCollectionView.collectionViewLayout = layout
        
        getAnnouncementsData()
        initSideMenuView()
        dataSetup()
        
        NotificationCenter.default.addObserver(self, selector : #selector(handleNotification(n:)), name : Notification.Name("notificationData"), object : nil)
                
        headerImageCollectionView.dataSource = self
        headerImageCollectionView.delegate = self
        headerImageCollectionView.reloadData()
    }
    
    @objc func handleNotification(n : NSNotification) {
        let objc = messageVC()
        self.navigationController?.pushViewController(objc)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        dataSetup()
//        getAttendanceListAPI()
    }
    
    //MARK:- SideMenu Function
    
    func initSideMenuView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        SideMenuManager.default.leftMenuNavigationController = storyboard.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? SideMenuNavigationController
    }
    
    func dataSetup() {
        Global.getDataFromUserDefaults(.userData)
        let img = UserDefaults.standard.value(forKey: "image") as! String
        profileImageView.setImageOnView(UrlConfig.IMAGE_URL+img.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
    }
    
    //MARK:- IBActions()
    @IBAction func menuBtnAction(_ sender: Any) {
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
    
    @IBAction func btnActionProfile(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        navigationController?.pushViewController(vc, completion: nil)

    }
    
    @IBAction func btnActionNotifications(_ sender: UIButton) {
        
    }
    
    @IBAction func btnActionBrainstorm(_ sender: UIButton) {
        
    }
    
    @IBAction func btnActionSurveys(_ sender: UIButton) {
        
    }
    
    @IBAction func btnActionSocialSpace(_ sender: UIButton) {
        
    }
}
extension HomeViewController {
    
    func getAnnouncementsData() {
        viewModel.getAnnouncementsAPI { (status, message) in
            if status == true
            {
                let font = UIFont.init(name: "Roboto-Medium", size: 18)
                if self.viewModel.announcementsList?.data.count != 0
                {
                    let arr  = self.viewModel.announcementsList!.data[0].createdAt?.components(separatedBy: "T")
                    print(arr)
//                    self.marqueWebVW.loadHTMLString("<html><body><marquee style='font-family:Roboto;color:white;padding:30px 30px 20px 30px;font-size:44px;'>\(arr![0]) \(String(describing: self.viewModel.announcementsList!.data[0].title!))</marquee></body></html>", baseURL: nil)
                }
                else
                {
//                    self.marqueWebVW.loadHTMLString("<html><body><marquee style='font-family:\(font!.familyName);color:white;padding:30px 30px 20px 30px;font-size:44px;'> No annoucement found.</marquee></body></html>", baseURL: nil)
                }
            }
            else
            {
                self.showToast(message)
                if message == "User is logged in from another device."
                {
                    UserDefaults.standard.set(false, forKey: "USERISLOGIN")
                    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                    let initialVC = storyboard.instantiateInitialViewController()
                    UIApplication.shared.windows.first?.rootViewController = initialVC
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                }

            }
        }
    }
}

extension HomeViewController {

    func updateUserProfile() {
//        homeViewModel.setValues(gpsSwitch.isOn)
        homeViewModel.updateProfileAPI()
    }
    
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let fractionalPage = scrollView.contentOffset.x / pageWidth
        let page = lround(Double(fractionalPage))
        self.pageControl.currentPage = page
    }
}

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var headerImageView: UIImageView!
//    @IBOutlet weak var : !
//    @IBOutlet weak var : !
//    @IBOutlet weak var : !
//    @IBOutlet weak var : !
//    @IBOutlet weak var : !
}
