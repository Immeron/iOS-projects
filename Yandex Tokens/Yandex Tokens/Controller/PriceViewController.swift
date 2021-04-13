//
//  PriceViewController.swift
//  Yandex Tokens
//
//  Created by Илья Виноградов on 02.04.2021.
//

import UIKit
import Charts

class PriceViewController: UIViewController {
    let dats = ["sent","feb","oct","jen","dec"]
    let price: [Double] = [1,2,3,4,5]
    
    @IBOutlet weak var graphPrice: LineChartView!
    
    var data: CompanyProfile?{
        didSet{
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeGraph(dataPoints: dats, values: price)
        graphPrice.animate(yAxisDuration: 2.0)
        
        graphPrice.backgroundColor = .blue
    }
    
    
    
    func customizeGraph(dataPoints: [String], values: [Double]){
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count-1 {
            let dataEntry = ChartDataEntry(x: values[i], y: Double(i))
            dataEntries.append(dataEntry)
        }
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: nil)
        lineChartDataSet.colors = [NSUIColor.red]
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        graphPrice.data = lineChartData
        
    }
    
    

    
}
