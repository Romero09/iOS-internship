//
//  ForecastViewController.swift
//  iOS internship
//
//  Created by pavels.vetlugins on 26/09/2018.
//  Copyright © 2018 pavels.vetlugins. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController, GetForecastDelegate {
    
    
    @IBOutlet weak var titleBar: UINavigationItem!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var maxTempUnit: UILabel!
    @IBOutlet weak var minTempUnit: UILabel!
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var condition: UILabel!
    
    let forecastModel = ForecastModel()
    
    var city = ""
    var location = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleBar.title = city
        print(location)

        forecastModel.delegate = self
        forecastModel.fetchForecast(fetchLocation: location)
        
        
    }
    
    func getForecast(forecast: Forecast, headline: ForecastHeadline) {
        DispatchQueue.main.async(execute:{() -> Void in
            self.maxTemp.text = String(forecast.maxTemp)
            self.minTemp.text = String(forecast.minTemp)
            self.maxTempUnit.text = forecast.unit
            self.minTempUnit.text = forecast.unit
            self.text.text = headline.text
            self.condition.text = headline.category
        })
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
