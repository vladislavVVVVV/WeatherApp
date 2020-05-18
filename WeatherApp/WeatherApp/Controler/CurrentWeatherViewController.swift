//
//  ViewController.swift
//  WeatherApp
//
//  Created by Uladzislau Yaunevich on 5/6/20.
//  Copyright © 2020 UladzislauCompany. All rights reserved.
//

import UIKit
import CoreLocation

class CurrentWeatherViewController: UIViewController {

    private var viewModel: CurrentWeatherViewModel?

    var currentWeatherView = CurrentWeatherView()
    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Today"
        self.coreLocationSetup()

    }

    private func coreLocationSetup() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
    }

    private func fetchCurrentWeather(lat: CLLocationDegrees, lon: CLLocationDegrees) {

        let loadIndicator = Utility.addLoaderIndicator(on: self)

        WeatherClient.shared.getCurrentLocationWeather(query1: String(lat), query2: String(lon), vc: self, completion: { (result) in
            switch result {
            case .success(let responseObj):
                self.viewModel = CurrentWeatherViewModel(currentWeather: responseObj!)
                self.addCurrentWeatherViews()
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

    private func addCurrentWeatherViews() {
        currentWeatherView = CurrentWeatherView.init(frame: self.view.bounds)
        self.view.addSubview(currentWeatherView)
        self.viewModel?.currentWeatherView = currentWeatherView
        self.currentWeatherView.shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        viewModel?.configure()
    }

    @objc func shareButtonTapped() {
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [self.viewModel?.prepareStringForShare()], applicationActivities: nil)
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

extension CurrentWeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locations = \(locations)")
        self.locationManager.stopUpdatingLocation()

        if locations.count > 0 {
            if Reachability.isConnectedToNetwork() {
                let loadIndicator = Utility.addLoaderIndicator(on: self)
                let geoCoder = CLGeocoder()
                let location = CLLocation(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
                geoCoder.reverseGeocodeLocation(location, completionHandler: { placemarks, _ -> Void in
                    DispatchQueue.main.async {
                        loadIndicator.stopAnimating()
                    }
                    guard let placeMark = placemarks?.first else { return }
                    if let city = placeMark.subAdministrativeArea {
                        self.fetchCurrentWeather(lat: locations[0].coordinate.latitude, lon: locations[0].coordinate.longitude)
                    }
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
