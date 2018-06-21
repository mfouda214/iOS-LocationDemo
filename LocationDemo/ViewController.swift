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
        
        let Latitude = view.viewWithTag(1) as! UILabel
        let Longitude = view.viewWithTag(2) as! UILabel
        let Locality = view.viewWithTag(3) as! UILabel
        let GeoCode = view.viewWithTag(4) as! UILabel
        
        Latitude.isHidden = false
        Longitude.isHidden = false
        Locality.isHidden = false
        GeoCode.isHidden = false
        
        Latitude.text = "Latitude: \(location.coordinate.latitude)"
        Longitude.text = "Longitude: \(location.coordinate.longitude)"
        Locality.text = "Locality: \(placemark.locality!). \nPostal Code: \(placemark.postalCode!), \nAdministrative Area: \(placemark.administrativeArea!), \nCountry: \(placemark.country!)"
        GeoCode.text = "GeoCode: \(location)"
        
     }
    
}

