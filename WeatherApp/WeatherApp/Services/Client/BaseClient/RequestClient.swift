//
//  RequestClient.swift
//  WeatherApp
//
//  Created by Uladzislau Yaunevich on 5/6/20.
//  Copyright © 2020 UladzislauCompany. All rights reserved.
//

import Foundation

class RequestClient: GenericAPIClient {

    internal let session: URLSession

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }
}

enum WeatherAPI {
    case weather
    case forecast
}

extension WeatherAPI: Endpoint {
    var path: String {
        switch self {
        case .weather: return "/weather"
        case .forecast: return "/forecast"
        }
    }

    var base: String {
        return "https://api.openweathermap.org/data/2.5"
    }
}
