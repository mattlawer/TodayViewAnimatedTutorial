//
//  WidgetTutoHeaderView.swift
//  omnistat-2
//
//  Created by Mathieu Bolard on 05/09/2019.
//  Copyright © 2019 mathieu. All rights reserved.
//

import UIKit

public class WidgetTutoPhoneView: UIView {
    let phoneView = UIView()
    let imageView = WidgetTutoView()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.phoneView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.phoneView)
        
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.phoneView.addSubview(self.imageView)
        NSLayoutConstraint.activate([
            phoneView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            phoneView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            phoneView.heightAnchor.constraint(equalTo: self.heightAnchor),
            phoneView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 9/16),
            imageView.centerXAnchor.constraint(equalTo: phoneView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: phoneView.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: phoneView.leadingAnchor, constant: 5*(9/16)),
            imageView.topAnchor.constraint(equalTo: phoneView.topAnchor, constant: 5)
        ])
        self.phoneView.backgroundColor = UIColor.label
        self.phoneView.layer.cornerRadius = 12.5
        self.phoneView.layer.masksToBounds = true
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.layer.cornerRadius = 10.0
        self.imageView.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
