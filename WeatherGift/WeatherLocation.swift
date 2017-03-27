//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by CSOM on 3/26/17.
//  Copyright © 2017 CSOM. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherLocation {
    var name = ""
    var coordinates = ""
    var currentTemp = -990.9
    
    func getWeather(completed: @escaping () -> ()) {
        
        let weatherURL = urlBase + urlAPIKey + coordinates
        print(weatherURL)
        
        Alamofire.request(weatherURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if  let temperature = json["currently"]["temperature"].double {
                    print("TEMP inside getWeather = \(temperature)")
                     self.currentTemp = temperature
                } else {
                    print("Can't return temp.")
                }
            case .failure(let error):
                print(error)
            }
        }
        
        completed()
    }
    
}
