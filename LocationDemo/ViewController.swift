//
//  ViewController.swift
//  LocationDemo
//
//  Created by Mohamed Sobhi  Fouda on 6/21/18.
//  Copyright © 2018 Mohamed Sobhi Fouda. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    
    @IBAction func findLocation(_ sender: Any) {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: " + error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        CLGeocoder().reverseGeocodeLocation(manager.location!) { (placemarks, error) in
            if (error != nil) {
                print("Error: " + error!.localizedDescription)
                return
            }
            if placemarks!.count > 0 {
                let placemark = placemarks![0] as CLPlacemark
                self.displayLocationDetails(placemark: placemark, location: manager.location!)
            } else {
                print("Error retrieving data")
            }
        }
    }
    
    func displayLocationDetails(placemark: CLPlacemark, location: CLLocation) {
        locationManager.stopUpdatingLocation()
        print("Latitude: \(location.coordinate.latitude)")
        print("Longitude: \(location.coordinate.longitude)")
        print("Locality: \(placemark.locality!). Postal Code: \(placemark.postalCode!), Administrative Area: \(placemark.administrativeArea!), Country: \(placemark.country!)")
    }
    
}

