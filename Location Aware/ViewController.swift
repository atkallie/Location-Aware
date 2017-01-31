//
//  ViewController.swift
//  Location Aware
//
//  Created by Ahmed T Khalil on 1/15/17.
//  Copyright © 2017 kalikans. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate{

    let locationManager = CLLocationManager()
    //labels to be updated
    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var courseLabel: UILabel!
    @IBOutlet var speedLabel: UILabel!
    @IBOutlet var altitudeLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var postalCodeLabel: UILabel!
    @IBOutlet var countryLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //the thing that is receiving location updates
        locationManager.delegate = self
        //select the desired accuracy level
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //can't do anything yet cause you still need user's permission! (include needed properties in info.plist)
        locationManager.requestWhenInUseAuthorization()
        //when/if you receive permission you can start updating the location
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[0]
        
        latitudeLabel.text = String(userLocation.coordinate.latitude)
        longitudeLabel.text = String(userLocation.coordinate.longitude)
        courseLabel.text = String(userLocation.course)
        speedLabel.text = String(userLocation.speed)
        altitudeLabel.text = String(userLocation.altitude)
        
        //to receive the nearest address you need to do a reverse geocode lookup as follows
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if error != nil{
                print(error as Any)
            }else{
                if let placemark = placemarks?[0]{
                    
                    //street number
                    var subThoroughfare = ""
                    if placemark.subThoroughfare != nil{
                        subThoroughfare = placemark.subThoroughfare!
                    }
                    
                    //street name
                    var thoroughfare = ""
                    if placemark.thoroughfare != nil{
                        thoroughfare = placemark.thoroughfare!
                    }
                    
                    //city
                    var locality = ""
                    if placemark.locality != nil{
                        locality = placemark.locality!
                    }
                    
                    //state
                    var administrativeArea = ""
                    if placemark.administrativeArea != nil{
                        administrativeArea = placemark.administrativeArea!
                    }
                    
                    //postal code
                    var postalCode = ""
                    if placemark.postalCode != nil{
                        postalCode = placemark.postalCode!
                    }
                    
                    //country
                    var country = ""
                    if placemark.country != nil{
                        country = placemark.country!
                    }
                    
                    self.addressLabel.text = subThoroughfare + " " + thoroughfare
                    self.cityLabel.text = locality + ", " + administrativeArea
                    self.postalCodeLabel.text = postalCode
                    self.countryLabel.text = country
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

