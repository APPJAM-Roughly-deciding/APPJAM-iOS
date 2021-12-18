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

enum userIDExclamanation: String{
    case lowerThanTen = "아이디를 10글자 이하로 입력하세요"
    case containsSpace = "아이디에 공백을 포함할 수 없습니다."
    case none = ""
}
enum passwordExclamanation: String{
    case notValid = "비밀번호에는 알파벳(a-z, A-Z), 숫자, 특수문자만 사용할 수 있습니다."
    case specialCharactor = "비밀번호에는 알파벳(a-z), 숫자, 특수문자가 1개 이상 사용되어야 합니다."
    case between8and32 = "비밀번호는 8~32글자여야 합니다."
    case none = ""
}
final class RegisterReactor: Reactor, Stepper{
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactor
    enum Action{
        case updateUserID(String)
        case updatePassword(String)
        case updateNickname(String)
        case toRegisterIDButtonDidTap
        case toRegisterPasswordButtonDidTap
        case pwdVisiblityButtonDidTap
        case registerButtonDidTap
        case dismissDidTap
    }
    enum Mutation{
        case setUserID(String)
        case setPassword(String)
        case setNickname(String)
        case setPwdVisible
        case setUserIDExclam(userIDExclamanation)
    }
    struct State{
        var nickname: String = ""
        var nicknameIsValid: Bool = false
        
        var userID: String = ""
        var userIdIsValid: Bool = false
        var userIdExclamanation: userIDExclamanation = .lowerThanTen
        
        var password: String = ""
        var passwordIsValid: Bool = false
        var passwordExclamanation: passwordExclamanation = .notValid
        
        var isSecurePwd: Bool = false
    }
    
    var initialState: State = State()
    
}

// MARK: - Mutate
extension RegisterReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updateUserID(id):
            return .of(.setUserID(id), .setUserIDExclam(idExclam(id)))
        case let .updatePassword(pwd):
            return .just(.setPassword(pwd))
        case let .updateNickname(nick):
            return .just(.setNickname(nick))
        case .pwdVisiblityButtonDidTap:
            return .just(.setPwdVisible)
        case .registerButtonDidTap:
            
            return .empty()
        case .dismissDidTap:
            steps.accept(APPJAMStep.loginIsRequired)
            return .empty()
        case .toRegisterIDButtonDidTap:
            steps.accept(APPJAMStep.registerIDIsRequired)
            return .empty()
        case .toRegisterPasswordButtonDidTap:
            steps.accept(APPJAMStep.registerPasswordIsRequired)
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
            newState.userIdIsValid = idValid(id)
        case let .setPassword(pwd):
            let regex = passwordExclam(pwd)
            newState.password = pwd
            newState.passwordIsValid = regex.0
            newState.passwordExclamanation = regex.1
        case let .setNickname(nick):
            newState.nickname = nick
            newState.nicknameIsValid = nicknameValid(nick)
        case .setPwdVisible:
            newState.isSecurePwd = !currentState.isSecurePwd
        case let .setUserIDExclam(exclam):
            newState.userIdExclamanation = exclam
        }
        return newState
    }
}


// MARK: - Method
private extension RegisterReactor{
    func nicknameValid(_ nick: String) -> Bool{
        return nick.count <= 10
    }
    func idValid(_ id: String) -> Bool{
        return id.count <= 10 && !id.contains(" ")
    }
    func idExclam(_ id: String) -> userIDExclamanation{
         if id.contains(" ") {
             return .containsSpace
         }else if id.count > 10 {
             return .lowerThanTen
        }else{
            return .none
        }
    }
    func passwordExclam(_ pwd: String) -> (Bool, passwordExclamanation){
        if pwd.isEmpty{
            return (true, .none)
        }
        var pattern = "^[a-zA-Z0-9~!@#\\$%\\^&\\*\\s]{1,}$"
        var regex = try? NSRegularExpression(pattern: pattern)
        guard let _ = regex?.firstMatch(in: pwd, options: [], range: NSRange(location: 0, length: pwd.count)) else {
            return (false, .notValid)
        }
        pattern = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[\\d])(?=.*[~!@#\\$%\\^&\\*])[\\w~!@#\\$%\\^&\\*]{1,}$"
        regex = try? NSRegularExpression(pattern: pattern)
        guard let _ = regex?.firstMatch(in: pwd, options: [], range: NSRange(location: 0, length: pwd.count)) else {
            return (false, .specialCharactor)
        }
        pattern = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[\\d])(?=.*[~!@#\\$%\\^&\\*])[\\w~!@#\\$%\\^&\\*]{8,32}$"
        regex = try? NSRegularExpression(pattern: pattern)
        guard let _ = regex?.firstMatch(in: pwd, options: [], range: NSRange(location: 0, length: pwd.count)) else {
            return (false, .between8and32)
        
        }
        return (true, .none)
    }
    func requestRegister(){
        // Reigster Task
        steps.accept(APPJAMStep.loginIsRequired)
    }
}
