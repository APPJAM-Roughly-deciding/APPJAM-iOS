//
//  UIButtonExt.swift
//  APPJAM
//
//  Created by 최형우 on 2021/12/18.
//  Copyright © 2021 baegteun. All rights reserved.
//

import UIKit

extension UIButton{
    func attributedTitle(firstPart: String, secondPart: String){
        let atts: [NSAttributedString.Key: Any] = [
            .foregroundColor: APPJAMAsset.dDeepGrayColor.color,
            .font: UIFont(font: APPJAMFontFamily.NotoSansCJKKR.regular, size: 14)
        ]
        let attributedTitle = NSMutableAttributedString(string: "\(firstPart) ", attributes: atts)
        let boldAtts: [NSAttributedString.Key: Any] = [
            .foregroundColor: APPJAMAsset.dMainColor.color,
            .font: UIFont(font: APPJAMFontFamily.NotoSansCJKKR.regular, size: 14)
        ]
        attributedTitle.append(NSAttributedString(string: secondPart, attributes: boldAtts))
        setAttributedTitle(attributedTitle, for: .normal)
        
    }
}
