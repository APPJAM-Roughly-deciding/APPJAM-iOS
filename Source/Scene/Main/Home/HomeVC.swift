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
    let image = UIImageView(image: APPJAMAsset.topTabbar.image)
    
    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let feed1 = UIStackView(arrangedSubviews: [
        FeedView(image: APPJAMAsset.rlaclWlro.image, category: "목살", title: "김치찌개로 얼큰하게 해장합시다."),
        FeedView(image: APPJAMAsset.tkxo.image, category: "사태", title: "가성비 갑 돼지국밥"),
        FeedView(image: APPJAMAsset.eobotkaruqakfdl.image, category: "삼겹살", title: "대패삼겹말이를 만들어봅시다")
    ]).then {
        $0.axis = .vertical
        $0.spacing = 30
    }
    private let feed2 = UIStackView(arrangedSubviews: [
        FeedView(image: APPJAMAsset.tndbr.image, category: "앞다리", title: "김장철엔 역시 수육!!"),
        FeedView(image: APPJAMAsset.tkxo.image, category: "삼겹살", title: "돼지갈비의 달달한 양념이 일품"),
        FeedView(image: APPJAMAsset.eobotkaruqakfdl.image, category: "삼겹살", title: "한국인이 가장 사랑하는 고기")
    ]).then {
        $0.axis = .vertical
        $0.spacing = 30
    }
    
    override func addView() {
        view.addSubview(image)
        view.addSubview(scrollView)
        [
            feed1, feed2
        ].forEach{ view.addSubview($0) }
        
    }
    override func setLayout() {
        image.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview()
        }
        scrollView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(image.snp.bottom)
        }
        feed1.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(50)
            $0.top.equalToSuperview().inset(10)
        }
        feed2.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(50)
            $0.top.equalToSuperview().inset(10)
        }
    }
}
