//
//  HomeVC.swift
//  APPJAM
//
//  Created by 최형우 on 2021/12/19.
//  Copyright © 2021 baegteun. All rights reserved.
//

import Foundation
import UIKit
import Then
import SnapKit

final class HomeVC: baseVC<HomeReactor>{
    let image = UIImageView(image: UIImage(named: "a"))
    
    override func addView() {
        view.addSubview(image)
        self.navigationController?.navigationBar.isHidden = true
    }
    override func setLayout() {
        image.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
