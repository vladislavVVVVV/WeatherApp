//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Uladzislau Yaunevich on 5/6/20.
//  Copyright © 2020 UladzislauCompany. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeather : Codable {
let coord : Coord?
let weather : [Weather]?
let base : String?
let main : Main?
let wind : Wind?
let clouds : Clouds?
let dt : Int?
let sys : Sys?
let id : Int?
let name : String?
let cod : Int?

enum CodingKeys: String, CodingKey {

    case coord = "coord"
    case weather = "weather"
    case base = "base"
    case main = "main"
    case wind = "wind"
    case clouds = "clouds"
    case dt = "dt"
    case sys = "sys"
    case id = "id"
    case name = "name"
    case cod = "cod"
    }
}

struct Weather : Codable {
    let id : Int?
    let main : String?
    let description : String?
    let icon : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case main = "main"
        case description = "description"
        case icon = "icon"
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


struct Main : Codable {
    let temp : Double?
    let pressure : Double?
    let humidity : Int?
    let temp_min : Double?
    let temp_max : Double?
    let sea_level : Double?
    let grnd_level : Double?

    enum CodingKeys: String, CodingKey {

        case temp = "temp"
        case pressure = "pressure"
        case humidity = "humidity"
        case temp_min = "temp_min"
        case temp_max = "temp_max"
        case sea_level = "sea_level"
        case grnd_level = "grnd_level"
    }
}

struct Sys : Codable {
    let message : Double?
    let country : String?
    let sunrise : Int?
    let sunset : Int?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case country = "country"
        case sunrise = "sunrise"
        case sunset = "sunset"
    }
}


struct Wind : Codable {
    let speed : Double?
    let deg : Int?

    enum CodingKeys: String, CodingKey {

        case speed = "speed"
        case deg = "deg"
    }
}

struct Clouds : Codable {
    let all : Int?

    enum CodingKeys: String, CodingKey {

        case all = "all"
    }
}


struct Coord : Codable {
    let lon : Double?
    let lat : Double?

    enum CodingKeys: String, CodingKey {

        case lon = "lon"
        case lat = "lat"
    }
}