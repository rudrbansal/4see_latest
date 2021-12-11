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
import GoogleMaps

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var headerImageCollectionView: UICollectionView!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var brainstormBtn: UIButton!
    @IBOutlet weak var surveyBtn: UIButton!
    @IBOutlet weak var socialSpaceBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let viewModel = announcementViewModel()
    let vModel = attendanceViewModel()
    private let locationManager = CLLocationManager()
    var marker : GMSMarker!
    var map_view: GMSMapView!
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
        
        getAnnouncementsData()
        initSideMenuView()
        dataSetup()
        
        NotificationCenter.default.addObserver(self, selector : #selector(handleNotification(n:)), name : Notification.Name("notificationData"), object : nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateGPSButton), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        if CLLocationManager.locationServicesEnabled() {
            switch locationManager.authorizationStatus {
            case .notDetermined, .restricted, .denied:
//                gpsSwitch.setOn(false, animated: true)
//                self.switchLbl.text = "GPS location is switched off"
                self.updateUserProfile()
            case .authorizedAlways, .authorizedWhenInUse:
                if let geoLocaton = UserDefaults.standard.value(forKey: "geoLocaton") as? String, geoLocaton == "off" {
//                    gpsSwitch.setOn(false, animated: true)
//                    self.switchLbl.text = "GPS location is switched off"
                    self.updateUserProfile()
                } else {
                    if UserDefaults.standard.value(forKey: "geoLocaton") as? String != nil {
//                        gpsSwitch.setOn(true, animated: true)
//                        self.switchLbl.text = "GPS location is switched on"
                        locationManager.delegate = self
                        locationManager.requestAlwaysAuthorization()
                        locationManager.startUpdatingLocation()
                        locationManager.activityType = .automotiveNavigation
                        locationManager.distanceFilter = kCLLocationAccuracyHundredMeters
                        locationManager.desiredAccuracy = kCLLocationAccuracyBest
                        locationManager.startMonitoringSignificantLocationChanges()
                    }
                }
            @unknown default:
                break
            }
        }
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
    
    @objc func updateGPSButton() {
        if CLLocationManager.locationServicesEnabled() {
//            switch locationManager.authorizationStatus {
////            case .notDetermined, .restricted, .denied:
////                gpsSwitch.setOn(false, animated: true)
////                self.switchLbl.text = "GPS location is switched off"
//            case .authorizedAlways, .authorizedWhenInUse:
////                gpsSwitch.setOn(true, animated: true)
////                self.switchLbl.text = "GPS location is switched on"
//                locationManager.delegate = self
//                locationManager.requestAlwaysAuthorization()
//                locationManager.startUpdatingLocation()
//                locationManager.activityType = .automotiveNavigation
//                locationManager.distanceFilter = kCLLocationAccuracyHundredMeters
//                locationManager.desiredAccuracy = kCLLocationAccuracyBest
//                locationManager.startMonitoringSignificantLocationChanges()
//            @unknown default:
//                break
//            }
        }
        updateUserProfile()
    }
    
    func checkLocationPermissions() {
        if CLLocationManager.locationServicesEnabled() {
//            switch locationManager.authorizationStatus {
//            case .notDetermined, .restricted, .denied:
//                gpsSwitch.setOn(false, animated: true)
//                self.switchLbl.text = "GPS location is switched off"
//                self.openSettings()
//            case .authorizedAlways, .authorizedWhenInUse:
//                gpsSwitch.setOn(true, animated: true)
//                self.switchLbl.text = "GPS location is switched on"
//                locationManager.delegate = self
//                locationManager.requestAlwaysAuthorization()
//                locationManager.startUpdatingLocation()
//                locationManager.activityType = .automotiveNavigation
//                locationManager.distanceFilter = kCLLocationAccuracyHundredMeters
//                locationManager.desiredAccuracy = kCLLocationAccuracyBest
//                locationManager.startMonitoringSignificantLocationChanges()
//            @unknown default:
//                break
//            }
        }
        updateUserProfile()
    }
    //MARK:- SideMenu Function
    
    func initSideMenuView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        SideMenuManager.default.leftMenuNavigationController = storyboard.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? SideMenuNavigationController
    }
    
    func dataSetup() {
        Global.getDataFromUserDefaults(.userData)
//        nameLbl.text = "Welcome \(AppConfig.loggedInUser!.userInfo!.name!.firstCapitalized)"
//        jobLbl.text = UserDefaults.standard.value(forKey: "jobTitle") as! String + " - " + AppConfig.loggedInUser!.userInfo!.department!
//        let img = UserDefaults.standard.value(forKey: "image") as! String
//        print(UrlConfig.IMAGE_URL+(img as! String))
//        imgVW.setImageOnView(UrlConfig.IMAGE_URL+img.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
//        logoImg.setImageOnView(UrlConfig.IMAGE_URL+AppConfig.loggedInUser!.userInfo!.companyId!.image!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
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
    
    func openSettings() {
//        if (sender.isOn == true){
//            print("on")
//            gpsSwitch.setOn(true, animated: true)
//            switchLbl.text = "GPS location is switched on"
//            CLLocationManager.locationServicesEnabled()
        let alert = UIAlertController(title: "Setting", message: "GPS access is restricted. In order to use tracking, please enable GPS in the Settings app under Privacy, Location Services.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Go to Settings now", style: .default, handler: { (alert: UIAlertAction!) in
            if URL(string: UIApplication.openSettingsURLString) != nil {
                // If general location settings are enabled then open location settings for the app
                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            }
            // }

        }))

        self.present(alert, animated: true, completion: nil)
//        }
//        else{
//            print("off")
//            switchLbl.text = "GPS location is switched off"
//            statusDeniedAlert()
//            gpsSwitch.setOn(false, animated: true)
//
//        }
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

extension HomeViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.authorizedAlways) {
            //App Authorized, stablish geofence
            locationManager.delegate = self
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            locationManager.activityType = .automotiveNavigation
            locationManager.distanceFilter = kCLLocationAccuracyHundredMeters
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startMonitoringSignificantLocationChanges()
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation:CLLocation = locations[0] as CLLocation
        locationManager.stopUpdatingLocation()
        
