//
//  RegisterLabel.swift
//  APPJAM
//
//  Created by 최형우 on 2021/12/18.
//  Copyright © 2021 baegteun. All rights reserved.
//

import UIKit

final class RegisterLabel: UILabel{
    init(text: String){
        super.init(frame: .zero)
        self.text = text
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLabel() {
        self.textColor = APPJAMAsset.dDeepGrayColor.color
        self.font = UIFont(font: APPJAMFontFamily.NotoSansCJKKR.regular, size: 14)
    }
    
    
}
