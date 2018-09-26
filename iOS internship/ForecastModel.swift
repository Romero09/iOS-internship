//
//  ForecastModel.swift
//  iOS internship
//
//  Created by pavels.vetlugins on 26/09/2018.
//  Copyright © 2018 pavels.vetlugins. All rights reserved.
//

import Foundation
import Freddy

public class ForecastModel: FetchForecastDelegate{
    
    var delegate: GetForecastDelegate?

    let forecastTransport = ForecastTransport()
    
    init() {
        forecastTransport.delegate = self
    }
    
    func fetchForecast(fetchLocation location: String){
        forecastTransport.fetchForecast(fetchLocation: location)
    }
    
    
    func forecastFetched(forecast: Forecast) {
        guard let delegate = self.delegate else {
            return
        }
        delegate.getForecast(forecast: forecast)
        print("Forecast is \(forecast)")
    }

}


struct Forecast: JSONDecodable {
    public let maxTemp: Int
    public let minTemp: Int
    
    public init(json value: JSON) throws {
        minTemp = try value.getInt(at: "Temperature", "Minimum", "Value")
        maxTemp = try value.getInt(at: "Temperature", "Maximum", "Value")
    }
}
