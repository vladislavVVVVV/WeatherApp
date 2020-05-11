//
//  Utility.swift
//  WeatherApp
//
//  Created by Uladzislau Yaunevich on 5/6/20.
//  Copyright © 2020 UladzislauCompany. All rights reserved.
//

import Foundation
import UIKit

class Utility: NSObject {
    class func getDateString(stringDate: String, dateFormatInput:DateFormatter, dateFormatOutput: DateFormatter) -> String {
        let date = dateFormatInput.date(from: stringDate)
        print("Date from response :: ",date as Any)
        let dateString = dateFormatOutput.string(from: date!)
        return dateString
    }
    
}
