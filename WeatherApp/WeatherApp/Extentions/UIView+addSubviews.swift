//
//  UIView+addSubviews.swift
//  WeatherApp
//
//  Created by Uladzislau Yaunevich on 5/17/20.
//  Copyright © 2020 UladzislauCompany. All rights reserved.
//

import UIKit

extension UIView {
    
    public func addSubviews(_ views: UIView...) {
        addSubviews(views)
    }
    
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
    
}
