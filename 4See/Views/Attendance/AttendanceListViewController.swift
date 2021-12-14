//
//  AttendanceListViewController.swift
//  4See
//
//

import UIKit
import SideMenu
import CoreLocation

class AttendanceListViewController: BaseViewController {
    
    @IBOutlet weak var attendanceListTableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    private let locationManager = CLLocationManager()
    
    let vModel = attendanceViewModel()
    
    let attendanceOptions = ["Attendance", "Working from home", "Leave", "Running late", "Tools of trade", "Covid 19 protocol", "To do list"]
    let attendanceOptionsImages = ["Attendance", "WorkingFromHome", "Leave", "RunningLate", "ToolsOfTrade", "Covid19Protocol", "ToDoList"]
    
    var attendanceStatus = false
    var attendanceTitle = "Clocked In"
    
    var workFromHomeStatus = false
    var workFromHomeTitle = "Clocked In"
    
    var attendanceEnabled = true
    var homeEnabled = true
    var sickEnabled = true
    
    var locationStatus = false
    
    var current_latitude : CLLocationDegrees!
    var current_longitude : CLLocationDegrees!
    var company_lat : Double = 0.0
    var company_lng : Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attendanceListTableView.dataSource = self
        attendanceListTableView.delegate = self
        attendanceListTableView.reloadData()
        backButton.setTitle("", for: .normal)
        
