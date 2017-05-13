//
//  NewViewController.swift
//  ronTableViewMedium
//
//  Created by Ronald Mourant on 4/28/15.
//  Copyright (c) 2015 Ron Mourant. All rights reserved.
//

import UIKit
import Charts

class NewViewController: UIViewController {
    @IBOutlet weak var Barchart: BarChartView!
    @IBOutlet weak var productLabel: UILabel!
    var titleStringViaSegue: String!
    
    var months: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productLabel.text = self.titleStringViaSegue
        Barchart.noDataText = "You need to provide data for the chart."
       // Barchart.noDataTextDescription = "GIVE REASON"
        
        
        print(titleStringViaSegue)
        
        
        switch(titleStringViaSegue){
        
        case "Crime Rate" :
             months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
            let unitsSold = [10.0, 20.0, 30.0, 40.0, 50.0, 60.0, 70.0, 80.0, 90.0, 4.0, 5.0, 4.0]
                    setChart(dataPoints: months, values: unitsSold)

             
        case "Unemployment Rate" :
            months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
            let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
            setChart(dataPoints: months, values: unitsSold)
            
            
        case "GDP of San Jose (2002 - 2013)" :
            months = ["2005", "", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
            let unitsSold  = [69.0,72.0,75.0, 80.0, 84.0, 89.0, 88.0, 82.0, 89.0,95.0, 97.0,100.0]
            setChart(dataPoints: months, values: unitsSold)
            
            
            break
        default : break
        
        }
        
        
//        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
      //  let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
//        setChart(dataPoints: months, values: unitsSold)
        
//   gsdrgsrgs
        
    }
    
    
    func setChart(dataPoints: [String], values: [Double]) {
        Barchart.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x:Double(i), yValues: [values[i]])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "1 unit = $1000")
        let chartData = BarChartData(dataSet: chartDataSet)
        Barchart.data = chartData
        
    }
    
}