        current_latitude = userLocation.coordinate.latitude
        current_longitude = userLocation.coordinate.longitude
        let location = CLLocation.init(latitude: current_latitude, longitude: current_longitude)
        
        if AppConfig.loggedInUser!.userInfo!.companyId!.location!.lat == nil && AppConfig.loggedInUser!.userInfo!.companyId!.location!.lng == nil {
            company_lat = 30.639950
            company_lng = 76.814510
        } else {
            company_lat = (AppConfig.loggedInUser!.userInfo!.companyId!.location!.lat! as NSString).doubleValue
            company_lng = (AppConfig.loggedInUser!.userInfo!.companyId!.location!.lng! as NSString).doubleValue
        }
        
        let officeLocation = CLLocation.init(latitude: company_lat, longitude: company_lng)
        
        let geoFenceCenter = CLLocationCoordinate2DMake(company_lat,company_lng)
        let geofenceRegion = CLCircularRegion.init(center: geoFenceCenter, radius: min(100.0, locationManager.maximumRegionMonitoringDistance), identifier: "region")
        geofenceRegion.notifyOnExit = true
        geofenceRegion.notifyOnEntry = true
        locationManager.startMonitoring(for: geofenceRegion)
        print(location.distance(from: officeLocation))
        print(geofenceRegion.radius)
        print(location)
        print(officeLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("Started Monitoring Region: \(region.identifier)")
        manager.requestState(for: region)
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if region is CLCircularRegion {
            self.showToast("You are enter in location.")
//            workBtn.isUserInteractionEnabled = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if region is CLCircularRegion {
            self.showToast("You are exit from location.")
//            workBtn.isUserInteractionEnabled = false
        }
    }
}

extension HomeViewController {

    func updateUserProfile() {
//        homeViewModel.setValues(gpsSwitch.isOn)
        homeViewModel.updateProfileAPI()
    }
    
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {

        pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
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
