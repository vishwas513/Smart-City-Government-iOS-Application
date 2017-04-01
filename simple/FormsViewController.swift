//
//  File.swift
//  simple
//
//  Created by Mukund, Vishwas on 3/8/17.
//  Copyright © 2017 Mukund, Vishwas. All rights reserved.
//

import Foundation
import UIKit

class FormsViewController: UIViewController
{

    
    
    
    var titleStringViaSegue: String!
    
    @IBAction func formsBack(_ sender: Any) {
    
        self.performSegue(withIdentifier: "formsBack", sender: nil)
    
    }

    @IBOutlet var webview: UIWebView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.isNavigationBarHidden = true
        let url = NSURL (string: "https://goo.gl/forms/5r1mI2ApxQsUrBEG2");
        let requestObj = NSURLRequest(url: url! as URL);
        webview.loadRequest(requestObj as URLRequest);
    }




}
