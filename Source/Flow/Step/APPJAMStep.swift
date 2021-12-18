//
//  APPJAMStep.swift
//  APPJAM
//
//  Created by 최형우 on 2021/12/18.
//  Copyright © 2021 baegteun. All rights reserved.
//

import RxFlow

enum APPJAMStep: Step{
    // Global
    case alert(title: String?, message: String?)
    case dismiss
    
    // Auth
    case loginIsRequired
    case registerNicknameIsRequired
    case registerIDIsRequired
    case registerPasswordIsRequired
    case errorAlert(title: String?, message: String?)
    
    // Main
    case mainTabbarIsRequired
    case homeIsRequired
    case chatIsRequired
    case profileIsRequired
}
