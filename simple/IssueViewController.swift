//
//  IssueViewController.swift
//  simple
//
//  Created by Vishwas Mukund on 4/18/17.
//  Copyright © 2017 Mukund, Vishwas. All rights reserved.
//

import Foundation
import CoreLocation
import MultiAutoCompleteTextSwift

class IssueViewController : UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var labelloc: UITextField!
    
    var locationManager: CLLocationManager = CLLocationManager()
    var startLocation: CLLocation!
    var areaname:String = ""

    //@IBOutlet weak var locationlabel: MultiAutoCompleteTextField!
    @IBOutlet weak var locationlabel: MultiAutoCompleteTextField!
    @IBAction func datePickerLauncher(_ sender: Any) {
    
        if(datepicker.isHidden == false){
        
        date.text = datepicker.date.description
        datepicker.isHidden = true
        
        }
        else if(datepicker.isHidden == true){
            
            datepicker.isHidden = false
            
        }
    
        
    }

    @IBOutlet weak var datepicker: UIDatePicker!


    @IBOutlet weak var category: MultiAutoCompleteTextField!

    //@IBOutlet weak var location: UILabel!
    @IBOutlet weak var desc: UITextField!
   

    @IBAction func issueclick(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let locations = [ "San Jose", "San Franciso", "Santa Clara", "Mountain View", "Palo Alto", "Sunnyvale"]
        
        let categories = [ "Safety", "Unemployment", "Housing", "Crime", "Traffic", "Public Works"]
        locationlabel.autoCompleteStrings = locations;
        category.autoCompleteStrings = categories
//        let comparableWords = [
//            MultiAutoCompleteToken(top: "C++", subTexts: "cplusplus", "cplapla"),
//            MultiAutoCompleteToken(top: "Ocjective-C", subTexts: "objectivec"),
//            MultiAutoCompleteToken("C")
//        ]
//        comparableWords.forEach {
//            locationlabel.autoCompleteTokens.append($0)
//        }
        
        locationlabel.onSelect = {[weak self] str, indexPath in
            //self?.labelloc.text = "Selected word: \(str)"
        }
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
       // var date = getDate()
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.delegate = self
//        
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//        
//        
//        //   print("area \(areaname)")
//        locationManager.stopUpdatingLocation()
        
        //Facebook Login implmentation
        
        //let loginButton = LoginButton(readPermissions: [ .publicProfile, .email, .userFriends ])
        
        //loginButton.center = view.center
        
        // view.addSubview(loginButton)
        
        
    }
    
    
    @objc(locationManager:didUpdateLocations:) func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        let lat = locValue.latitude
        let long = locValue.longitude
        var area:String = ""
        
        
        //reverse geocoding begin
        var location = CLLocation(latitude: lat, longitude: long)
        //print(location)
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            
            
            if error != nil {
                //   println("Reverse geocoder failed with error" + error.localizedDescription)
                return
            }
            
            if (placemarks?.count)! > 0 {
                let pm = placemarks?[0] as! CLPlacemark?
                // println(pm.locality)
                area = (pm!.locality)!
                
                
                self.areaname = area
                DispatchQueue.main.async{
                self.locationlabel.text = self.areaname
                //       print(sender: self.areaname)
                }
            }
            else {
                // println("Problem with the data received from geocoder")
            }
        })
        
        //reverse geocoding end
        
        
        
        
        
        
        let currentlocation = CLLocationCoordinate2DMake(lat, long)
        
        
        
        //locationManager.stopUpdatingLocation()
        
        
        
        
        
    }
    
    
    
}
