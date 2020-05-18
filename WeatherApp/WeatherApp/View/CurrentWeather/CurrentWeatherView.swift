//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by Uladzislau Yaunevich on 5/6/20.
//  Copyright © 2020 UladzislauCompany. All rights reserved.
//

import UIKit
import SnapKit

class CurrentWeatherView: UIView {
    
    lazy var containtView = UIView()
    lazy var weatherImage = UIImageView()
    lazy var cityNameLabel = UILabel()
    lazy var tempLabel = UILabel()
    lazy var firstLine = UIImageView()
    lazy var secondLine = UIImageView()
    lazy var firstStackView = UIStackView()
    lazy var secondStackView = UIStackView()
    lazy var humidityImage = UIImageView()
    lazy var pressureImage = UIImageView()
    lazy var rainImage = UIImageView()
    lazy var humidityLabel = UILabel()
    lazy var pressureLabel = UILabel()
    lazy var rainLevel = UILabel()
    lazy var speedWindLabel = UILabel()
    lazy var degreeWindLabel = UILabel()
    lazy var speedWindImage = UIImageView()
    lazy var degreeWindImage = UIImageView()
    lazy var shareButton = UIButton()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        initializeUI()
        createConstraints()
        self.commonInti()
        
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init?(coder:) is not supported")
    }
    
    private func initializeUI() {
        containtView.addSubview(tempLabel)
    
        tempLabel.font = UIFont(name: "HelveticaNeue-Light", size: 30)
        tempLabel.textColor = .systemBlue
        cityNameLabel.font = UIFont(name: "GillSans-Light", size: 20)
        humidityLabel.font  = UIFont(name: "GillSans-Light", size: 20)
        pressureLabel.font  = UIFont(name: "GillSans-Light", size: 20)
        rainLevel.font  = UIFont(name: "GillSans-Light", size: 20)
        speedWindLabel.font  = UIFont(name: "GillSans-Light", size: 20)
        degreeWindLabel.font  = UIFont(name: "GillSans-Light", size: 20)
     
        
        containtView.addSubviews(weatherImage, cityNameLabel, firstLine,
                                 secondLine, firstStackView, secondStackView,
                                 shareButton, secondLine)
        
        prepareImageView(weatherImage, with: "Sun")
        prepareImageView(humidityImage, with: "Humidity")
        prepareImageView(pressureImage, with: "Pressure")
        prepareImageView(degreeWindImage, with: "DegreeWind")
        prepareImageView(speedWindImage, with: "WindSpeed")
        prepareImageView(rainImage, with: "RainLevel")
        prepareImageView(firstLine, with: "Line")
        prepareImageView(secondLine, with: "Line")
        
        prepareHorisontalStackView(firstStackView)
        prepareHorisontalStackView(secondStackView)
        
        firstStackView.addArrangedSubview(humidityImage)
        firstStackView.addArrangedSubview(rainImage)
        firstStackView.addArrangedSubview(pressureImage)
        
        secondStackView.addArrangedSubview(speedWindImage)
        secondStackView.addArrangedSubview(degreeWindImage)
        
        firstStackView.addSubviews(rainLevel, humidityLabel, pressureLabel)
        secondStackView.addSubviews(speedWindLabel, degreeWindLabel)
        
        shareButton.setTitle("Share", for: .normal)
        shareButton.setTitleColor(UIColor.orange, for: .normal)
        shareButton.setTitleColor(UIColor.white, for: .highlighted)
    }
    
    private func prepareImageView(_ imageView: UIImageView, with name: String) {
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: name)
    }
    
    private func prepareHorisontalStackView(_ stackView: UIStackView) {
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
    }
    
    private func commonInti() {
        addSubview(containtView)
        containtView.frame = self.bounds
        containtView.backgroundColor = .white
        containtView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        containtView.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(self.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(self.safeAreaLayoutGuide.snp.right)
        }
    }
    
    private func createConstraints() {
        weatherImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(weatherImage.snp.height)
            make.top.equalTo(40)
        }
        
        cityNameLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(weatherImage.snp.bottom).offset(8)
        }
        
        tempLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(cityNameLabel.snp.bottom).offset(8)
        }
        
        firstLine.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(cityNameLabel.snp.bottom).offset(100)
            make.width.equalTo(165)
            make.height.equalTo(5.5)
        }
        
        firstStackView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(firstLine.snp.bottom).offset(20)
            make.width.equalTo(250)
        }
        
        humidityImage.snp.makeConstraints { (make) in
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        pressureImage.snp.makeConstraints { (make) in
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        rainImage.snp.makeConstraints { (make) in
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        rainLevel.snp.makeConstraints { (make) in
            make.top.equalTo(rainImage.snp.bottom).offset(2)
            make.centerX.equalTo(rainImage.snp.centerX)
        }
        
        humidityLabel.snp.makeConstraints { (make) in
            make.top.equalTo(humidityImage.snp.bottom).offset(2)
            make.centerX.equalTo(humidityImage.snp.centerX)
        }
        
        pressureLabel.snp.makeConstraints { (make) in
            make.top.equalTo(pressureImage.snp.bottom).offset(2)
            make.centerX.equalTo(pressureImage.snp.centerX)
        }
        
        secondStackView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(pressureLabel.snp.bottom).offset(20)
            make.width.equalTo(150)
        }
        
        speedWindImage.snp.makeConstraints { (make) in
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        degreeWindImage.snp.makeConstraints { (make) in
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        speedWindLabel.snp.makeConstraints { (make) in
            make.top.equalTo(speedWindImage.snp.bottom).offset(2)
            make.centerX.equalTo(speedWindImage.snp.centerX)
        }
        
        degreeWindLabel.snp.makeConstraints { (make) in
            make.top.equalTo(degreeWindImage.snp.bottom).offset(2)
            make.centerX.equalTo(degreeWindImage.snp.centerX)
        }
        
        secondLine.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(degreeWindLabel.snp.bottom).offset(20)
            make.width.equalTo(165)
            make.height.equalTo(5.5)
        }
        
        shareButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(secondLine.snp.bottom).offset(35)
        }
    }
}

