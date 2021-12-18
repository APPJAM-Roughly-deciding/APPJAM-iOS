//
//  MainFlow.swift
//  APPJAM
//
//  Created by 최형우 on 2021/12/19.
//  Copyright © 2021 baegteun. All rights reserved.
//

import UIKit

import RxSwift
import RxFlow

final class MainFlow: Flow {
    
    enum TabIndex: Int {
        case home = 0
        case middle = 1
        case setting = 2
    }
    
    var root: Presentable {
        return self.rootViewController
    }
    
    let rootViewController: UITabBarController = .init()
    let homeFlow: HomeFlow
    let chatflow: ChatFlow
    let profileFlow: ProfileFlow
    init() {
        homeFlow = HomeFlow(with: .init())
        chatflow = ChatFlow(with: .init())
        profileFlow = ProfileFlow(with: .init())
    }
    
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asAppJamStep else { return .none }
        
        switch step {
        case .mainTabbarIsRequired:
            return coordinateToMainTabBar()
        default:
            return .none
        }
    }
    
    private func coordinateToMainTabBar() -> FlowContributors {
        // 각각의 Flow들이 created되었을 때 root들을 가져와서 tabbar에 세팅해준다.
        Flows.use(
            homeFlow, chatflow, profileFlow,
            when: .created
        ) { [unowned self] (root1: UINavigationController,
                            root2: UINavigationController,
                            root3: UINavigationController) in
            
            let homeImage: UIImage? = UIImage(named: "house")?.withTintColor(APPJAMAsset.dGrayColor.color, renderingMode: .alwaysOriginal)
            let middleImage: UIImage? = UIImage(named: "ellipsis.bubble")?.withTintColor(APPJAMAsset.dGrayColor.color, renderingMode: .alwaysOriginal)
            let settingImage: UIImage? = UIImage(named: "person.fill")?.withTintColor(APPJAMAsset.dGrayColor.color, renderingMode: .alwaysOriginal)
            
            let homeItem: UITabBarItem = .init(title: nil, image: homeImage, selectedImage: homeImage?.withTintColor(APPJAMAsset.dGrayColor.color, renderingMode: .alwaysOriginal))
            let middleItem: UITabBarItem = .init(title: nil, image: middleImage, selectedImage: middleImage?.withTintColor(APPJAMAsset.dGrayColor.color, renderingMode: .alwaysOriginal))
            let settingItem: UITabBarItem = .init(title: nil, image: settingImage, selectedImage: settingImage?.withTintColor(APPJAMAsset.dGrayColor.color, renderingMode: .alwaysOriginal))
            
            root1.tabBarItem = homeItem
            root2.tabBarItem = middleItem
            root3.tabBarItem = settingItem
            
            self.rootViewController.setViewControllers([root1, root2, root3], animated: true)
        }
        
        return .multiple(flowContributors: [
            .contribute(withNextPresentable: homeFlow, withNextStepper: homeFlow.stepper),
            .contribute(withNextPresentable: chatflow, withNextStepper: chatflow.stepper),
            .contribute(withNextPresentable: profileFlow, withNextStepper: profileFlow.stepper)
        ])
    }
    
}
