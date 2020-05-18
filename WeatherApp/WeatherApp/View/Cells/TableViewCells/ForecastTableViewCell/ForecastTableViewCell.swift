//
//  ForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Uladzislau Yaunevich on 5/11/20.
//  Copyright © 2020 UladzislauCompany. All rights reserved.
//

import UIKit
import SnapKit

class ForecastTableViewCell: UITableViewCell {
    
    static var customCell = "ForecastTableViewCell"
    
    lazy var tempLabel = UILabel()
    lazy var dateLabel = UILabel()
    lazy var imageState = UIImageView()
    lazy var descLabel = UILabel()
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        imageState.contentMode = .scaleAspectFit
        initializeUI()
        createConstraints()
    }
    
    private func initializeUI() {
        self.addSubviews(tempLabel, dateLabel, imageState, descLabel)
        tempLabel.textColor = .systemBlue
        tempLabel.font = tempLabel.font.withSize(35)
        dateLabel.font = UIFont(name: "GillSans", size: 20)
        descLabel.font = UIFont(name: "GillSans", size: 17)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init?(coder aDecoder: NSCoder)")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if #available(iOS 13.0, *) {
            dateLabel.textColor = .label
        } else {
            dateLabel.textColor = .black
        }
    }
    
    private func createConstraints() {
        
        imageState.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.width.equalTo(imageState.snp.height)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(28)
            make.left.equalTo(imageState.snp.right).offset(20)
        }
        descLabel.snp.makeConstraints { (make) in
            make.top.equalTo(dateLabel.snp.bottom).offset(0)
            make.left.equalTo(imageState.snp.right).offset(20)
        }
        tempLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
        }
        
        
    }
        func configure(weather: ForecastList?) {
            dateLabel.text = Utility.getDateString(stringDate: (weather?.dtTxt)!,
                                                   dateFormatInput: dateFormatterForWSResponse,
                                                   dateFormatOutput: dateFormatter)
            tempLabel.text = String(format: "%.f\(celSymbol)", ((weather?.main?.temp ?? 273.15) - 273.15))
            imageState.image = (weather?.weather![0].iconImage)!
            descLabel.text = (weather?.weather![0].main ?? "Unknown")!
        }
        
}
