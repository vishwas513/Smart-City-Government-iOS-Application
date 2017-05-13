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
//import ILPDFKit
import ZGTooltipView



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
    //    let jsonObject = [""emailId":username.text!,"password" :pwd.text! as! AnyObject] as [String : Any]
        
        let jsonobject2 = ("{"  + " " + "\"emailId\"" + ":" + "\"" + self.username.text! + "\"" + "," + "\"password\"" + ":" + "\"" + self.pwd.text! + "\"" + " " + "}")
        print(jsonobject2)
    //    let jsonobject2 = ['{' + ' ' + '"' 'emailId' + ':' + self.username.text!,'password' + ':' + self.pwd.text! + ' ' + '}']
        
        //let js = [{"emailId" : "vishwas@gmail.com","password" : "vishwas"} ]as JSONSerialization
        
      //  print(jsonobject2.description)
      var resp = sendlogindata(jsonObject: jsonobject2)
    //    print("resp on login \(resp)")
        
       // self.performSegue(withIdentifier: "loginmenu", sender: nil)
        
        let nc = NotificationCenter.default // Note that default is now a property, not a method call
        nc.addObserver(forName:Notification.Name(rawValue:"MyNotification2"),
                       object:nil, queue:nil,
                       using:catchNotification2)
        
        
    }
    
    @IBAction func backSignup(_ sender: Any) {
        
        self.performSegue(withIdentifier: "signupBack", sender: nil)
        
        
    }
    
    
    @IBAction func oc(_ sender: Any) {
        
        if((fullName.text != nil)||(email.text != nil)||(password.text != nil)||bday.text != nil){
            
            let jsonObject = ["fullName":fullName.text!,"email":email.text!,"password" :password.text! as! AnyObject] as [String : Any]

         //   let jsonobject2 = {["fullName":self.fullName.text!,"email":self.email.text! + "," + "password" :self.password.text!]}
           let js2 = ("{"  + " " + "\"fullName\"" + ":" + "\"" + self.fullName.text! + "\"" + "," + "\"emailId\"" + ":" + "\"" + self.email.text! + "\"" + "," + "\"password\"" + ":" + "\"" + self.password.text! + "\"" + " " + "}")

            
            
            
            //let jsonObject2 = ["emailId":"foo","password":"foo"]
            print("calling senddata")
            print(js2)
            let resp = senddata(jsonObject: js2)
            
            
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
    
    
    func catchNotification2(notification:Notification) -> Void {
        print("Catch notification")
        
        guard let userInfo = notification.userInfo,
            let message  = userInfo["message"] as? String,
            let date     = userInfo["date"]    as? Date else {
                print("No userInfo found in notification")
                return
        }
        
        
        print("\(message) received at \(date)")
        
        if(message != "error"){
            
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
   // var pdfVC : ILPDFViewController? = nil
    
    
    
    @IBOutlet weak var loginbutton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //texfield.secureTextEntry = true
        var date = getDate()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        //loginbutton.setTooltip(ZGTooltipView(direction: .top, text: "Lorem ipsum dolor sit amet"))
        
       // email.setTooltip(ZGTooltipView(direction: .top, text: "Lorem ipsum dolor sit amet"))
        //password.setTooltip(ZGTooltipView(direction: .top, text: "Lorem ipsum dolor sit amet"))
        //fullName.setTooltip(ZGTooltipView(direction: .top, text: "Lorem ipsum dolor sit amet"))
        
        
        
        //   print("area \(areaname)")
        locationManager.stopUpdatingLocation()
        
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
        return resstr
        //}
        
    }
    
    
    
    func sendlogindata (jsonObject:String) -> String{
        
        // let jsonData = JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted, error: nil)
        
        //   print("calling senddata 2")
        
        
        print("Light:\(jsonObject.description)")
        
        let url = NSURL(string: "http://ec2-52-21-74-14.compute-1.amazonaws.com:3000/api/addUser")!
        let loginurl = NSURL(string: "http://ubuntu@ec2-54-153-112-71.us-west-1.compute.amazonaws.com:3000/api/login")!
       var resstr = ""
        let url3 = NSURL(string: "http://ubuntu@ec2-54-153-112-71.us-west-1.compute.amazonaws.com:3000/api/addUser")!
        let request = NSMutableURLRequest(url: loginurl as URL)
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
            print("calling senddata 4")
            print("responseString = \(responseString)")
            
            
            resstr = (responseString as? String)!
            
            let start = resstr.index(resstr.startIndex, offsetBy: 2)
            let end = resstr.index(resstr.endIndex, offsetBy: -41)
            let range = start..<end
            
            print(resstr.substring(with: range))  // play
            if(resstr.substring(with: range) == "error"){
            
            
            
            }
            
            let nc = NotificationCenter.default
            nc.post(name:Notification.Name(rawValue:"MyNotification2"),
                    object: nil,
                    userInfo: ["message":resstr.substring(with: range), "date":Date()])
            
            
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
    
    
    
}
