//
//  RegisterNextButton.swift
//  APPJAM
//
//  Created by 최형우 on 2021/12/18.
//  Copyright © 2021 baegteun. All rights reserved.
//

import UIKit

final class RegisterNextButton: UIButton{
    init(title: String){
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureButton() {
        self.setTitle("다음", for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = APPJAMAsset.dSubMainColor.color
        self.layer.cornerRadius = 20
    }
}
