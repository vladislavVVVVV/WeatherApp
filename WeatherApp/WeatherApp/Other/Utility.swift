//
//  Utility.swift
//  WeatherApp
//
//  Created by Uladzislau Yaunevich on 5/6/20.
//  Copyright © 2020 UladzislauCompany. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class Utility: NSObject {
    class func getDateString(stringDate: String, dateFormatInput: DateFormatter,
                             dateFormatOutput: DateFormatter) -> String {
        let date = dateFormatInput.date(from: stringDate)
       // print("Date from response :: ",date as Any)
        let dateString = dateFormatOutput.string(from: date!)
        return dateString
    }

    class func addLoaderIndicator(on vc: UIViewController) -> NVActivityIndicatorView {
        let loadingIndicator = NVActivityIndicatorView(frame: .zero, type: .ballClipRotate, color: .gray, padding: 0)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        vc.view.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.widthAnchor.constraint(equalToConstant: 40),
            loadingIndicator.heightAnchor.constraint(equalToConstant: 40),
            loadingIndicator.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor),
            loadingIndicator.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor)
        ])
        loadingIndicator.startAnimating()
        return loadingIndicator
    }

}
