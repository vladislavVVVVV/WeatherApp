//
//  ViewController.swift
//  WeatherApp
//
//  Created by Uladzislau Yaunevich on 5/6/20.
//  Copyright © 2020 UladzislauCompany. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    private var viewModel: CurrentWeatherViewModel?
    
    var currentWeatherView = CurrentWeatherView()
    
    var locationManager: CLLocationManager!
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Today"
        
        self.coreLocationSetup()
        // Do any additional setup after loading the view.
    }
    
    // MARK: CoreLocation intitalization
    private func coreLocationSetup() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        //Ask location permission for when in use
        locationManager.requestWhenInUseAuthorization()
    }
    
    // MARK: Get Current Weather WS
    private func fetchCurrentWeather(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        
        WeatherClient.shared.getCurrentLocationWeather(query1: String(lat), query2: String(lon), vc: self, completion: { (result) in
            switch result {
            case .success(let responseObj):
                //initialize CurrentWeatherViewModel
                self.viewModel = CurrentWeatherViewModel(currentWeather: responseObj!)
                self.addCurrentWeatherViews()
                
            case .failure(let error):
                print(error)
                
            }
        })
    }
    
    // MARK: Add Current Weather View to parent view
    private func addCurrentWeatherViews() {
        //init homeView
        currentWeatherView = CurrentWeatherView.init(frame: self.view.bounds)
        
        //Add the view
        self.view.addSubview(currentWeatherView)
        self.viewModel?.view = currentWeatherView
        self.currentWeatherView.shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        //assign value to views label or other stuff
        viewModel?.configure()
    }
    
    // MARK: - TableView Set DataSource and Delegate
    //Tableview MVVM refere link
    //https://github.com/takumi314/Sample-TableView-With-MultipleCell-MVVM
    @objc func shareButtonTapped(){
        let activityViewController:UIActivityViewController = UIActivityViewController(activityItems: [self.viewModel?.prepareStringForShare()], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.currentWeatherView
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo
        ]
        self.present(activityViewController, animated: true, completion: nil)
    }
}



extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locations = \(locations)")
        self.locationManager.stopUpdatingLocation()
        
        if locations.count > 0 {
            if Reachability.isConnectedToNetwork() {
                
                let geoCoder = CLGeocoder()
                let location = CLLocation(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
                geoCoder.reverseGeocodeLocation(location, completionHandler: { placemarks, _ -> Void in
                    // Place details
                    
                    guard let placeMark = placemarks?.first else { return }
                    
                    // City
                    if let city = placeMark.subAdministrativeArea {
                        print(city)
                        self.fetchCurrentWeather(lat: locations[0].coordinate.latitude, lon: locations[0].coordinate.longitude)
                        
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
