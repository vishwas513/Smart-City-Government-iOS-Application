//
//  ViewController.swift
//  swift3chat
//
//  Created by Chris Cates on 2016-12-08.
//  Copyright © 2016 Chris Cates. All rights reserved.
//

import UIKit
import ApiAI
import MBProgressHUD
import Benchmark
import QuartzCore
import ZGTooltipView

public struct s3c_struct {
    static var offset: Int = 0
    static var fontSize: Int = 14
    static var photoSize: Int = 33
    static var user1_name: String! = "Anonymous"
  //  static var user1_photo: UIImage! = UIImage(named: "placeholder")
    static var user2_name: String! = "Anonymous"
    //static var user2_photo: UIImage! = UIImage(named: "placeholder")
    static var messagesContainer: UITableView!
    static var messagesContainerDict: NSMutableDictionary!
    static var messages: Array<Dictionary<String, Any>> = Array()
    static var button: UIButton!
    static var buttonDict: NSMutableDictionary!
    static var input: UITextField!
    static var inputDict: NSMutableDictionary!
    
    var iflag  = false
    var cflag = false
    var lflag = false
    var dflag = false
    
}

class s3c: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var iflag  = false
    var cflag = false
    var lflag = false
    var dflag = false
    var fflag = false
    
    var category = ""
    var desc = ""
    public func initializeChat() {
        
        if (s3c_struct.messagesContainerDict == nil) {
            s3c_struct.messagesContainerDict = NSMutableDictionary()
            s3c_struct.messagesContainerDict["CGRect"] = CGRect(
                x: 15,
                y: 15,
                width: view.frame.width - 30,
                height: view.frame.height - 80
            )
            s3c_struct.messagesContainerDict["CGSize"] = CGSize(
                width: view.frame.width - 30,
                height: view.frame.height - 80
            )
            s3c_struct.messagesContainerDict["CGPoint"] = CGPoint(
                x: 0,
                y: view.frame.height - 80
            )
        }
        
        if (s3c_struct.messagesContainer == nil) {
            s3c_struct.messagesContainer = UITableView(frame: s3c_struct.messagesContainerDict["CGRect"] as! CGRect)
            s3c_struct.messagesContainer.contentSize = s3c_struct.messagesContainerDict["CGSize"] as! CGSize
        }
        
        if (s3c_struct.inputDict == nil) {
            s3c_struct.inputDict = NSMutableDictionary()
            s3c_struct.inputDict["CGRect"] = CGRect(
                x: 15,
                y: view.frame.height - 50,
                width: view.frame.width - 145,
                height: 40
            )
            s3c_struct.inputDict["placeholder"] = "Type a message"
            s3c_struct.inputDict["borderWidth"] = CGFloat(2.5)
            s3c_struct.inputDict["borderColor"] = UIColor.black.cgColor
        }
        
        if (s3c_struct.input == nil) {
            s3c_struct.input = UITextField(frame: s3c_struct.inputDict["CGRect"] as! CGRect)
            s3c_struct.input.placeholder = (s3c_struct.inputDict["placeholder"] as! String)
            s3c_struct.input.borderBottom(
                borderWidth: s3c_struct.inputDict["borderWidth"] as! CGFloat,
                borderColor: s3c_struct.inputDict["borderColor"] as! CGColor
            )
        }
        
        if (s3c_struct.buttonDict == nil) {
            s3c_struct.buttonDict = NSMutableDictionary()
            s3c_struct.buttonDict["CGRect"] = CGRect(
                x: view.frame.width - 115,
                y: view.frame.height - 50,
                width: 100,
                height: 40
            )
            s3c_struct.buttonDict["color"] = UIColor.white
            s3c_struct.buttonDict["bg"] = UIColor.blue
            s3c_struct.buttonDict["title"] = "Send"
        }
        
        if (s3c_struct.button == nil) {
            s3c_struct.button = UIButton(frame: s3c_struct.buttonDict["CGRect"] as! CGRect)
            s3c_struct.button.backgroundColor = (s3c_struct.buttonDict["bg"] as! UIColor)
            s3c_struct.button.tintColor = s3c_struct.buttonDict["color"] as! UIColor
            s3c_struct.button.setTitle((s3c_struct.buttonDict?["title"] as! String), for: .normal)
           // s3c_struct.button.setTooltip(ZGTooltipView(direction: .top, text: "Lorem ipsum dolor sit amet"))
        }
        
      //  s3c_struct.user1_photo = s3c_struct.user1_photo.resizeImage(targetSize: CGSize(width: s3c_struct.photoSize, height: s3c_struct.photoSize))
      //  s3c_struct.user2_photo = s3c_struct.user2_photo.resizeImage(targetSize: CGSize(width: s3c_struct.photoSize, height: s3c_struct.photoSize))
     
       s3c_struct.button.addTarget(self, action: #selector(self.sendMessage), for: .touchUpInside)
        
        s3c_struct.messagesContainer.delegate = self
        s3c_struct.messagesContainer.dataSource = self
        s3c_struct.messagesContainer.separatorStyle = UITableViewCellSeparatorStyle.none
        s3c_struct.messagesContainer.allowsSelection = false
        s3c_struct.messagesContainer.estimatedRowHeight = 100
        s3c_struct.messagesContainer.transform = CGAffineTransform.init(rotationAngle: CGFloat(-M_PI))
        s3c_struct.messagesContainer.rowHeight = UITableViewAutomaticDimension
       // s3c_struct.messagesContainer.backgroundColor = #colorLiteral(red: 0.011009207, green: 0.7792026401, blue: 1, alpha: 1)
        //s3c_struct.messagesContainer.text
        
        print("Adding swift 3 chat views")
        view.addSubview(s3c_struct.input)
        view.addSubview(s3c_struct.button)
        view.addSubview(s3c_struct.messagesContainer)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(s3c_struct.messages.count)
        return s3c_struct.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "chatCell")
        
        
        cell.layer.cornerRadius=10 //set corner radius here
        cell.layer.borderColor = UIColor.black.cgColor  // set cell border color here
        cell.layer.borderWidth = 1 // set border width here
        
        
        let message = s3c_struct.messages[indexPath.row]
        cell.transform = CGAffineTransform.init(rotationAngle: CGFloat(M_PI))
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = (message["from"] as! String) + " said:\n" + (message["message"] as! String)
        cell.imageView?.image = message["image"] as? UIImage
        cell.backgroundColor = #colorLiteral(red: 0.011009207, green: 0.7792026401, blue: 1, alpha: 1)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,forRowAt indexPath: IndexPath)
    {
        if (indexPath.row % 2 == 0)
        {
            //cell.backgroundColor = UIColor.white
            cell.backgroundColor = #colorLiteral(red: 0.06350831687, green: 0.5272518992, blue: 1, alpha: 1)
        } else {
            cell.backgroundColor = #colorLiteral(red: 0.9022669196, green: 0.9015806317, blue: 0.9233793616, alpha: 1)
            //cell.backgroundColor = colorForIndex(index: indexPath.row)
        }
    }
    
//    func colorForIndex(index: Int) -> UIColor
//    {
//        let itemCount = conversation.count
//        let color = (CGFloat(index) / CGFloat(itemCount)) * 0.6
////        return UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1.0)
//          r
//    }
    
    @objc func sendMessage() {
        
        let text: String = (s3c_struct.input.text)!
        let from: String = s3c_struct.user1_name
       // let hud = MBProgressHUD.showAdded(to: self.view.window!, animated: true)
        
        //var wordList = text
        
//        var fullNameArr = split(fullName) {$0 == " "}
//        var wordarr = wordList.split(wordList) {$0 == ""}
        let array = text.components(separatedBy: " ")
        
        
        
        
        
        var loc = "San Jose"
        var date = "04/16/2017"
        
        
        for i in array {
//            print("Hello, \(name)!")
            
            if(i == "issue" || i == "Issue"){
             
                print("The truth")
                iflag = true
                
//                let jsonobject2 = ("{"  + " " + "\"user_id\"" + ":" + "\"" + "vishwas@gmail.com" + "\"" + ","
//                    + "\"description\"" + ":" + "\"" + desc + "\"" + ","
//                    + "\"images\"" + ":" + "\"" + "fvfvdsfvddddd" + "\"" + ","
//                    + "\"category\"" + ":" + "\"" + category + "\"" + ","
//                    + "\"location\"" + ":" + "\"" + loc + "\"" + ","
//                    + "\"date\"" + ":" + "\"" + date + "\"" + ","
//                    + "\"status\"" + ":" + "\"" + "Open" + "\""
//                    
//                    + " " + "}")
//                
//                IssueViewController().senddata(jsonObject: jsonobject2)
                
                
                
            }
            
            if(iflag == true && (i == "Safety"||i == "unemployment" || i == "crime" || i == "safety"||i == "Unemployment" || i == "Crime")) {
            
                iflag = false
                category = i
                cflag = true
            
            
            
            }
            
            if(cflag == true && (i == "yes"||i == "Yes")){
            
            cflag = false
            lflag = true
            break
            
        }
            
            if(lflag == true && (i == "yes"||i == "Yes")){
                
                lflag = false
                dflag = true
                break
                
                
                
            }
            
            if(dflag == true ){
                
                dflag == false
            
                fflag = true
                
                desc = i
                
                
            }
        
        }
        
        if(fflag == true){
            
            fflag = false
        let jsonobject2 = ("{"  + " " + "\"user_id\"" + ":" + "\"" + "vishwas@gmail.com" + "\"" + ","
            + "\"description\"" + ":" + "\"" + desc + "\"" + ","
            + "\"images\"" + ":" + "\"" + "fvfvdsfvddddd" + "\"" + ","
            + "\"category\"" + ":" + "\"" + category + "\"" + ","
            + "\"location\"" + ":" + "\"" + loc + "\"" + ","
            + "\"date\"" + ":" + "\"" + date + "\"" + ","
            + "\"status\"" + ":" + "\"" + "Open" + "\""
            
            + " " + "}")
        
        IssueViewController().senddata(jsonObject: jsonobject2)
        }
        //api.ai stuff
        let request = ApiAI.shared().textRequest()
       
        
        //         if let text = self.textField?.text {
        if let text = (s3c_struct.input?.text) {
            request?.query = [text]
        } else {
            request?.query = [""]
        }
        
        
        request?.setMappedCompletionBlockSuccess({ (request, response) in
            let response = response as! AIResponse
            if response.result.action == "money" {
                if let parameters = response.result.parameters as? [String: AIResponseParameter]{
                    let amount = parameters["amout"]!.stringValue
                    let currency = parameters["currency"]!.stringValue
                    let date = parameters["date"]!.dateValue
                    
                    print("Spended \(amount) of \(currency) on \(date)")
                }
                
                //self.optextview.text = response.description
                
                
            }
        }, failure: { (request, error) in
            // TODO: handle error
        })
        
        
        Benchmark.measure() {
        
            //print(self)
        request?.setCompletionBlockSuccess({[unowned self] (request, response) -> Void in
            // let resultNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultNavigationController
            
            //  resultNavigationController.response = response as AnyObject?
            
            //  self.present(resultNavigationController, animated: true, completion: nil)
         
         //   hud.hide(animated: true)
            var resp = response as AnyObject?
            var respstring = resp?.description
            var rdata = resp as! NSDictionary
            
            var res = rdata["result"] as! NSDictionary
            let f = res["fulfillment"] as! NSDictionary
            let speech = f["speech"] as! NSString
            
            // let json = try? JSONSerialization.jsonObject(with: rdata, options: [])
            print(speech)
            
            
            let item = [
                "from": "Digital Assistant",
                "message": speech,
                //"image": UIImage(named: "placeholder")
                ] as [String : Any]
            
            TextToSpeech().speakText(text: speech as String)
            
            self.addMessage(text: speech as String, from: "ASSISTANT")
            
            if(speech as String == "Opening Dashboard"){
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "DashNav")
                self.present(controller, animated: true, completion: nil)
                
                
            }
            
            if(speech as String == "Opening Menu"){
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "menu")
                self.present(controller, animated: true, completion: nil)
                
                
            }
            
            //s3c_struct.button.addTarget(self, action: #selector(self.sendMessage), for: .touchUpInside)
            
            
            
            
            // s3c().addMessage(text: "Hi", from: "3rd Party")
            //  self.optextview.text = speech.description
            
            
            }, failure: { (request, error) -> Void in
                //   hud.hide(animated: true)
        });
        }
        ApiAI.shared().enqueue(request)
        
        
        
        s3c_struct.input.text = ""
        
    addMessage(text: text, from: "VISHWAS MUKUND")
    
        
    }
    
    public func addMessage(text: String, from: String) {
        
        let item: Dictionary = [
            "from": from,
            "message": text,
            //"image": photo
        ] as [String : Any]
        
        print("Message is: " + text)
        
        s3c_struct.messages.insert(item, at: 0)
        s3c_struct.messagesContainer.reloadData()

    }
    
}

extension UITextField {
    
    func borderBottom(borderWidth: CGFloat!, borderColor: CGColor) {
        
        let border = CALayer()
        
        border.borderColor = borderColor
        border.frame = CGRect(
            x: 0,
            y: self.frame.size.height - borderWidth,
            width: self.frame.size.width,
            height: self.frame.size.height
        )
        border.borderWidth = borderWidth
        
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        
    }
    
}

extension UIImage {
    
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        
        let widthRatio  = targetSize.width  / self.size.width
        let heightRatio = targetSize.height / self.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage ?? self
    }
    
}

