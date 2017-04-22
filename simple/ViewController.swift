//
//  ViewController.swift
//  simple
//
//  Created by Mukund, Vishwas on 11/27/16.
//  Copyright © 2016 Mukund, Vishwas. All rights reserved.
//

import UIKit
import CoreLocation
import Foundation
//import FacebookLogin
import ILPDFKit



class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager = CLLocationManager()
    var startLocation: CLLocation!
    var areaname:String = ""
    
    
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var bday: UITextField!
    @IBOutlet var fullName: UITextField!
    
    //LOGIN Outlets
    @IBOutlet var username: UITextField!
    @IBOutlet var pwd: UITextField!
    @IBOutlet var output2: UILabel!
    
    @IBOutlet var output: UILabel!
    @IBAction func loginPage(_ sender: Any) {
        
        self.performSegue(withIdentifier: "loginpage", sender: nil)
        
        
        
    }
    @IBAction func signupPage(_ sender: Any) {
        
        self.performSegue(withIdentifier: "signuppage", sender: nil)
        
        
    }
    @IBAction func backLogin(_ sender: Any) {
        
        self.performSegue(withIdentifier: "loginBack", sender: nil)
        
    }
    @IBAction func onclicklogin(_ sender: Any) {
        
        output2.text = "Login successful"
        output2.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        let jsonObject = ["emailID":username.text!,"password" :pwd.text! as! AnyObject] as [String : Any]
        var resp = sendlogindata(jsonObject: jsonObject.description)
        print("resp on login \(resp)")
        
        self.performSegue(withIdentifier: "loginmenu", sender: nil)
        
        
        
    }
    
    @IBAction func backSignup(_ sender: Any) {
        
        self.performSegue(withIdentifier: "signupBack", sender: nil)
        
        
    }
    
    
    @IBAction func oc(_ sender: Any) {
        
        if((fullName.text != nil)||(email.text != nil)||(password.text != nil)||bday.text != nil){
            
            let jsonObject = ["fullName":fullName.text!,"email":email.text!,"password" :password.text! as! AnyObject] as [String : Any]
            
            let jsonObject2 = ["emailId":"foo","password":"foo"]
            print("calling senddata")
            var resp = senddata(jsonObject: jsonObject.description)
            
            
            let nc = NotificationCenter.default // Note that default is now a property, not a method call
            nc.addObserver(forName:Notification.Name(rawValue:"MyNotification"),
                           object:nil, queue:nil,
                           using:catchNotification)
            
            
            
            
            if(resp != ""){
            print("s=\(resp)")
            }
            
           // output.text = "Incorrect Username/ Password, please try again"
           // output.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            //sleep(2)
            
            //output.isHidden = true
           // self.performSegue(withIdentifier: "signupmenu", sender: nil)
            
        }
        
    }
    
    func catchNotification(notification:Notification) -> Void {
        print("Catch notification")
        
        guard let userInfo = notification.userInfo,
            let message  = userInfo["message"] as? String,
            let date     = userInfo["date"]    as? Date else {
                print("No userInfo found in notification")
                return
        }
        
        
                                     print("\(message) received at \(date)")
        
        if(message != ""){
        
            DispatchQueue.main.async{
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "menu")
                self.present(controller, animated: true, completion: nil)
                
            }
            
        
        }
