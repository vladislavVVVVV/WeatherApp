//
//  SecondViewController.swift
//  WeatherApp
//
//  Created by Uladzislau Yaunevich on 5/10/20.
//  Copyright © 2020 UladzislauCompany. All rights reserved.
//

import UIKit
import CoreLocation

class ForecastViewController: UIViewController {

    private var forecastViewModel: ForecastViewModel?
    var forecastView = ForecastView()
    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.coreLocationSetup()
    }

    private func coreLocationSetup() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
    }

    private func fetchCurrentForecastHourly(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        let loadIndicator = Utility.addLoaderIndicator(on: self)
        ForecastClient.shared.getCurrentLocationForecast(query1: String(lat), query2: String(lon),
                                                         vc: self, completion: { (result) in
                                                            switch result {
                                                            case .success(let responseObj):
                                                                self.forecastViewModel = ForecastViewModel(forecastWeatherModel: responseObj!)
                                                                self.navigationItem.title = self.forecastViewModel?.prepareCity()
                                                                self.addHourlyForecastView()
                                                                DispatchQueue.main.async {
                                                                    loadIndicator.stopAnimating()
                                                                }
                                                            case .failure(let error):
                                                                print(error)
                                                                DispatchQueue.main.async {
                                                                    loadIndicator.stopAnimating()
                                                                }
                                                            }
        })
    }

    private func addHourlyForecastView() {
        forecastView = ForecastView.init(frame: self.view.bounds)
        self.view.addSubview(forecastView)
        self.addTableViewData()
        forecastViewModel?.configure(forecastView)
    }

    private func addTableViewData() {
        self.forecastView.tableView.dataSource = forecastViewModel
        self.forecastView.tableView.delegate = forecastViewModel
        self.forecastView.tableView.estimatedRowHeight = 100
        self.forecastView.tableView.rowHeight = UITableView.automaticDimension

        self.forecastView.tableView.register(ForecastTableViewCell.self, forCellReuseIdentifier: ForecastTableViewCell.customCell)
    }
}

extension ForecastViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locations = \(locations)")
        self.locationManager.stopUpdatingLocation()
        if locations.count > 0 {
            if Reachability.isConnectedToNetwork() {
                let loadIndicator = Utility.addLoaderIndicator(on: self)
                let geoCoder = CLGeocoder()
                let location = CLLocation(latitude: locations[0].coordinate.latitude,
                                          longitude: locations[0].coordinate.longitude)
                geoCoder.reverseGeocodeLocation(location, completionHandler: { placemarks, _ -> Void in
                    DispatchQueue.main.async {
                        loadIndicator.stopAnimating()
                    }
                    guard let placeMark = placemarks?.first else { return }
                    if placeMark.subAdministrativeArea != nil {
                        self.fetchCurrentForecastHourly(lat: locations[0].coordinate.latitude,
                                                        lon: locations[0].coordinate.longitude)
                    }
                    if placeMark.country != nil {
                    }

                })
            } else {
                Alert.somethingWentWrong(on: self)
            }
        }
    }
}
