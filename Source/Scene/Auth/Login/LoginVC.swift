//
//  LoginVC.swift
//  APPJAM
//
//  Created by 최형우 on 2021/12/18.
//  Copyright © 2021 baegteun. All rights reserved.
//

import UIKit
import RxCocoa
import Then

final class LoginVC: baseVC<LoginReactor>{
    // MARK: - Properties
    private let userIDTextField = UITextField()
    
    private let passwordTextField = UITextField()
    
    private let pwdVisiblityButton = UIButton().then {
        $0.setImage(UIImage(systemName: "eye"), for: .normal)
    }
    
    private let loginButton = UIButton()
    
    private let toRegisterButton = UIButton()
    
    // MARK: - UI
    
    // MARK: - Reactor
    override func bindView(reactor: LoginReactor) {
        userIDTextField.rx.text
            .orEmpty
            .map { Reactor.Action.updateUserID($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .orEmpty
            .map { Reactor.Action.updatePassword($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        pwdVisiblityButton.rx.tap
            .map { Reactor.Action.pwdVisiblityButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .map { Reactor.Action.loginButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        toRegisterButton.rx.tap
            .map { Reactor.Action.toRegisterButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
    }
    
    override func bindState(reactor: LoginReactor) {
        let sharedState = reactor.state.share(replay: 2)
        
        sharedState
            .map { !$0.pwdVisible }
            .bind(to: passwordTextField.rx.isSecureTextEntry)
            .disposed(by: disposeBag)
        
        sharedState
            .map { $0.pwdVisible}
            .map { $0 ? UIImage(systemName: "eye.slash") : UIImage(systemName: "eye")}
            .bind(to: pwdVisiblityButton.rx.image())
            .disposed(by: disposeBag)
        
        
    }
}
