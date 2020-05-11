//
//  ForecastView.swift
//  WeatherApp
//
//  Created by Uladzislau Yaunevich on 5/11/20.
//  Copyright © 2020 UladzislauCompany. All rights reserved.
//

import UIKit

class ForecastView: UIView {

    @IBOutlet var containtView: UIView!
    @IBOutlet var tableView: UITableView!
    
    
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
            Bundle.main.loadNibNamed("ForecastView", owner: self, options: nil)
            addSubview(containtView)
            containtView.frame = self.bounds
            containtView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        }
        
        public func addCornerRadius() {
            self.layer.cornerRadius = 20
            self.layoutIfNeeded()
            self.clipsToBounds = true
        }
        
        public func removeCornerRadius() {
            self.layer.cornerRadius = 0
            self.layoutSubviews()
            self.clipsToBounds = false
        }
        
    }
