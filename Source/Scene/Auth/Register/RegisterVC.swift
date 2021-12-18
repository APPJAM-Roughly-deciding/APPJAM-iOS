//
//  RegisterVC.swift
//  APPJAM
//
//  Created by 최형우 on 2021/12/18.
//  Copyright © 2021 baegteun. All rights reserved.
//

import RxCocoa
import UIKit

final class RegisterVC: baseVC<RegisterReactor>{
    // MARK: - Properties
    private let userIDTextField = UITextField()
    
    private let passwordTextFeild = UITextField()
    
    private let pwdVisiblityButton = UIButton()
    
    private let nicknameTextField = UITextField()
    
    private let registerButton = UIButton()
    
    // MARK: - UI
    
    // MARK: - Reactor
    override func bindView(reactor: RegisterReactor) {
        userIDTextField.rx.text
            .orEmpty
            .map { Reactor.Action.updateUserID($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        passwordTextFeild.rx.text
            .orEmpty
            .map { Reactor.Action.updatePassword($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        nicknameTextField.rx.text
            .orEmpty
            .map { Reactor.Action.updateNickname($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        pwdVisiblityButton.rx.tap
            .map { Reactor.Action.pwdVisiblityButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
