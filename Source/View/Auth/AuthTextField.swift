//
//  AuthTextField.swift
//  APPJAM
//
//  Created by 최형우 on 2021/12/18.
//  Copyright © 2021 baegteun. All rights reserved.
//

import UIKit

final class AuthTextField: UITextField{
    // MARK: - Properties
    
    
    // MARK: - Init
    init(placeholder: String){
        super.init(frame: .zero)
        self.placeholder = placeholder
        configureTF()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private func configureTF(){
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1
        self.layer.borderColor = APPJAMAsset.dGrayColor.color.cgColor
        
        self.leftSpacing(space: 20)
    }
}
