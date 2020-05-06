//
//  CurrentWeatherViewModel.swift
//  WeatherApp
//
//  Created by Uladzislau Yaunevich on 5/6/20.
//  Copyright © 2020 UladzislauCompany. All rights reserved.
//

import Foundation

import UIKit

class CurrentWeatherViewModel: NSObject {
    private var currentWeather: CurrentWeather
    
    public init(currentWeather: CurrentWeather) {
        self.currentWeather = currentWeather
    }
    
    public var currentTemp: String {
        let temp = ((currentWeather.main?.temp ?? 273.15) - 273.15) //Temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
        return String(format: "%.2f", temp)
    }
    
    public var cityName: String {
        return currentWeather.name ?? "Unknown"
    }
    
    public var desc: String {
        return currentWeather.weather![0].main ?? "Unknown"
       }
 
    
    public var countryName: String {
        return currentWeather.sys?.country ?? "Unknown"
    }
    
    public var weatherIcon: UIImage{
        return (currentWeather.weather?[0].iconImage)!
    }
  
        
}

extension CurrentWeatherViewModel {
    public func configure(_ view: CurrentWeatherView) {
        view.tempLabel.text = currentTemp + "℃ | " + desc
        view.cityNameLabel.text = cityName + ", " + countryName
        view.weatherImage.image = weatherIcon
    }
}
