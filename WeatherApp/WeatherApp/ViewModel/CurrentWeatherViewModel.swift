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

    public var currentWeatherView: CurrentWeatherView!

    public init(currentWeather: CurrentWeather) {
        self.currentWeather = currentWeather
    }

    public var currentTemp: String {
        let temp = ((currentWeather.main?.temp ?? 273.15) - 273.15)
        return String(format: "%.f", temp)
    }

    public var rainLevel: String {
        let rain = ((currentWeather.rain?.rainVolume ?? 0))
        return String(format: "%.2f", rain)
    }

    public var cityName: String {
        if let cName = currentWeather.name {
            return cName
        } else {
            return "Unknown"
        }
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
        return String(currentWeather.main?.humidity ?? 0)
    }

    public var speedWind: String {
        let speed = (currentWeather.wind?.speed ?? 0 ) * 3.6
        return String(format: "%.f", speed)
    }

    public var degreeWind: String {
        return degToCompass(num: currentWeather.wind?.deg ?? 0)
    }

    func degToCompass(num: Int) -> String {
        let val=Int((Double(num)/22.5)+0.5)
        let arr=["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
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
        str += "Today Weather: Temperature is \(currentTemp) ℃; \(desc);"
        str += "Humidity is \(humidity)%; Speed Wind is \(speedWind) km/h"
        return str
    }

    public func configure() {
        currentWeatherView.rainLevel.text =  rainLevel + " mm"
        currentWeatherView.humidityLabel.text = humidity + "%"
        currentWeatherView.pressureLabel.text = pressure + " hPa"
        currentWeatherView.speedWindLabel.text = speedWind + " km/h"
        currentWeatherView.degreeWindLabel.text = String(degreeWind)
        currentWeatherView.tempLabel.text = currentTemp + "℃ | " + desc
        currentWeatherView.cityNameLabel.text = cityName + ", " + countryName
        currentWeatherView.weatherImage.image = weatherIcon
    }
}
