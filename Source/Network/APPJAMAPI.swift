//
//  APPJAMAPI.swift
//  APPJAM
//
//  Created by 최형우 on 2021/12/18.
//  Copyright © 2021 baegteun. All rights reserved.
//

import Moya

enum APPJAMAPI{
    case postRegister
    case putLogin
    case tokenRefresh
}

extension APPJAMAPI: TargetType{
    var baseURL: URL {
        return "".toURL!
    }
    
    var path: String {
        switch self{
        case .putLogin:
            return "/user/auth"
        case .postRegister:
            return "/user/auth"
        case .tokenRefresh:
            return "/user/auth"
        default:
            return ""
        }
    }
    
    var method: Method {
        switch self{
        case .putLogin:
            return .put
        case .postRegister:
            return .post
        case .tokenRefresh:
            return .patch
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self{
            
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
    
}
