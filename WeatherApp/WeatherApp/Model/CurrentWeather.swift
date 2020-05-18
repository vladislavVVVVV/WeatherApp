//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Uladzislau Yaunevich on 5/6/20.
//  Copyright © 2020 UladzislauCompany. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeather: Codable {
    let coord: Coord?
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let wind: Wind?
    let rain: Rain?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
    let id: Int?
    let name: String?
    let cod: Int?

    enum CodingKeys: String, CodingKey {

        case coord
        case weather
        case base
        case main
        case rain
        case wind
        case clouds
        case dt
        case sys
        case id
        case name
        case cod
    }
}

struct Weather: Codable {
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

extension Weather {
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

struct Main: Codable {
    let temp: Double?
    let pressure: Double?
    let humidity: Int?
    enum CodingKeys: String, CodingKey {
        case temp
        case pressure
        case humidity
    }
}

struct Sys: Codable {
    let message: Double?
    let country: String?
    let sunrise: Int?
    let sunset: Int?
    enum CodingKeys: String, CodingKey {
        case message
        case country
        case sunrise
        case sunset
    }
}

struct Wind: Codable {
    let speed: Double?
    let deg: Int?
    enum CodingKeys: String, CodingKey {
        case speed
        case deg
    }
}
struct Rain: Codable {
    let rainVolume: Double?
    enum CodingKeys: String, CodingKey {
        case rainVolume = "1h"
    }
}

struct Clouds: Codable {
    let all: Int?
    enum CodingKeys: String, CodingKey {
        case all
    }
}

struct Coord: Codable {
    let lon: Double?
    let lat: Double?
    enum CodingKeys: String, CodingKey {
        case lon
        case lat
    }
}
