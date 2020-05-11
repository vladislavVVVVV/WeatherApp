//
//  ForecastWeather.swift
//  WeatherApp
//
//  Created by Uladzislau Yaunevich on 5/11/20.
//  Copyright © 2020 UladzislauCompany. All rights reserved.
//

import Foundation
import UIKit

struct ForecastWeatherModel : Codable {
    let cod : String?
    let message : Int?
    let cnt : Int?
    let list : [ForecastList]?
    let city : City?
    
    enum CodingKeys: String, CodingKey {
        
        case cod = "cod"
        case message = "message"
        case cnt = "cnt"
        case list = "list"
        case city = "city"
    }
}


struct ForecastList : Codable {
    let dt : Int?
    let main : ForecastMain?
    let weather : [ForecastWeather]?
    let clouds : ForecastClouds?
    let wind : ForecastWind?
    let sys : ForecastSys?
    let dtTxt : String?
    
    enum CodingKeys: String, CodingKey {
        
        case dt = "dt"
        case main = "main"
        case weather = "weather"
        case clouds = "clouds"
        case wind = "wind"
        case sys = "sys"
        case dtTxt = "dt_txt"
    }
}

struct ForecastMain : Codable {
    let temp : Double?
    let feels_like : Double?
    let temp_min : Double?
    let temp_max : Double?
    let pressure : Int?
    let sea_level : Int?
    let grnd_level : Int?
    let humidity : Int?
    let temp_kf : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case temp = "temp"
        case feels_like = "feels_like"
        case temp_min = "temp_min"
        case temp_max = "temp_max"
        case pressure = "pressure"
        case sea_level = "sea_level"
        case grnd_level = "grnd_level"
        case humidity = "humidity"
        case temp_kf = "temp_kf"
    }
}

struct ForecastSys : Codable {
    let pod : String?
    
    enum CodingKeys: String, CodingKey {
        
        case pod = "pod"
    }
}

struct ForecastWeather : Codable {
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


struct ForecastWind : Codable {
    let speed : Double?
    let deg : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case speed = "speed"
        case deg = "deg"
    }
}

struct City : Codable {
    let id : Int?
    let name : String?
    let coord : Coord?
    let country : String?
    let population : Int?
    let timezone : Int?
    let sunrise : Int?
    let sunset : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case coord = "coord"
        case country = "country"
        case population = "population"
        case timezone = "timezone"
        case sunrise = "sunrise"
        case sunset = "sunset"
    }
}

struct ForecastClouds : Codable {
    let all : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case all = "all"
    }
}

struct ForecastCoord : Codable {
    let lat : Double?
    let lon : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case lat = "lat"
        case lon = "lon"
    }
}
