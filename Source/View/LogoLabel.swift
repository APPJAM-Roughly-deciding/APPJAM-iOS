//
//  LogoLabel.swift
//  APPJAM
//
//  Created by 최형우 on 2021/12/19.
//  Copyright © 2021 baegteun. All rights reserved.
//

import UIKit

final class LogoLabel: UILabel{
    init(){
        super.init(frame: .zero)
        self.text = "등심세 : -끼"
        self.font = UIFont(font: APPJAMFontFamily.GmarketSans.medium, size: 40)
        self.textColor = APPJAMAsset.dMainColor.color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
