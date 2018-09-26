//
//  ForecastTransport.swift
//  iOS internship
//
//  Created by pavels.vetlugins on 26/09/2018.
//  Copyright © 2018 pavels.vetlugins. All rights reserved.
//

import Foundation
import Freddy


class ForecastTransport{
    
    var delegate: FetchForecastDelegate?
    
    private let host = "http://dataservice.accuweather.com"
    private let queryType = "/forecasts/v1/daily/1day/"
    private let apiKey = "apikey=IMgqorDz5IuGWo9ncYmyTxsRnX4SGxgS"
    private let metric = "&metric=true"
    
    //API - apikey=09IMgqorDz5IuGWo9ncYmyTxsRnX4SGxgS
    //API - apikey=hjuVrFcGICAo5gPG29XzOi2KENaQc7Ld
    // "http://dataservice.accuweather.com/locations/v1/cities/search?apikey=%09IMgqorDz5IuGWo9ncYmyTxsRnX4SGxgS&q=riga"
    
    func fetchForecast(fetchLocation location: String) {
        let querry = "\(location)?"
        
        let fullQuerry = host+queryType+querry+apiKey+metric
        guard let fullQuerryURL: URL = URL(string: fullQuerry) else {
            print("value was nil")
            return
        }
        print(fullQuerryURL)
        
        let fetchByLocation = URLSession.shared.dataTask(with: fullQuerryURL) { (data, response, error) in
            if error != nil {
                print(error!)
            } else {
                do {
                    let json = try JSON(data: data!)
                    print(json)
                    let forecastHeadline = try json.decode(at: "Headline", type: ForecastHeadline.self)
                    print(forecastHeadline)
                    let forecast = try json.getArray(at: "DailyForecasts").map(Forecast.init)
                    guard let delegate = self.delegate else {
                        return
                    }
                    delegate.forecastFetched(forecast: forecast[0], headline: forecastHeadline)
                   
                    print(forecast)
                }catch{
                    print("error parsing")
                }
            }
        }
        
        fetchByLocation.resume()
    }
}


