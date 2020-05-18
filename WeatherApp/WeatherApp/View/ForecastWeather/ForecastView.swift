//
//  ForecastView.swift
//  WeatherApp
//
//  Created by Uladzislau Yaunevich on 5/11/20.
//  Copyright © 2020 UladzislauCompany. All rights reserved.
//

import UIKit
import SnapKit

class ForecastView: UIView {
    
    lazy var containtView = UIView()
    lazy var tableView = UITableView()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        self.commonInti()
        initializeUI()
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init?(coder:) is not supported")
    }
    
    private func commonInti() {
        addSubview(containtView)
        containtView.frame = self.bounds
        containtView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    private func initializeUI() {
        containtView.addSubview(tableView)
        
        containtView.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(self.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(self.safeAreaLayoutGuide.snp.right)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(containtView.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(containtView.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(containtView.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(containtView.safeAreaLayoutGuide.snp.right)
        }
        
        
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
