//
//  RegisterReactor.swift
//  APPJAM
//
//  Created by 최형우 on 2021/12/18.
//  Copyright © 2021 baegteun. All rights reserved.
//

import Foundation
import ReactorKit
import RxFlow
import RxCocoa

final class RegisterReactor: Reactor, Stepper{
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactor
    enum Action{
        case updateUserID(String)
        case updatePassword(String)
        case updateNickname(String)
        case pwdVisiblityButtonDidTap
        case registerButtonDidTap
    }
    enum Mutation{
        case setUserID(String)
        case setPassword(String)
        case setNickname(String)
        case setPwdVisible
    }
    struct State{
        var userID: String = ""
        var password: String = ""
        var nickname: String = ""
        var isSecurePwd: Bool = false
    }
    
    var initialState: State = State()
    
}

// MARK: - Mutate
extension RegisterReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updateUserID(id):
            return .just(.setUserID(id))
        case let .updatePassword(pwd):
            return .just(.setPassword(pwd))
        case let .updateNickname(nick):
            return .just(.setNickname(nick))
        case .pwdVisiblityButtonDidTap:
            return .just(.setPwdVisible)
        case .registerButtonDidTap:
            
            return .empty()
        }
    }
}

// MARK: - Reduce
extension RegisterReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setUserID(id):
            newState.userID = id
        case let .setPassword(pwd):
            newState.password = pwd
        case let .setNickname(nick):
            newState.nickname = nick
        case .setPwdVisible:
            newState.isSecurePwd = !currentState.isSecurePwd
        }
        return newState
    }
}


// MARK: - Method
private extension RegisterReactor{
        
}
