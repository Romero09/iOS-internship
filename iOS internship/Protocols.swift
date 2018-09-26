//
//  Protocols.swift
//  iOS internship
//
//  Created by pavels.vetlugins on 26/09/2018.
//  Copyright © 2018 pavels.vetlugins. All rights reserved.
//

import Foundation

protocol FetchForecastDelegate{
    func forecastFetched(forecast: Forecast, headline: ForecastHeadline)
    
}

protocol GetForecastDelegate{
    func getForecast(forecast: Forecast, headline: ForecastHeadline)
}


