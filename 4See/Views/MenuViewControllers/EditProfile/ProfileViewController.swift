//
//  ProfileViewController.swift
//  4See
//
//  Created by Rudr Bansal on 07/12/21.
//

import UIKit
import CoreLocation

class ProfileViewController: BaseViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var gpsSwitch: UISwitch!
    @IBOutlet weak var funeralPlanLabel: UILabel!
    @IBOutlet weak var medicalAidLabel: UILabel!
    @IBOutlet weak var emergencyContactName: UILabel!
    @IBOutlet weak var emergencyContactNumber: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    private let locationManager = CLLocationManager()
    var current_latitude : CLLocationDegrees!
    var current_longitude : CLLocationDegrees!
    var company_lat : Double = 0.0
    var company_lng : Double = 0.0
    var homeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnBack.setTitle("", for: .normal)
        dataSetup()
        setupLocationManager()
    }
    
    func setupLocationManager() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateGPSButton), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        if CLLocationManager.locationServicesEnabled() {
            switch locationManager.authorizationStatus {
            case .notDetermined, .restricted, .denied:
                gpsSwitch.setOn(false, animated: true)
                self.updateUserProfile()
            case .authorizedAlways, .authorizedWhenInUse:
                if let geoLocaton = UserDefaults.standard.value(forKey: "geoLocaton") as? String, geoLocaton == "off" {
                    gpsSwitch.setOn(false, animated: true)
                    self.updateUserProfile()
                } else {
                    if UserDefaults.standard.value(forKey: "geoLocaton") as? String != nil {
                        gpsSwitch.setOn(true, animated: true)
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
    }
    
    @objc func updateGPSButton() {
        if CLLocationManager.locationServicesEnabled() {
            switch locationManager.authorizationStatus {
            case .notDetermined, .restricted, .denied:
                gpsSwitch.setOn(false, animated: true)
            case .authorizedAlways, .authorizedWhenInUse:
                gpsSwitch.setOn(true, animated: true)
                locationManager.delegate = self
                locationManager.requestAlwaysAuthorization()
                locationManager.startUpdatingLocation()
                locationManager.activityType = .automotiveNavigation
                locationManager.distanceFilter = kCLLocationAccuracyHundredMeters
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.startMonitoringSignificantLocationChanges()
            @unknown default:
                break
            }
        }
        updateUserProfile()
    }
    
    func checkLocationPermissions() {
        if CLLocationManager.locationServicesEnabled() {
            switch locationManager.authorizationStatus {
            case .notDetermined, .restricted, .denied:
                gpsSwitch.setOn(false, animated: true)
                self.openSettings()
            case .authorizedAlways, .authorizedWhenInUse:
                gpsSwitch.setOn(true, animated: true)
                locationManager.delegate = self
                locationManager.requestAlwaysAuthorization()
                locationManager.startUpdatingLocation()
                locationManager.activityType = .automotiveNavigation
                locationManager.distanceFilter = kCLLocationAccuracyHundredMeters
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.startMonitoringSignificantLocationChanges()
            @unknown default:
                break
            }
        }
        updateUserProfile()
    }
    
    func updateUserProfile() {
        homeViewModel.setValues(gpsSwitch.isOn)
        homeViewModel.updateProfileAPI()
    }
    
    func dataSetup() {
        Global.getDataFromUserDefaults(.userData)
        nameLabel.text = AppConfig.loggedInUser!.userInfo!.name!.firstCapitalized
        addressLabel.text = AppConfig.loggedInUser!.userInfo!.address
        phoneNumberLabel.text = AppConfig.loggedInUser!.userInfo!.phone
        emailLabel.text = AppConfig.loggedInUser!.userInfo!.email
        let img = UserDefaults.standard.value(forKey: "image") as! String
        profileImageView.setImageOnView(UrlConfig.IMAGE_URL+img.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
//        logoImg.setImageOnView(UrlConfig.IMAGE_URL+AppConfig.loggedInUser!.userInfo!.companyId!.image!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
    }

    func openSettings() {
        let alert = UIAlertController(title: "Setting", message: "GPS access is restricted. In order to use tracking, please enable GPS in the Settings app under Privacy, Location Services.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Go to Settings now", style: .default, handler: { (alert: UIAlertAction!) in
            if URL(string: UIApplication.openSettingsURLString) != nil {
                // If general location settings are enabled then open location settings for the app
                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnActionEdit(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
        navigationController?.pushViewController(vc, completion: nil)
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        navigationController?.popViewController()
    }
}

extension ProfileViewController : CLLocationManagerDelegate {
    
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
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if region is CLCircularRegion {
            self.showToast("You are exit from location.")
        }
    }
}
