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

    public var view: CurrentWeatherView!
    public init(currentWeather: CurrentWeather) {
        self.currentWeather = currentWeather
    }

    public var currentTemp: String {
        let temp = ((currentWeather.main?.temp ?? 273.15) - 273.15) 
        return String(format: "%.f", temp)
    }

    public var maxTemp: String {
        let temp = ((currentWeather.main?.temp_max ?? 273.15) - 273.15)
        return String(format: "%.f", temp)
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
    public var pressure: String {
        return String(format: "%.f", currentWeather.main?.pressure ?? 0)
    }
    public var humidity: String {
        return String(format: "%X", currentWeather.main?.humidity ?? 0)
    }
    
    public var speedWind: String {
        let speed = (currentWeather.wind?.speed ?? 0 ) * 3.6
        return String(format: "%.f", speed)
    }
    
    public var degreeWind: String {
        return degToCompass(num: currentWeather.wind?.deg ?? 0)
    }
    
    func degToCompass(num: Int) -> String {
        var val=Int((Double(num)/22.5)+0.5)
        let arr=["N","NNE","NE","ENE","E","ESE", "SE", "SSE","S","SSW","SW","WSW","W","WNW","NW","NNW"]
        let ind = (val % 16)
        let side = arr[ind]
        return side
    }
    
    
   
    
    public var weatherIcon: UIImage {
        return (currentWeather.weather?[0].iconImage)!
    }

}

extension CurrentWeatherViewModel {
   
    public func prepareStringForShare() -> String {
        var str = ""
        str += maxTemp + "℃"
        return str
    }
    
   
    public func configure() {
        view.maxTemp.text =  maxTemp + "℃"
        view.humidityLabel.text = humidity + "%"
        view.pressureLabel.text = pressure + " hPa"
        view.speedWindLabel.text = speedWind + " km/h"
        view.degreeWind.text = String(degreeWind)
        view.tempLabel.text = currentTemp + "℃ | " + desc
        view.cityNameLabel.text = cityName + ", " + countryName
        view.weatherImage.image = weatherIcon
    }
}
