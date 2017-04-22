//
//  AssistantViewController.swift
//  simple
//
//  Created by Vishwas Mukund on 4/13/17.
//  Copyright © 2017 Mukund, Vishwas. All rights reserved.
//

import Foundation
import UIKit
import ApiAI
import MBProgressHUD
import s3c
import ApiAI
import Benchmark


class AssistantViewController : s3c {


    @IBOutlet weak var textField: UITextField!

    @IBOutlet weak var optextview: UITextView!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Optional
        let item = [
            "from": "ASSISTANT",
            "message": "Hi , How may i assist you?",
            //"image": UIImage(named: "placeholder")
        ] as [String : Any]
        s3c_struct.messages.insert(item, at: 0)
      //  s3c_struct.button.addTarget(self, action: #selector(self.sendMessage), for: .touchUpInside)
        //Required
        initializeChat()
        
//        
//        let text: String = (s3c_struct.input.text)!
//        let from: String = s3c_struct.user1_name
//        
//        s3c_struct.input.text = ""
//        
//        addMessage(text: text, from: from)
//        
        
    }

    @IBAction func sendText(_ sender: Any) {
    
        let hud = MBProgressHUD.showAdded(to: self.view.window!, animated: true)
        
        self.textField?.resignFirstResponder()
        
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
        
        request?.setCompletionBlockSuccess({[unowned self] (request, response) -> Void in
          // let resultNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultNavigationController
            
          //  resultNavigationController.response = response as AnyObject?
            
          //  self.present(resultNavigationController, animated: true, completion: nil)
            
           hud.hide(animated: true)
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
            s3c_struct.messages.insert(item, at: 0)
            
            s3c_struct.button.addTarget(self, action: #selector(self.sendMessage), for: .touchUpInside)

            
            
           
           // s3c().addMessage(text: "Hi", from: "3rd Party")
          //  self.optextview.text = speech.description
            
            
            }, failure: { (request, error) -> Void in
             //   hud.hide(animated: true)
        });
        
        ApiAI.shared().enqueue(request)
    
    
    
    }


}
