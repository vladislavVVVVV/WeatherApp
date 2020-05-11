//
//  SecondViewController.swift
//  WeatherApp
//
//  Created by Uladzislau Yaunevich on 5/10/20.
//  Copyright © 2020 UladzislauCompany. All rights reserved.
//

import UIKit
import CoreLocation

class SecondViewController: UIViewController {

        
        private var forecastHourlyViewModel: ForecastViewModel?
        
        
        var forecastView = ForecastView()
        
        var locationManager: CLLocationManager!
        
        //MARK: viewDidLoad
        override func viewDidLoad() {
            super.viewDidLoad()

            self.coreLocationSetup()
            // Do any additional setup after loading the view.
        }

        //MARK: CoreLocation intitalization
        private func coreLocationSetup() {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            
            //Ask location permission for when in use
            locationManager.requestWhenInUseAuthorization()
        }
        
  
        //MARK: Get Current Forecast WS
        private func fetchCurrentForecastHourly(lat: CLLocationDegrees ,lon: CLLocationDegrees) {
            ForecastClient.shared.getCurrentLocationForecast(query1: String(lat), query2: String(lon), vc: self, completion: { (result) in
                switch result {
                case .success(let responseObj):
                    //initialize ForecastViewModel
                    self.forecastHourlyViewModel = ForecastViewModel(forecastWeatherModel:responseObj!)
                    
                    self.addHourlyForecastView()
                case .failure(let error):
                    print(error)
                }
            })
        }

        //MARK: Add Current Weather View to parent view
        private func addHourlyForecastView() {
            //init homeView
            forecastView = ForecastView.init(frame: self.view.bounds)
            
            //Add the view
            self.view.addSubview(forecastView)
            self.addTableViewData()
            
            //assign value to views label or other stuff
            forecastHourlyViewModel?.configure(forecastView)
        }
        

        
        
        //MARK:- TableView Set DataSource and Delegate
        //Tableview MVVM refere link
        //https://github.com/takumi314/Sample-TableView-With-MultipleCell-MVVM
        
        private func addTableViewData() {
            self.forecastView.tableView.dataSource = forecastHourlyViewModel
            self.forecastView.tableView.delegate = forecastHourlyViewModel
            self.forecastView.tableView.estimatedRowHeight = 100
            self.forecastView.tableView.rowHeight = UITableView.automaticDimension
            
            self.forecastView.tableView.register(UINib(nibName: "ForecastTableViewCell", bundle: nil), forCellReuseIdentifier: "ForecastTableViewCell")
        }
    }

    extension SecondViewController: CLLocationManagerDelegate {
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            print("locations = \(locations)")
            self.locationManager.stopUpdatingLocation()
            
            if locations.count > 0 {
                if Reachability.isConnectedToNetwork() {
                    let geoCoder = CLGeocoder()
                    let location = CLLocation(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
                    geoCoder.reverseGeocodeLocation(location, completionHandler: { placemarks, error -> Void in
                        // Place details
                        
        
                        
                        guard let placeMark = placemarks?.first else { return }
                        
                        // City
                        if let city = placeMark.subAdministrativeArea {
                            print(city)
                            self.fetchCurrentForecastHourly(lat: locations[0].coordinate.latitude, lon: locations[0].coordinate.longitude)
                            
                        }
                        // Country
                        if let country = placeMark.country {
                            print(country)
                        }
                        
                    })
                } else {
                    Alert.somethingWentWrong(on: self)
                }
            }
        }
    }
