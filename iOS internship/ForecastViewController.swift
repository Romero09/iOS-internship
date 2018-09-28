//
//  ForecastViewController.swift
//  iOS internship
//
//  Created by pavels.vetlugins on 26/09/2018.
//  Copyright © 2018 pavels.vetlugins. All rights reserved.
//

import UIKit

protocol UpdateForecastDelegate{
    func update(forecast: Forecast, headline: ForecastHeadline)
}

class ForecastViewController: UIViewController, UpdateForecastDelegate {
    
    
    @IBOutlet weak var titleBar: UINavigationItem!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var maxTempUnit: UILabel!
    @IBOutlet weak var minTempUnit: UILabel!
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var condition: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    
    
    private let forecastModel = ForecastModel()
    
    var city = ""
    var location = ""

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleBar.title = city

        forecastModel.delegate = self
        forecastModel.fetchForecast(fetchLocation: location)
        
        
    }
    
    func update(forecast: Forecast, headline: ForecastHeadline) {
        DispatchQueue.main.async(execute:{() -> Void in
            self.maxTemp.text = String(forecast.maxTemp)
            self.minTemp.text = String(forecast.minTemp)
            self.maxTempUnit.text = forecast.unit
            self.minTempUnit.text = forecast.unit
            self.text.text = headline.text
            
            if headline.category == "" {
                self.condition.isHidden = true
                self.conditionLabel.isHidden = true
            } else {
            self.condition.text = headline.category
            }
        })
        
    }


}
