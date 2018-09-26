//
//  CityModel.swift
//  iOS internship
//
//  Created by pavels.vetlugins on 26/09/2018.
//  Copyright © 2018 pavels.vetlugins. All rights reserved.
//

import Foundation
import Freddy


public class CityModel{
    
    let cityTransport: CityTransport = CityTransport()
    
    var cityArray: [City] = []
    
    func fetchCity(city: String, completion: @escaping (_ result: Bool) ->()){
        cityTransport.fetchCity(fetchCity: city){ (cities) in
            self.cityArray = cities
            completion(true)
        }
    }
}


public struct City: JSONDecodable{
    
    public let locationKey: String
    public let rank: Int
    public let cityName: String
    public let countryId: String
    public let countryName: String
    public let administrativeAriaID: String
    
    public init(json value: JSON) throws {
        locationKey = try value.getString(at: "Key")
        rank = try value.getInt(at: "Rank")
        cityName = try value.getString(at: "LocalizedName")
        countryId = try value.getString(at: "Country", "ID")
        countryName = try value.getString(at: "Country", "LocalizedName")
        administrativeAriaID = try value.getString(at: "AdministrativeArea", "ID")
        
    }
    
}
