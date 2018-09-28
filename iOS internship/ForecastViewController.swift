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

    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    private let forecastModel = ForecastModel()
    
    var city = ""
    var location = ""

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleBar.title = city
        
        maxTemp.isHidden = true
        minTemp.isHidden = true
        maxTempUnit.isHidden = true
        minTempUnit.isHidden = true
        text.isHidden = true
        condition.isHidden = true
        conditionLabel.isHidden = true

        forecastModel.delegate = self
        forecastModel.fetchForecast(fetchLocation: location)
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        
    }
    
    func update(forecast: Forecast, headline: ForecastHeadline) {
        
        DispatchQueue.main.async(execute:{() -> Void in
            self.activityIndicator.stopAnimating()
            self.maxTemp.text = String(forecast.maxTemp)
            self.minTemp.text = String(forecast.minTemp)
            self.maxTempUnit.text = forecast.unit
            self.minTempUnit.text = forecast.unit
            self.text.text = headline.text
            
            self.maxTemp.isHidden = false
            self.minTemp.isHidden = false
            self.maxTempUnit.isHidden = false
            self.minTempUnit.isHidden = false
            self.text.isHidden = false
            self.condition.isHidden = false
            self.conditionLabel.isHidden = false
            
            if headline.category == "" {
                self.condition.isHidden = true
                self.conditionLabel.isHidden = true
            } else {
            self.condition.text = headline.category
            }
        })
        
    }


}
