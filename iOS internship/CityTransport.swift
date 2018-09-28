//
//  CityTransport.swift
//  iOS internship
//
//  Created by pavels.vetlugins on 26/09/2018.
//  Copyright © 2018 pavels.vetlugins. All rights reserved.
//

import Foundation
import Freddy

public class CityTransport{
    
    private let host = "http://dataservice.accuweather.com"
    private let queryType = "/locations/v1/cities/autocomplete?"
    private let apiKey = "apikey=IMgqorDz5IuGWo9ncYmyTxsRnX4SGxgS"
    
    //API - apikey=IMgqorDz5IuGWo9ncYmyTxsRnX4SGxgS
    //API - apikey=hjuVrFcGICAo5gPG29XzOi2KENaQc7Ld
    // "http://dataservice.accuweather.com/locations/v1/cities/search?apikey=%09IMgqorDz5IuGWo9ncYmyTxsRnX4SGxgS&q=riga"
    
    func fetchCity(fetchCity cityName: String, completion: @escaping (_ cities: [City]) -> ()) {
        let querry = "&q=\(cityName)"
        
        let fullQuerry = host+queryType+apiKey+querry
        guard let fullQuerryURL: URL = URL(string: fullQuerry) else {
            print("value was nil")
            return
        }
        
        let fetchByCity = URLSession.shared.dataTask(with: fullQuerryURL) { (data, response, error) in
            
            if error != nil {
                print(error!)
            } else {
                do {
                    let json = try JSON(data: data!)
                    let cityArray = try json.getArray().map(City.init)
                    completion(cityArray)
                }catch{
                    print("error parsing")
                }
            }
        }
        
        fetchByCity.resume()
    }

}
