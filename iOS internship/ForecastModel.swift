//
//  ForecastModel.swift
//  iOS internship
//
//  Created by pavels.vetlugins on 26/09/2018.
//  Copyright © 2018 pavels.vetlugins. All rights reserved.
//

import Foundation
import Freddy

protocol FetchForecastDelegate{
    func forecastFetched(forecast: Forecast, headline: ForecastHeadline)
    
}

public class ForecastModel: FetchForecastDelegate{
    
    var delegate: UpdateForecastDelegate?

    let forecastTransport = ForecastTransport()
    
    init() {
        forecastTransport.delegate = self
    }
    
    func fetchForecast(fetchLocation location: String){
        forecastTransport.fetchForecast(fetchLocation: location)
    }
    
    
    func forecastFetched(forecast: Forecast, headline: ForecastHeadline) {
        guard let delegate = self.delegate else {
            return
        }
        delegate.update(forecast: forecast, headline: headline)
    }

}


struct Forecast: JSONDecodable {
    public let maxTemp: Int
    public let minTemp: Int
    public let unit: String
    
    
    public init(json value: JSON) throws {
        minTemp = try value.getInt(at: "Temperature", "Minimum", "Value")
        maxTemp = try value.getInt(at: "Temperature", "Maximum", "Value")
        unit = try value.getString(at: "Temperature", "Maximum", "Unit")
    }
}

struct ForecastHeadline: JSONDecodable {
    public let text: String
    public let category: String
    
    
    public init(json value: JSON) throws {
        category = try value.getString(at: "Category")
        text = try value.getString(at: "Text")
    }
}
