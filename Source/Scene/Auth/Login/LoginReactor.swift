//
//  LoginReactor.swift
//  APPJAM
//
//  Created by 최형우 on 2021/12/18.
//  Copyright © 2021 baegteun. All rights reserved.
//

import Foundation
import ReactorKit
import RxFlow
import RxCocoa

final class LoginReactor: Reactor, Stepper{
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactor
    enum Action{
        case updateUserID(String)
        case updatePassword(String)
        case loginButtonDidTap
        case toRegisterButtonDidTap
    }
    enum Mutation{
        case setUserID(String)
        case setPassword(String)
    }
    struct State{
        var userID: String = ""
        var password: String = ""
    }
    
    var initialState: State = State()
    
}

// MARK: - Mutate
extension LoginReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .updateUserID(let id):
            return .just(.setUserID(id))
        case .updatePassword(let pwd):
            return .just(.setPassword(pwd))
        case .loginButtonDidTap:
            
            return .empty()
        case .toRegisterButtonDidTap:
            
            return .empty()
        }
    }
}

// MARK: - Reduce
extension LoginReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setUserID(id):
            newState.userID = id
        case let .setPassword(pwd):
            newState.password = pwd
        }
        return newState
    }
}


// MARK: - Method
private extension LoginReactor{
    
}
