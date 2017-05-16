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
import ZGTooltipView
import Toaster

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
        
        
        let datef = DateFormatter()
            datef.dateStyle = DateFormatter.Style.medium
            
           // date.timeStyle = DateFormatter.Style.medium
            
          //  date.text = datepicker.date.
        datepicker.isHidden = true
            
        
        }
        else if(datepicker.isHidden == true){
            
            datepicker.isHidden = false
            
           // datePickerView.datePickerMode = UIDatePickerMode.Date
            
           // sender.inputView = datePickerView
            
           // datePickerView.addTarget(self, action: #selector(ViewController.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
       // setTooltip(ZGTooltipView(direction: .Top, text: "Lorem ipsum dolor sit amet"))
            //datepicker.setTooltip(ZGTooltipView(direction: .top, text: "Lorem ipsum dolor sit amet"))
            datepicker.datePickerMode = UIDatePickerMode.date
           datepicker.addTarget(self, action: #selector(IssueViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
            
            
        }
    
        
    }
    
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
       // dateFormatter.timeStyle = DateFormatter.Style.medium
        
        date.text = dateFormatter.string(from: sender.date)
        
    }

    @IBOutlet weak var datepicker: UIDatePicker!


    @IBOutlet weak var category: MultiAutoCompleteTextField!

    //@IBOutlet weak var location: UILabel!
    @IBOutlet weak var desc: UITextField!
   

    @IBAction func issueclick(_ sender: Any) {
   
    
    let jsonobject2 = ("{"  + " " + "\"user_id\"" + ":" + "\"" + "vishwas@gmail.com" + "\"" + ","
                            + "\"description\"" + ":" + "\"" + self.desc.text! + "\"" + ","
                            + "\"images\"" + ":" + "\"" + "fvfvdsfvddddd" + "\"" + ","
                            + "\"category\"" + ":" + "\"" + self.category.text! + "\"" + ","
                            + "\"location\"" + ":" + "\"" + self.locationlabel.text! + "\"" + ","
                            + "\"date\"" + ":" + "\"" + self.date.text! + "\"" + ","
                            + "\"status\"" + ":" + "\"" + "Open" + "\""
        
                            + " " + "}")
        
    
        print(jsonobject2)
    var resp = senddata(jsonObject: jsonobject2)
        
        
    
    
    
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
    
    
    func senddata (jsonObject:String) -> String{
        
        // let jsonData = JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted, error: nil)
        
        //   print("calling senddata 2")
        
        
        
        
       // let url = NSURL(string: "http://ec2-52-21-74-14.compute-1.amazonaws.com:3000/api/addUser")!
       // let url2 = NSURL(string: "http://ec2-52-21-74-14.compute-1.amazonaws.com:3000/api/login")!
        var resstr = ""
        let url3 = NSURL(string: "http://ubuntu@ec2-54-153-112-71.us-west-1.compute.amazonaws.com:3000/api/users/addissue")!
        let request = NSMutableURLRequest(url: url3 as URL)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        
        
        //let string = "pass"
        
        request.httpBody = jsonObject.data(using: .utf8)
        //   print("calling senddata 3")
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            // Check for error
            if error != nil {
                //          print("error=\(error)")
                return
            }
            
            // Print out response string
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("calling senddata 6")
            print("responseString = \(responseString)")
            
            
            resstr = (responseString as? String)!
            print("res =\(resstr)")
            
            DispatchQueue.main.async {
                
            
            Toast(text: "Issue Created !!").show()
            
            
            
//            self.date.text = ""
//
//            self.category.text = ""
//            self.locationlabel.text = ""
//            self.desc.text = ""
            
            }
            
            
            let nc = NotificationCenter.default
            nc.post(name:Notification.Name(rawValue:"MyNotification"),
                    object: nil,
                    userInfo: ["message":resstr, "date":Date()])
            
            
            // return resstr
            // let obj = []
            
            do {
                
                
            } catch let error as NSError {
                //           print("Error Occurred")
                //           print(error.localizedDescription)
            }
            
        }
        
        task.resume()
        
        
        
        //if(resstr != ""){
        return resstr
        //}
        
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
