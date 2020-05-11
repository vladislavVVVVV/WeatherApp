//
//  ForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Uladzislau Yaunevich on 5/11/20.
//  Copyright © 2020 UladzislauCompany. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    @IBOutlet var tempLabel: UILabel!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var imageState: UIImageView!
    lazy var dateFormatterForWSResponse: DateFormatter = {
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    lazy var dateFormatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    
     override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            if #available(iOS 13.0, *) {
                titleLabel.textColor = .label
            } else {
                // Fallback on earlier versions
                titleLabel.textColor = .black
            } //UIColor.init(hexString: AppTextColor)
            
            // Configure the view for the selected state
        }
        
        func configure(weather: ForecastList?) {
            titleLabel.text = Utility.getDateString(stringDate: (weather?.dtTxt)!, dateFormatInput: dateFormatterForWSResponse, dateFormatOutput: dateFormatter)
            tempLabel.text = String(format: "%.1f\(celSymbol)", ((weather?.main?.temp ?? 273.15) - 273.15))
            imageState.image = (weather?.weather![0].iconImage)!
        }
        
    }
