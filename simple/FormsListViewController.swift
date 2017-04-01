//
//  ViewController.swift
//  ronTableViewMedium
//
//  Cr/Users/vishwasmukund/Desktop/iOS templates/Table click handler/A-Simple-Table-View-Example-master/ronTableViewMedium/ChartsViewController.swifteated by Ronald Mourant on 4/27/15.
//  Copyright (c) 2015 Ron Mourant. All rights reserved.
//

import UIKit

class FormsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var objects = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.objects.append("DMV form")
        self.objects.append("Buidling permit form")
        self.objects.append("Form W2")
      
    }
    
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell
    {
        let aCell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        aCell.titleLabel.text = self.objects[indexPath.row]
        
        let chevron = UIImage(named: "chevron.png")
        aCell.accessoryType = .disclosureIndicator
        aCell.accessoryView = UIImageView(image: chevron!)
        return aCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath)
    {
        self.performSegue(withIdentifier: "showView", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "showView")
        {
            let upcoming: FormsViewController = segue.destination as! FormsViewController
            
            let indexPath = self.tableView.indexPathForSelectedRow!
            
            let titleString = self.objects[indexPath.row]
            
            upcoming.titleStringViaSegue = titleString
            
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

