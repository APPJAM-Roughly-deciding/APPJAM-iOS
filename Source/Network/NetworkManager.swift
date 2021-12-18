//
//  NetworkManager.swift
//  APPJAM
//
//  Created by 최형우 on 2021/12/19.
//  Copyright © 2021 baegteun. All rights reserved.
//

import Moya
import RxSwift

protocol NetworkManagerType: class{
    var provider: MoyaProvider<APPJAMAPI> { get }
    
    func postRegister(_ user: RegisterUser) -> Observable<Response>
    func putLogin(_ user: LoginUser) -> Observable<Response>
}

final class NetworkManager: NetworkManagerType{
    let provider: MoyaProvider<APPJAMAPI> = .init()
    
    static let shared = NetworkManager()
    
    func postRegister(_ user: RegisterUser) -> Observable<Response> {
        return provider.rx.request(.postRegister(user), callbackQueue: .global())
            .asObservable()
    }
    
    func putLogin(_ user: LoginUser) -> Observable<Response> {
        return provider.rx.request(.putLogin(user), callbackQueue: .global())
            .asObservable()
    }
}
