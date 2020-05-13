//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by Uladzislau Yaunevich on 5/11/20.
//  Copyright © 2020 UladzislauCompany. All rights reserved.
//

import Foundation
import UIKit

class ForecastViewModel: NSObject {

    private var forecastWeatherModel: ForecastWeatherModel
    private var forecastView: ForecastView?
    
   

    // we set a variable to hold the contentOffSet before scroll view scrolls
    var lastContentOffset: CGFloat = 0
    
   
        
    private let swipeUp = UISwipeGestureRecognizer() // Swipe Up gesture recognizer
    private let swipeDown = UISwipeGestureRecognizer() // Swipe Down gesture recognizer OR You can use single Swipe Gesture
    
    public init(forecastWeatherModel: ForecastWeatherModel) {
        self.forecastWeatherModel = forecastWeatherModel
        
    }
    
}

extension ForecastViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.forecastWeatherModel.list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastTableViewCell", for: indexPath) as? ForecastTableViewCell {
            cell.configure(weather: self.forecastWeatherModel.list?[indexPath.row])
            print(self.forecastWeatherModel.list?[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
  
    
    // this delegate is called when the scrollView (i.e your UITableView) will start scrolling
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.y
    }
}

extension ForecastViewModel: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //set tableview cell height dynamic or constant, currently it's set to constant height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension ForecastViewModel {
    //default configure view for HourlyForecastView
    public func configure(_ view: ForecastView) {
        self.forecastView = view
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        swipeUp.addTarget(self, action:  #selector(self.respondToSwipeGesture))
        view.addGestureRecognizer(swipeUp) // Or assign to view
        
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        swipeDown.addTarget(self, action:  #selector(self.respondToSwipeGesture))
        view.addGestureRecognizer(swipeDown) // Or assign to view
        
        if view.frame.origin.y == 0 {
            view.tableView.isUserInteractionEnabled = true
        } else {
            view.tableView.isUserInteractionEnabled = false
        }
    }
    
    //manage swipe gesture on HourlyForecastView
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if let view = gesture.view as? ForecastView {
               forecastView = view
                switch swipeGesture.direction {
                case UISwipeGestureRecognizer.Direction.right:
//                    print("Swiped right")
                    break
                case UISwipeGestureRecognizer.Direction.left:
//                    print("Swiped left")
                    break
                case UISwipeGestureRecognizer.Direction.down:
//                    print("Swiped down")
                    self.addAnitmationToView(view: view, yPosition: view.frame.size.height - 250)

                case UISwipeGestureRecognizer.Direction.up:
//                    print("Swiped up")
                    view.tableView.isUserInteractionEnabled = true
                    self.addAnitmationToView(view: view, yPosition: 0)
                default:
                    break
                }
            }
        }
    }
    
    //Add view position change animation
    private func addAnitmationToView(view: ForecastView, yPosition: CGFloat) {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseIn], animations: {
            view.frame = CGRect(x: view.frame.origin.x, y: yPosition, width: view.frame.size.width, height: view.frame.size.height)
        }) { (finished) in
            if yPosition != 0 {
                view.addCornerRadius()
            } else {
                view.removeCornerRadius()
            }
        }
    }
    
    public var countryName: String {
        return forecastWeatherModel.city?.name ?? "Unknown"
     }
    
    public func prepareCity() -> String {
           var str = ""
           str += countryName
           return str
       }
       
    
}
