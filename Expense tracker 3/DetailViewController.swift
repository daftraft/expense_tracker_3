//
//  DetailViewController.swift
//  Expense tracker 3
//
//  Created by Jamie Vick on 27/01/2017.
//  Copyright © 2017 Jamie Vick. All rights reserved.
//

import UIKit
import CoreLocation

class DetailViewController: UIViewController , CLLocationManagerDelegate{

    var locationManager: CLLocationManager!
    var loc: CLLocation!
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var expTextField: UITextField!
    @IBOutlet weak var expAmountField: UITextField!
    @IBOutlet weak var gpsLat: UILabel!
    @IBOutlet weak var gpsLong: UILabel!
    
    @IBAction func Down1(_ sender: Any) {
        adjustAmount(amountAdjust: -1)
    }
    @IBAction func Down10(_ sender: Any) {
        adjustAmount(amountAdjust: -10)
    }
    @IBAction func Down100(_ sender: Any) {
        adjustAmount(amountAdjust: -100)
    }
    @IBAction func Down1000(_ sender: Any) {
        adjustAmount(amountAdjust: -1000)
    }
    @IBAction func Up1(_ sender: Any) {
        adjustAmount(amountAdjust: 1)
    }
    @IBAction func Up10(_ sender: Any) {
        adjustAmount(amountAdjust: 10)
    }
    @IBAction func Up100(_ sender: Any) {
        adjustAmount(amountAdjust: 100)
    }
    @IBAction func Up1000(_ sender: Any) {
        adjustAmount(amountAdjust: 1000)
    }
    
    @IBAction func UpdateLocation(_ sender: Any) {
        locationManager.requestLocation()
        loc = locationManager.location
        gpsLat.text = loc.coordinate.latitude.description
        gpsLong.text = loc.coordinate.longitude.description
    }
    
    @IBAction func saveData(_ sender: Any) {
        debugPrint("In @IBAction func expTextAction")
        if let detail = self.detailItem {
            if let vexpTextField = self.expTextField
            {
                detail.expText! = vexpTextField.text!
            }
            if let vexpAmountField = self.expAmountField
            {
                if let amountDouble = Double(vexpAmountField.text!) {
                    detail.expAmount = amountDouble
                }
            }
            
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let vexpTextField = self.expTextField
            {
                vexpTextField.text = detail.expText!.description
            }
            if let vexpAmountField = self.expAmountField
            {
                debugPrint(detail.expAmount.description)
                vexpAmountField.text = detail.expAmount.description
            }
            
            // Get lat and long and display
            let locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            
        }
    }

    ////// LOCATION DELEGATE FUNCS //////
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    // do stuff

                    
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Code
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Code
    }
    
    ////// LOCATION DELEGATE FUNCS //////
    
    func adjustAmount(amountAdjust: Double) {
        if let vexpAmountField = self.expAmountField
        {
            if let amountDouble = Double(vexpAmountField.text!) {
                let newAmount = amountDouble + amountAdjust
                vexpAmountField.text = newAmount.description
            }
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
        ////////////// LOCATION FUNCTIONS //////////////
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        ////////////// LOCATION FUNCTIONS //////////////
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: ExpenseRecord? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }


}

