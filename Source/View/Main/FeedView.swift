//
//  FeedView.swift
//  APPJAM
//
//  Created by 최형우 on 2021/12/19.
//  Copyright © 2021 baegteun. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class FeedView: UIView{
    private let imageView = UIImageView()
    
    private let textLabel = UILabel().then {
        $0.font = UIFont(font: APPJAMFontFamily.NotoSansCJKKR.regular, size: 14)
    }
    
    
    init(image: UIImage, category: String, title: String){
        self.imageView.image = image
        let str = NSMutableAttributedString(string: category)
        str.setColorForText(textToFind: category, withColor: APPJAMAsset.dMainColor.color)
        str.setFontForText(textToFind: category, withFont: UIFont(font: APPJAMFontFamily.NotoSansCJKKR.bold, size: 14)!)
        str.append(NSAttributedString(string: title))
        super.init(frame: .zero)
        addView()
    }
    
    override func layoutSubviews() {
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addView(){
        [
            imageView, textLabel
        ].forEach{ addSubview($0) }
    }
    private func setLayout(){
        imageView.snp.makeConstraints {
            $0.width.height.equalTo(184)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
        }
        textLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(imageView)
            $0.top.equalTo(imageView.snp.bottom).inset(3)
        }
    }
    
}
