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
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Units Sold")
        let chartData = BarChartData(dataSet: chartDataSet)
        Barchart.data = chartData
        
    }
    
}

