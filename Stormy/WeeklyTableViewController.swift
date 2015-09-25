//
//  WeeklyTableViewController.swift
//  Stormy
//
//  Created by Liu Cheng on 2015-08-01.
//  Copyright (c) 2015 Treehouse. All rights reserved.
//

import UIKit

class WeeklyTableViewController: UITableViewController {

    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var currentPrecipitationLabel: UILabel!
    @IBOutlet weak var currentTemperatureRangeLabel: UILabel!
    
    // Location coordinates
    let coordinate: (lat: Double, lon: Double) = (45.416587,-75.66772)
    
    var weeklyWeather: [DailyWeather] = []
    
    // TODO: Enter your API key here
    private let forecastAPIKey = "fb9bc4b82191b64d13b661b6897f06ea"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        retrieveWeatherForecast()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureView() {
        // Set table view's background view property
        tableView.backgroundView = BackgroundView()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return weeklyWeather.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WeatherCell") as! DailyWeatherTableViewCell
        
        let dailyWeather = weeklyWeather[indexPath.row]
        if let maxTemp = dailyWeather.maxTemperature {
            cell.temperatureLabel.text = "\(maxTemp)º"
        }
        cell.weatherIcon.image = dailyWeather.icon
        cell.dayLabel.text = dailyWeather.day
        return cell
    }
    
    // MARK: - Weather Fetching
    
    func retrieveWeatherForecast() {
        let forecastService = ForecastService(APIKey: forecastAPIKey)
        forecastService.getForecast(coordinate.lat, lon: coordinate.lon) {
            (let forecast) in
            
            if let weatherForecast = forecast, let currentWeather = weatherForecast.currentWeather {
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    if let temperature = currentWeather.temperature {
                        self.currentTemperatureLabel?.text = "\(temperature)º"
                    }
                    
                    if let precipitation = currentWeather.precipProbability {
                        self.currentPrecipitationLabel?.text = "Rain: \(precipitation)%"
                    }
                    
                    if let icon = currentWeather.icon {
                        self.currentWeatherIcon?.image = icon
                    }
                    
                    self.weeklyWeather = weatherForecast.weekly
                    
                    if let highTemp = self.weeklyWeather.first?.maxTemperature,
                        let lowTemp = self.weeklyWeather.first?.minTemperature {
                            self.currentTemperatureRangeLabel?.text = "↑\(highTemp)º↓\(lowTemp)º"
                    }
                    self.tableView.reloadData()
                }
                
            }
        }
    }

}
