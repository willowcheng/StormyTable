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
    
    
}