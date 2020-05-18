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

    var sections = [String: [ForecastList]]()
    var sortedSections = [String]()
    var lastContentOffset: CGFloat = 0

    private let swipeUp = UISwipeGestureRecognizer()
    private let swipeDown = UISwipeGestureRecognizer()

    public init(forecastWeatherModel: ForecastWeatherModel) {
        self.forecastWeatherModel = forecastWeatherModel
        for item in forecastWeatherModel.list! {
            let dateFormatterIn = DateFormatter()
            dateFormatterIn.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateFormatterOut = DateFormatter()
            dateFormatterOut.dateFormat = "dd-MM-yyyy"
            let date = Utility.getDateString(stringDate: item.dtTxt!, dateFormatInput: dateFormatterIn, dateFormatOutput: dateFormatterOut)
            self.sections[date, default: []].append(item)
        }
        self.sortedSections = Array(self.sections.keys).sorted(by: <)
    }
}

extension ForecastViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = .white
        let label = UILabel()
        label.frame = CGRect.init(x: 20, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.font = UIFont(name: "GillSans", size: 20)
        let sec = sortedSections[section]
        let dateFormatterIn = DateFormatter()
        dateFormatterIn.dateFormat = "dd-MM-yyyy"
        let dateFormatterOut = DateFormatter()
        dateFormatterOut.dateFormat = "EEEE"
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let todayDate = formatter.string(from: date)
        if sec == todayDate {
            label.text = "TODAY"
            headerView.addSubview(label)
        } else {
            let dateSectionName = Utility.getDateString(stringDate: sec, dateFormatInput: dateFormatterIn, dateFormatOutput: dateFormatterOut)
            label.text = dateSectionName.uppercased()
            headerView.addSubview(label)
        }
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let num = sections[sortedSections[section]] else {
            return 0
        }
        return num.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastTableViewCell",
                                                    for: indexPath) as? ForecastTableViewCell {
            let tableSection = sections[sortedSections[indexPath.section]]
            if let tableItem = tableSection {
                cell.configure(weather: tableItem[indexPath.row])
            }
            return cell
        }
        return UITableViewCell()
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.y
    }
}

extension ForecastViewModel: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

extension ForecastViewModel {
    public func configure(_ view: ForecastView) {
        self.forecastView = view
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        swipeUp.addTarget(self, action: #selector(self.respondToSwipeGesture))
        view.addGestureRecognizer(swipeUp)

        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        swipeDown.addTarget(self, action: #selector(self.respondToSwipeGesture))
        view.addGestureRecognizer(swipeDown)

        if view.frame.origin.y == 0 {
            view.tableView.isUserInteractionEnabled = true
        } else {
            view.tableView.isUserInteractionEnabled = false
        }
    }

    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if let view = gesture.view as? ForecastView {
               forecastView = view
                switch swipeGesture.direction {
                case UISwipeGestureRecognizer.Direction.right:
                    break
                case UISwipeGestureRecognizer.Direction.left:
                    break
                case UISwipeGestureRecognizer.Direction.down:
                    self.addAnitmationToView(view: view, yPosition: view.frame.size.height - 250)

                case UISwipeGestureRecognizer.Direction.up:
                    view.tableView.isUserInteractionEnabled = true
                    self.addAnitmationToView(view: view, yPosition: 0)
                default:
                    break
                }
            }
        }
    }

    private func addAnitmationToView(view: ForecastView, yPosition: CGFloat) {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseIn], animations: {
            view.frame = CGRect(x: view.frame.origin.x, y: yPosition, width: view.frame.size.width,
                                height: view.frame.size.height)
        }) { (_) in
            if yPosition != 0 {
                view.addCornerRadius()
            } else {
                view.removeCornerRadius()
            }
        }
    }

    public var cityName: String {
        return forecastWeatherModel.city?.name ?? "Unknown"
     }

    public func prepareCity() -> String {
           var str = ""
           str += cityName
           return str
       }

    private func firstDayOfMonth(stringDate: String) -> Date {
        let dateFormatter = DateFormatter()
        let date = dateFormatter.date(from: stringDate)!
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }

}