        if CLLocationManager.locationServicesEnabled() {
            switch locationManager.authorizationStatus {
            case .notDetermined, .restricted, .denied:
                self.locationStatus = false
            case .authorizedAlways, .authorizedWhenInUse:
                if let geoLocaton = UserDefaults.standard.value(forKey: "geoLocaton") as? String, geoLocaton == "off" {
                    self.locationStatus = false
                } else {
                    if UserDefaults.standard.value(forKey: "geoLocaton") as? String != nil {
                        self.locationStatus = true
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
        
        initSideMenuView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.showProgressBar()
        getAttendanceListAPI()
    }
    
    func initSideMenuView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        SideMenuManager.default.leftMenuNavigationController = storyboard.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? SideMenuNavigationController
    }
    
    @IBAction func menuBtnAction(_ sender: Any) {
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension AttendanceListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attendanceOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttendanceListTableViewCell") as! AttendanceListTableViewCell
        cell.attendanceOptionLabel.text = attendanceOptions[indexPath.row]
        cell.iconImageView.image = UIImage.init(named: attendanceOptionsImages[indexPath.row])
        cell.attendanceBtn.setTitle("", for: .normal)
        cell.attendanceBtn.backgroundColor = .white
        cell.attendanceBtn.titleLabel?.textAlignment = .center
       
        if indexPath.row == 0 {
            if attendanceStatus {
                cell.attendanceBtn.setTitle(attendanceTitle, for: .normal)
                cell.attendanceBtn.backgroundColor = UIColor(hexString: "5BB224")
            }
        }
        
        if indexPath.row == 1 {
            if workFromHomeStatus {
                cell.attendanceBtn.setTitle(workFromHomeTitle, for: .normal)
                cell.attendanceBtn.backgroundColor = UIColor(hexString: "5BB224")
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
            
        case 0:
            if attendanceEnabled {
                attendanceAction()
            }

//            let storyboard = UIStoryboard(name: "Attendance", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "AttendanceViewController") as! AttendanceViewController
//            let objc = biometricsVC()
//            objc.type = "Attendance"
//            navigationController?.pushViewController(objc, completion: nil)
//            break
            
        case 1:
            if homeEnabled {
                self.wfhAction()
            }

//            let storyboard = UIStoryboard(name: "Attendance", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "WorkingFromHomeViewController") as! WorkingFromHomeViewController
//            let objc = biometricsVC()
//            objc.type = "Work From Home"
//            navigationController?.pushViewController(objc, completion: nil)
//            break
//
        case 2:
            self.sickAction()
        case 3:
            self.runningLateAction()
        case 4:
            let storyboard = UIStoryboard(name: "ToolsOfTrade", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ToolsOfTradeViewController") as! ToolsOfTradeViewController
            navigationController?.pushViewController(vc, completion: nil)

        case 5:
            
            let storyboard = UIStoryboard(name: "Attendance", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "CovidProtocolsViewController") as! CovidProtocolsViewController
            navigationController?.pushViewController(vc, completion: nil)
            break
            
        case 6:
            
            let storyboard = UIStoryboard(name: "ToDoList", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ToDoViewController") as! ToDoViewController
            navigationController?.pushViewController(vc, completion: nil)
            break

        default:
            break
        }
    }
    
    func runningLateAction() {
        if self.vModel.attendList.count != 0
        {
            if  self.vModel.attendList[self.vModel.attendList.count - 1].chekcIntype == "CheckOut" ||  self.vModel.attendList[self.vModel.attendList.count - 1].chekcIntype == "HomeCheckOut"{
                self.showToast("You are unable to access this feature as you checkout for the day.")
            }
            else if  self.vModel.attendList[0].chekcIntype == "CheckIn" || self.vModel.attendList[0].chekcIntype == "HomeCheckIn"
            {
                self.showToast("You are unable to access this feature during clocked in.")
            }
//            else if  self.vModel.attendList[0].chekcIntype == "HomeCheckIn"
//            {
//                self.showToast("You are unable to access this feature during clocked in.")
//            }
            else
            {
                let vc = runningLateVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        else
        {
            let vc = runningLateVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func attendanceAction()
    {
        if self.vModel.attendList.count == 0
        {
//            if !locationStatus {
//                showToast("Please turn on the GPS switch first before moving further.")
//            } else {
//                let objc = biometricsVC()
//                objc.type = "Attendance"
//                GlobalVariable.dismiss = "other"
//                self.navigationController?.pushViewController(objc)
//            }
        }
        else
        {
            if  self.vModel.attendList[self.vModel.attendList.count-1].chekcIntype == "CheckIn"
            {
                self.attendanceStatus = true
                self.workFromHomeStatus = false
                let objc = TimeTrackingVC()
                objc.type = "Attendance"
                self.navigationController?.pushViewController(objc)
                
            }
            else if  self.vModel.attendList[self.vModel.attendList.count-1].chekcIntype == "BreakIn"
            {
                self.attendanceStatus = true
                self.workFromHomeStatus = false
                let objc = TimeTrackingVC()
                objc.type = "Attendance"
                self.navigationController?.pushViewController(objc)
            }
            else if  self.vModel.attendList[self.vModel.attendList.count-1].chekcIntype == "HomeCheckIn"
            {
                self.attendanceStatus = false
                self.workFromHomeStatus = true
                
                self.showToast("You are unable to clocked in more than once in a day")
            }
            else if  self.vModel.attendList[self.vModel.attendList.count-1].chekcIntype == "HomeBreakIn"
            {
                self.attendanceStatus = false
                self.workFromHomeStatus = true
                self.showToast("You are unable to clocked in more than once in a day")
                
            }
            else if self.vModel.attendList[self.vModel.attendList.count-1].chekcIntype == "CheckOut"
            {
                self.attendanceStatus = false
                self.workFromHomeStatus = false
                self.homeEnabled = true
                self.attendanceEnabled = true
                
                self.showToast("You are unable to clocked in more than once in a day")
                
            }
            else if self.vModel.attendList[self.vModel.attendList.count-1].chekcIntype == "BreakOut"
            {
                self.attendanceStatus = true
                self.workFromHomeStatus = false
                self.homeEnabled = true
                self.attendanceEnabled = true
                let objc = TimeTrackingVC()
                objc.type = "Attendance"
                self.navigationController?.pushViewController(objc)
                
            }
            else if self.vModel.attendList[self.vModel.attendList.count-1].chekcIntype == "HomeCheckOut"
            {
                self.attendanceStatus = false
                self.workFromHomeStatus = false
                self.homeEnabled = true
                self.attendanceEnabled = true
                self.showToast("You are unable to clocked in more than once in a day")
                
            }
            else if self.vModel.attendList[self.vModel.attendList.count-1].chekcIntype == "HomeBreakOut"
            {
                self.attendanceStatus = false
                self.workFromHomeStatus = false
                self.homeEnabled = true
                self.attendanceEnabled = true
                self.showToast("You are unable to clocked in more than once in a day")
                
            }
            
        }
        
        attendanceListTableView.reloadData()
    }
    
    func wfhAction()
    {
        if self.vModel.attendList.count == 0
        {
            let objc = biometricsVC()
            objc.type = "Work From Home"
            GlobalVariable.dismiss = "other"
            self.navigationController?.pushViewController(objc)
        }
        else
        {
            if  self.vModel.attendList[self.vModel.attendList.count-1].chekcIntype == "CheckIn"
            {
                self.attendanceStatus = true
                self.workFromHomeStatus = false
                self.showToast("You are unable to clocked in more than once in a day")
                
                
            }
            else if  self.vModel.attendList[self.vModel.attendList.count-1].chekcIntype == "BreakIn"
            {
                self.attendanceStatus = true
                self.workFromHomeStatus = false
                self.showToast("You are unable to clocked in more than once in a day")
                
            }
            else if  self.vModel.attendList[self.vModel.attendList.count-1].chekcIntype == "HomeCheckIn"
            {
                self.attendanceStatus = false
                self.workFromHomeStatus = true
                let objc = TimeTrackingVC()
                objc.type = "Work From Home"
                self.navigationController?.pushViewController(objc)
                
            }
            else if  self.vModel.attendList[self.vModel.attendList.count-1].chekcIntype == "HomeBreakIn"
            {
                self.attendanceStatus = false
                self.workFromHomeStatus = true
                let objc = TimeTrackingVC()
                objc.type = "Work From Home"
                self.navigationController?.pushViewController(objc)
            }
            else if self.vModel.attendList[self.vModel.attendList.count-1].chekcIntype == "CheckOut"
            {
                self.attendanceStatus = false
                self.workFromHomeStatus = false
                self.homeEnabled = true
                self.attendanceEnabled = true
                
                self.showToast("You are unable to clocked in more than once in a day")
                
            }
            else if self.vModel.attendList[self.vModel.attendList.count-1].chekcIntype == "BreakOut"
            {
                self.attendanceStatus = false
                self.workFromHomeStatus = false
                self.homeEnabled = true
                self.attendanceEnabled = true
                self.showToast("You are unable to clocked in more than once in a day")
                
            }
            else if self.vModel.attendList[self.vModel.attendList.count-1].chekcIntype == "HomeCheckOut"
            {
                self.attendanceStatus = false
                self.workFromHomeStatus = false
                self.homeEnabled = true
                self.attendanceEnabled = true
                self.showToast("You are unable to clocked in more than once in a day")
                
            }
            else if self.vModel.attendList[self.vModel.attendList.count-1].chekcIntype == "HomeBreakOut"
            {
                self.attendanceStatus = false
                self.workFromHomeStatus = false
                self.homeEnabled = true
                self.attendanceEnabled = true
                let objc = TimeTrackingVC()
                objc.type = "Work From Home"
                self.navigationController?.pushViewController(objc)
            }
            
        }
        attendanceListTableView.reloadData()
    }
    
    func sickAction()
    {
        if self.vModel.attendList.count != 0
        {
            if  self.vModel.attendList[self.vModel.attendList.count - 1].chekcIntype == "HomeCheckOut"
            {
                let objc = sickViewController()
                self.navigationController?.pushViewController(objc)
                
            }
            else if  self.vModel.attendList[self.vModel.attendList.count - 1].chekcIntype == "CheckOut"
            {
                let objc = sickViewController()
                self.navigationController?.pushViewController(objc)
                
            }
            else
            {
                self.showToast("You are unable to access this feature during clocked in.")
                
            }
        }
        else
        {
            let storyboard = UIStoryboard(name: "Leave", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LeaveViewController") as! LeaveViewController
            navigationController?.pushViewController(vc, completion: nil)
        }
        
        attendanceListTableView.reloadData()
    }
    
    func clockAction()
    {
        let objc = TimeTrackingVC()
        self.navigationController?.pushViewController(objc)
        attendanceListTableView.reloadData()
    }
    
    func getAttendanceListAPI() {
        vModel.getAttendanceListAPI {(status,message)  in
            if status == true
            {
                self.hideProgressBar()
                if self.vModel.attendList.count != 0
                {
                    if  self.vModel.attendList[self.vModel.attendList.count-1].chekcIntype == "CheckIn"
                    {
                        self.attendanceStatus = true
                        self.workFromHomeStatus = false
                        self.attendanceTitle = "Clocked In"
                    }
                    else if  self.vModel.attendList[self.vModel.attendList.count-1].chekcIntype == "BreakIn"
                    {
                        self.attendanceStatus = true
                        self.workFromHomeStatus = false
                       
                    }else if  self.vModel.attendList[self.vModel.attendList.count-1].chekcIntype == "HomeCheckIn"{
                        self.attendanceStatus = false
                        self.workFromHomeStatus = true
                        }
                    else if  self.vModel.attendList[self.vModel.attendList.count-1].chekcIntype == "HomeBreakIn"{
                        self.attendanceStatus = false
                        self.workFromHomeStatus = true
                        }
                    else if self.vModel.attendList[self.vModel.attendList.count-1].chekcIntype == "CheckOut"
                    {
                        self.attendanceStatus = false
                        self.workFromHomeStatus = false
                        self.homeEnabled = true
                        self.attendanceEnabled = true
                        self.sickEnabled = true

                    }
                    else if self.vModel.attendList[self.vModel.attendList.count-1].chekcIntype == "BreakOut"
                    {
                        self.attendanceStatus = true
                        self.workFromHomeStatus = false
                        self.homeEnabled = true
                        self.attendanceEnabled = true

                    }
                    else if self.vModel.attendList[self.vModel.attendList.count-1].chekcIntype == "HomeCheckOut"
                    {
                        self.attendanceStatus = false
                        self.workFromHomeStatus = false
                        self.homeEnabled = true
                        self.attendanceEnabled = true

                    }
                    else if self.vModel.attendList[self.vModel.attendList.count-1].chekcIntype == "HomeBreakOut"
                    {
                        self.attendanceStatus = false
                        self.workFromHomeStatus = true
                        self.homeEnabled = true
                        self.attendanceEnabled = true

                    }
                }
                self.attendanceListTableView.reloadData()
            }
            else
            {
                self.hideProgressBar()
            }
        }
    }
}

class AttendanceListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var attendanceOptionLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var attendanceBtn: UIButton!
}

extension AttendanceListViewController : CLLocationManagerDelegate {
    
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
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
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
            attendanceEnabled = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if region is CLCircularRegion {
            self.showToast("You are exit from location.")
            attendanceEnabled = false
        }
    }
}
