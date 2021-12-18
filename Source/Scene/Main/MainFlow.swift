//
//  MainFlow.swift
//  APPJAM
//
//  Created by 최형우 on 2021/12/18.
//  Copyright © 2021 baegteun. All rights reserved.
//

import RxFlow

final class MainFlow: Flow{
    // MARK: - TabIndex
    enum TabIndex: Int{
        case Home = 0
        case chat = 1
        case profile = 2
    }
    
    // MARK: - Properties
    
    var root: Presentable {
        return self.rootViewController
    }
    
    let rootViewController: UITabBarController = .init()
    // Flows
    
    // MARK: - Init
    init(){
        // init Flows
    }
    
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    
    // MARK: - Navigate
}
