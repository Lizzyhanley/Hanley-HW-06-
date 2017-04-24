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

class WeatherLocation: WeatherUserDefault {

    struct DailyForcast {
        var dailyMaxTemp: Double
        var dailyMinTemp: Double
        var dailySummary: String
        var dailyDate: Double
        var dailyIcon: String
    }
    
    struct HourlyForecast {
        var hourlyTime: Double
        var hourlyIcon: String
        var hourlyTemp: Double
        var hourlyPrecipProb: Double
    }
    
    
    var currentTemp = -999.9
    var dailySummary = ""
    var currentIcon = ""
    var currentTime = 0.0
    var timeZone = ""
    

    var dailyForcastArray = [DailyForcast]()
    
    var hourlyForecastArray = [HourlyForecast]()
    
    
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
                if  let summary = json["daily"]["summary"].string {
                    print("SUMMARY inside getWeather = \(summary)")
                    self.dailySummary = summary
                } else {
                    print("Can't return summary.")
                }
                if  let icon = json["currently"]["icon"].string {
                    print("ICON inside getWeather = \(icon)")
                    self.currentIcon = icon
                } else {
                    print("Can't return icon.")
                }
                if  let time = json["currently"]["time"].double {
                    print("TIME inside getWeather = \(time)")
                    self.currentTime = time
                } else {
                    print("Can't return time.")
                }
                if  let timezone = json["timezone"].string {
                    print("TIMEZONE inside getWeather = \(timezone)")
                    self.timeZone = timezone
                } else {
                    print("Can't return timezone.")
                }
                let dailyDataArray = json["daily"]["data"]
                self.dailyForcastArray = [] 
                let lastDay = min(dailyDataArray.count-1, 6)
                for day in 1...lastDay {
                    let maxTemp = json["daily"]["data"][day]["tameratureMax"].doubleValue
                    let minTemp = json["daily"]["data"][day]["tameratureMin"].doubleValue
                    let dailySummary = json["daily"]["data"][day]["summary"].stringValue
                    let dateValue = json["daily"]["data"][day]["time"].doubleValue
                    let icon = json["daily"]["data"][day]["icon"].stringValue
                    let iconName = icon.replacingOccurrences(of: "night", with: "day")
                    self.dailyForcastArray.append(DailyForcast(dailyMaxTemp: maxTemp, dailyMinTemp: minTemp, dailySummary: dailySummary, dailyDate: dateValue, dailyIcon: iconName))
                    print("$&$&$&$ dailyForcastArray = ^^^^^^ \(self.dailyForcastArray)")
                }
                let hourlyDataArray = json["hourly"]["data"]
                self.hourlyForecastArray = []
                let lastHour = min(hourlyDataArray.count-1, 24)
                for hour in 1...lastHour {
                    let hourlyTime = json["hourly"]["data"][hour]["time"].doubleValue
                    let hourlyIcon = json["hourly"]["data"][hour]["icon"].stringValue
                    let hourlyTemp = json["hourly"]["data"][hour]["temperature"].doubleValue
                    let hourlyPrecipProb = json["hourly"]["data"][hour]["precipProbability"].doubleValue
                    self.hourlyForecastArray.append(HourlyForecast(hourlyTime: hourlyTime, hourlyIcon: hourlyIcon, hourlyTemp: hourlyTemp, hourlyPrecipProb: hourlyPrecipProb))
                }
                
            case .failure(let error):
                print(error)
            }
        completed()
        
        }
        
       
    }
    
}


