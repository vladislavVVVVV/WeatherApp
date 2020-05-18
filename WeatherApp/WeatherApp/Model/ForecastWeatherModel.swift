//
//  ForecastWeather.swift
//  WeatherApp
//
//  Created by Uladzislau Yaunevich on 5/11/20.
//  Copyright © 2020 UladzislauCompany. All rights reserved.
//

import Foundation
import UIKit

struct ForecastWeatherModel: Codable {
    let cod: String?
    let message: Int?
    let cnt: Int?
    let list: [ForecastList]?
    let city: City?
    enum CodingKeys: String, CodingKey {
        case cod
        case message
        case cnt
        case list
        case city
    }
}

struct DaySection {
    var day: Date
    var list: [ForecastList]
}

struct ForecastList: Codable {
    let dt: Int?
    let main: ForecastMain?
    let weather: [ForecastWeather]?
    let clouds: ForecastClouds?
    let wind: ForecastWind?
    let sys: ForecastSys?
    let dtTxt: String?
    enum CodingKeys: String, CodingKey {
        case dt
        case main
        case weather
        case clouds
        case wind
        case sys
        case dtTxt = "dt_txt"
    }
}

extension String {
    func toData() -> Data {
        return Data(self.utf8)
    }
}

struct ForecastMain: Codable {
    let temp: Double?
    let pressure: Int?
    let humidity: Int?
    enum CodingKeys: String, CodingKey {
        case temp
        case pressure
        case humidity
    }
}

struct ForecastSys: Codable {
    let pod: String?
    enum CodingKeys: String, CodingKey {
        case pod
    }
}

struct ForecastWeather: Codable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
    enum CodingKeys: String, CodingKey {
        case id
        case main
        case description
        case icon
    }
}

extension ForecastWeather {
    var iconImage: UIImage {
        switch icon {
        case "01d":
            return UIImage(named: "01d")!
        case "01n":
            return UIImage(named: "01n")!
        case "02d":
            return UIImage(named: "02d")!
        case "02n":
            return UIImage(named: "02n")!
        case "03d":
            return UIImage(named: "03d")!
        case "03n":
            return UIImage(named: "03n")!
        case "04d":
            return UIImage(named: "04d")!
        case "04n":
            return UIImage(named: "04n")!
        case "09d":
            return UIImage(named: "09d")!
        case "09n":
            return UIImage(named: "09n")!
        case "10d":
            return UIImage(named: "10d")!
        case "10n":
            return UIImage(named: "10n")!
        case "11d":
            return UIImage(named: "11d")!
        case "11n":
            return UIImage(named: "11n")!
        case "13d":
            return UIImage(named: "13d")!
        case "13n":
            return UIImage(named: "13n")!
        case "50d":
            return UIImage(named: "50d")!
        case "50n":
            return UIImage(named: "50n")!
        default:
            return UIImage(named: "default")!
        }
    }
}

struct ForecastWind: Codable {
    let speed: Double?
    let deg: Int?
    enum CodingKeys: String, CodingKey {
        case speed
        case deg
    }
}

struct City: Codable {
    let id: Int?
    let name: String?
    let coord: Coord?
    let country: String?
    let population: Int?
    let timezone: Int?
    let sunrise: Int?
    let sunset: Int?
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case coord
        case country
        case population
        case timezone
        case sunrise
        case sunset
    }
}

struct ForecastClouds: Codable {
    let all: Int?
    enum CodingKeys: String, CodingKey {
        case all
    }
}

struct ForecastCoord: Codable {
    let lat: Double?
    let lon: Double?
    enum CodingKeys: String, CodingKey {
        case lat
        case lon
    }
}
