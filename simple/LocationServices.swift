//
//  LocationServices.swift
//  simple
//
//  Created by Mukund, Vishwas on 11/27/16.
//  Copyright © 2016 Mukund, Vishwas. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit


class LocationServices: NSObject, CLLocationManagerDelegate, MKMapViewDelegate {
    
   
    
    
    @objc(locationManager:didUpdateLocations:) func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        let lat = locValue.latitude
        let long = locValue.longitude
        var area:String = ""
        
        
        //reverse geocoding begin
        var location = CLLocation(latitude: lat, longitude: long)
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
        print(location)
            
            if error != nil {
                //   println("Reverse geocoder failed with error" + error.localizedDescription)
                return
            }
            
            if (placemarks?.count)! > 0 {
                let pm = placemarks?[0] as! CLPlacemark?
                // println(pm.locality)
                area = (pm!.locality)!
                
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
    
    
    
    
