//
//  APPJAMAPI.swift
//  APPJAM
//
//  Created by 최형우 on 2021/12/18.
//  Copyright © 2021 baegteun. All rights reserved.
//

import Moya

enum APPJAMAPI{
    case postRegister(RegisterUser)
    case putLogin(LoginUser)
    case tokenRefresh
}

extension APPJAMAPI: TargetType{
    var baseURL: URL {
        return "http://13.125.241.207:8080".toURL!
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
        case let.putLogin(user):
            return .requestParameters(parameters: [
                "userid" : user.userid,
                "password" : user.password
            ], encoding: JSONEncoding.default)
        case let .postRegister(user):
            return .requestParameters(parameters: [
                "userid" : user.userid,
                "nickname" : user.nickname,
                "password" : user.password
            ], encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self{
        case .postRegister, .putLogin, .tokenRefresh:
            return nil
        }
    }
    
    
}