//            preferredStyle: UIAlertControllerStyle.alert)
//        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
       // self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    @IBAction func logout(_ sender: Any) {
        
        self.performSegue(withIdentifier: "logout", sender: nil)
    }
    
    @IBAction func issuebutton(_ sender: Any) {
        self.performSegue(withIdentifier: "issues", sender: nil)
    }
    
    @IBAction func chatbutton(_ sender: Any) {
    }
    
    @IBAction func issueback(_ sender: Any) {
        
        self.performSegue(withIdentifier: "issueback", sender: nil)
    }
    
    @IBAction func chatButton(_ sender: Any) {
        
        
        self.performSegue(withIdentifier: "chatButton", sender: nil)
        
        
    }
    
    @IBOutlet var locationlabel: UILabel!
    var pdfVC : ILPDFViewController? = nil
    
    // self.present(controller, animated: true, completion: nil)
    
    
    
    //    @IBAction func pdf(_ sender: Any) {
    //
    //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //        let controller = storyboard.instantiateViewController(withIdentifier: "ncc")
    //
    //        let storyboard2 = UIStoryboard(name: "Main", bundle: nil)
    //        let controller2 = storyboard.instantiateViewController(withIdentifier: "rty")
    //
    //        pdfVC = (controller as? UINavigationController)?.viewControllers.first as? ILPDFViewController
    //        let document = ILPDFDocument(resource:"testA")
    //        pdfVC?.document = document
    //        let printButton = UIBarButtonItem(title: "Save Static PDF", style: .plain, target: self, action: #selector(print))
    //        pdfVC?.navigationItem.setRightBarButton(printButton, animated: false)
    //
    //      self.present(controller, animated: true, completion: nil)
    //
    //
    //
    //    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        var date = getDate()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        //   print("area \(areaname)")
        locationManager.stopUpdatingLocation()
        
        //Facebook Login implmentation
        
        //let loginButton = LoginButton(readPermissions: [ .publicProfile, .email, .userFriends ])
        
        //loginButton.center = view.center
        
        // view.addSubview(loginButton)
        
        
    }
    
    //    @objc func print(sender:AnyObject?) {
    //        let data = pdfVC?.document?.savedStaticPDFData()
    //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //        let controller = storyboard.instantiateViewController(withIdentifier: "ncc")
    //
    //        let savedVCDocument = ILPDFDocument(data: data!)
    //
    //        let alert = UIAlertController(title: "Will Save PDF", message: "The PDF file displayed next is a static version of the previous file, but with the form values added. The starting PDF has not been modified and this static pdf no longer contains forms.", preferredStyle: .alert)
    //
    //        let action = UIAlertAction(title: "Show Saved Static PDF", style: .default) { _ in
    //            alert.dismiss(animated: true, completion: nil)
    //            self.pdfVC?.document = savedVCDocument
    //            self.pdfVC?.navigationItem.setRightBarButton(nil, animated: false)
    //        }
    //
    //        alert.addAction(action)
    //        controller.present(alert, animated: true, completion: nil)
    //    }
    
    
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
                self.locationlabel.text = self.areaname
                //       print(sender: self.areaname)
                
            }
            else {
                // println("Problem with the data received from geocoder")
            }
        })
        
        //reverse geocoding end
        
        
        
        
        
        
        let currentlocation = CLLocationCoordinate2DMake(lat, long)
        
        
        
        //locationManager.stopUpdatingLocation()
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getDate () -> String{
        
        var date = NSDate()
        let string2 = NSDate().description
        let dateFormatter = DateFormatter()
        let string = dateFormatter.string(from: date as Date)
        //   print("string\(string2)")
        return string2
        
    }
    
    func senddata (jsonObject:String) -> String{
        
        // let jsonData = JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted, error: nil)
        
        //   print("calling senddata 2")
        
        
        
        
        let url = NSURL(string: "http://ec2-52-21-74-14.compute-1.amazonaws.com:3000/api/addUser")!
        let url2 = NSURL(string: "http://ec2-52-21-74-14.compute-1.amazonaws.com:3000/api/login")!
        var resstr = ""
        let url3 = NSURL(string: "http://ubuntu@ec2-54-153-112-71.us-west-1.compute.amazonaws.com:3000/api/addUser")!
        let request = NSMutableURLRequest(url: url3 as URL)
        request.httpMethod = "POST"
        
        
        
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
            print("calling senddata 4")
            print("responseString = \(responseString)")
            
            
            resstr = (responseString as? String)!
            print("res =\(resstr)")
            
            
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
        return "hello"
        //}
        
    }
    
    
    
    func sendlogindata (jsonObject:String) -> String{
        
        // let jsonData = JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted, error: nil)
        
        //   print("calling senddata 2")
        
        
        
        
        let url = NSURL(string: "http://ec2-52-21-74-14.compute-1.amazonaws.com:3000/api/addUser")!
        let loginurl = NSURL(string: "http://ubuntu@ec2-54-153-112-71.us-west-1.compute.amazonaws.com:3000/api/login")!
        var resstr = ""
        let url3 = NSURL(string: "http://ubuntu@ec2-54-153-112-71.us-west-1.compute.amazonaws.com:3000/api/addUser")!
        let request = NSMutableURLRequest(url: loginurl as URL)
        request.httpMethod = "POST"
        
        
        
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
            print("calling senddata 4")
            print("responseString = \(responseString)")
            
            
            resstr = (responseString as? String)!
            print("res =\(resstr)")
            
            
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
        return "hello"
        //}
        
    }
    
    
    
}
