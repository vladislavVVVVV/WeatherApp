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
        
//        self.tempLabel.font = UIFont(name: ProximaNovaSoftBold, size: 50)
//        self.cityNameLabel.font = UIFont(name: ProximaNovaSemibold, size: 36)
//        
    }
    
}
