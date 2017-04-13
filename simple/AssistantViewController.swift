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

class AssistantViewController : UIViewController {


    @IBOutlet weak var textField: UITextField!

    @IBOutlet weak var optextview: UITextView!



    @IBAction func sendText(_ sender: Any) {
    
        let hud = MBProgressHUD.showAdded(to: self.view.window!, animated: true)
        
        self.textField?.resignFirstResponder()
        
        let request = ApiAI.shared().textRequest()
        
        if let text = self.textField?.text {
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
           
            self.optextview.text = speech.description
            
            
            }, failure: { (request, error) -> Void in
             //   hud.hide(animated: true)
        });
        
        ApiAI.shared().enqueue(request)
    
    
    
    }


}
