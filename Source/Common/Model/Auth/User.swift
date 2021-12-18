//
//  User.swift
//  APPJAM
//
//  Created by 최형우 on 2021/12/18.
//  Copyright © 2021 baegteun. All rights reserved.
//

struct RegisterUser: Codable{
    let userid: String
    let password: String
    let nickname: String
}

struct LoginUser: Codable{
    let userid: String
    let password: String
}
