//
//  DailyWeather.swift
//  StormyTable
//
//  Created by Liu Cheng on 2015-09-23.
//  Copyright © 2015 Treehouse. All rights reserved.
//

import Foundation
import UIKit

struct DailyWeather {
    
    let maxTemperature: Int?
    let minTemperature: Int?
    let humidity: Int?
    let precipChance: Int?
    let summary: String?
    var icon: UIImage? = UIImage(named: "default.png")
    var largeIcon: UIImage? = UIImage(named: "default_large.png")
    let sunriseTime: String?
    let sunsetTime: String?
    let day: String?
    
    init(dailyWeatherDict: [String: AnyObject]) {
        
        maxTemperature = dailyWeatherDict["temperatureMax"] as? Int
        if let humidityFloat = dailyWeatherDict["humidity"] as? Double {
            humidity = Int(humidityFloat * 100)
        } else {
            humidity = nil
        }
        if let precipChanceFloat = dailyWeatherDict["precipProbability"] as? Double {
            precipChance = Int(precipChanceFloat * 100)
        } else {
            precipChance = nil
        }
        summary = dailyWeatherDict["summary"] as? String
        if let iconString = dailyWeatherDict["icon"] as? String,
        let iconEnum = Icon(rawValue: iconString) {
            (icon, largeIcon) = iconEnum.toImage()
        }
    }
    
}