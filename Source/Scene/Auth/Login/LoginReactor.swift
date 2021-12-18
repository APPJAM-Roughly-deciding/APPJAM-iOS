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
        case pwdVisiblityButtonDidTap
        case loginButtonDidTap
        case toRegisterButtonDidTap
        case autoLoginDidTap
        case guestDidTap

    }
    enum Mutation{
        case setUserID(String)
        case setPassword(String)
        case setPwdVisible
        case setAuthLogin
        case setValid
    }
    struct State{
        var userID: String = ""
        var password: String = ""
        var isSecurePwd: Bool = false
        var isOnAutoLogin: Bool = false
        var isValidLogin: Bool = false
        var isEmptyUserID: Bool = true
        var isEmptyPassword: Bool = true
    }
    
    var initialState: State = State()
    
}

// MARK: - Mutate
extension LoginReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .updateUserID(let id):
            return .of(.setUserID(id), .setValid)
        case .updatePassword(let pwd):
            return .of(.setPassword(pwd), .setValid)
        case .pwdVisiblityButtonDidTap:
            return .just(.setPwdVisible)
        case .loginButtonDidTap:
            loginDidTap()
            return .empty()
        case .toRegisterButtonDidTap:
            steps.accept(APPJAMStep.registerNicknameIsRequired)
            return .empty()
        case .autoLoginDidTap:
            return .just(.setAuthLogin)
        case .guestDidTap:
            
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
            newState.isEmptyUserID = id.isEmpty
        case let .setPassword(pwd):
            newState.password = pwd
            newState.isEmptyPassword = pwd.isEmpty
        case .setPwdVisible:
            newState.isSecurePwd = !currentState.isSecurePwd
        case .setAuthLogin:
            newState.isOnAutoLogin = !currentState.isOnAutoLogin
        case .setValid:
            newState.isValidLogin = loginValid()
        }
        return newState
    }
}


// MARK: - Method
private extension LoginReactor{
    func loginDidTap() {
        print("as")
    }
    func loginValid() -> Bool{
        return currentState.userID.isEmpty == false && currentState.password.isEmpty == false
    }
}
