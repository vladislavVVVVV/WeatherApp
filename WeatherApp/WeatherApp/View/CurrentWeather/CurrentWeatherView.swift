//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by Uladzislau Yaunevich on 5/6/20.
//  Copyright © 2020 UladzislauCompany. All rights reserved.
//

import UIKit

class CurrentWeatherView: UIView {

    @IBOutlet var containtView: UIView!
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var pressureLabel: UILabel!
    @IBOutlet var maxTemp: UILabel!
    @IBOutlet var speedWindLabel: UILabel!
    @IBOutlet var degreeWind: UILabel!
    
    @IBOutlet var shareButton: UIButton!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        self.commonInti()
    }
    

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init?(coder:) is not supported")
    }

    private func commonInti() {
        Bundle.main.loadNibNamed("CurrentWeatherView", owner: self, options: nil)
        addSubview(containtView)
        containtView.frame = self.bounds
        containtView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
