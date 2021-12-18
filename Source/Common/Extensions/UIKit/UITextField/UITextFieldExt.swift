//
//  UITextFieldExt.swift
//  APPJAM
//
//  Created by 최형우 on 2021/12/18.
//  Copyright © 2021 baegteun. All rights reserved.
//

import UIKit
import SnapKit

extension UITextField{
    func leftSpacing(space: CGFloat){
        let spaceView = UIView()
        spaceView.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalTo(space)
        }
        self.leftView = spaceView
        self.leftViewMode = .always
    }
}
