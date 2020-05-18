//
//  ForecastClient.swift
//  WeatherApp
//
//  Created by Uladzislau Yaunevich on 5/11/20.
//  Copyright © 2020 UladzislauCompany. All rights reserved.
//

import Foundation
import UIKit

class ForecastClient: RequestClient {
    static let shared = ForecastClient()

    // getCurrentLocationForecastHourly
    func getCurrentLocationForecast(query1: String = "", query2: String = "",
                                    withStatusCode statusCode: Int = 200, vc: UIViewController,
                                    completion: @escaping (Result<ForecastWeatherModel?, APIError>) -> Void) {

        if Reachability.isConnectedToNetwork() {
            guard let request = WeatherAPI.forecast.requestWithQuery(query1: query1, query2: query2) else { return }

            print("Request URL :: ", request.url?.absoluteString ?? "Some thing went wrong")
            self.fetch(with: request, withStatusCode: statusCode, decode: { json -> ForecastWeatherModel? in
                guard let results = json as? ForecastWeatherModel else { return  nil }
                return results
            }, completion: completion)
        } else {
            print("Not reachable")
            Alert.showNoInternetConnection(on: vc)
        }
    }
}
