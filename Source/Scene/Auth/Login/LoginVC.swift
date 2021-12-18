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
import SnapKit
import RxKeyboard

final class LoginVC: baseVC<LoginReactor>{
    // MARK: - Properties
    private let logoImageView = UIImageView()
    
    private let userIDTextField = AuthTextField(placeholder: "id")
    
    private let passwordTextField = AuthTextField(placeholder: "password")
    
    private lazy var authStack = UIStackView(arrangedSubviews: [userIDTextField, passwordTextField]).then {
        $0.axis = .vertical
        $0.spacing = 12
    }
    
    private let pwdVisiblityButton = UIButton()
    
    private let loginButton = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 20
        $0.backgroundColor = UIColor(red: 0.862, green: 0.494, blue: 0.494, alpha: 1)
    }
    
    private let toRegisterButton = UIButton().then {
        $0.titleLabel?.font = UIFont(font: APPJAMFontFamily.NotoSansCJKKR.regular, size: 14)
        $0.attributedTitle(firstPart: "계정이 있으신가요?", secondPart: "가입하기")
    }
    
    private let autoLoginButton = UIButton().then {
        $0.setImage(UIImage(systemName: "checkmark.circle")?.withTintColor(APPJAMAsset.dMainColor.color),for: .normal)
        $0.setTitle("자동로그인", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont(font: APPJAMFontFamily.NotoSansCJKKR.regular, size: 14)
    }
    
    private let guestButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        $0.imageView?.contentMode = .scaleToFill
    }
    
    // MARK: - UI
    override func addView() {
        [
            logoImageView, authStack, pwdVisiblityButton, loginButton,
            toRegisterButton, autoLoginButton, guestButton
        ].forEach{ view.addSubview($0) }
        
    }
    override func setLayout() {
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(bound.height*0.3)
            $0.centerX.equalToSuperview()
        }
        authStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(bound.height*0.4)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        userIDTextField.snp.makeConstraints {
            $0.height.equalTo(44)
        }
        passwordTextField.snp.makeConstraints {
            $0.height.equalTo(44)
        }
        pwdVisiblityButton.snp.makeConstraints {
            $0.trailing.equalTo(passwordTextField.snp.trailing).inset(17)
            $0.centerY.equalTo(passwordTextField)
        }
        autoLoginButton.snp.makeConstraints {
            $0.leading.equalTo(authStack)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(14)
        }
        loginButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(14)
            $0.top.equalTo(authStack.snp.bottom).offset(bound.height*0.0848)
            $0.height.equalTo(44)
        }
        guestButton.snp.makeConstraints {
            $0.top.trailing.equalTo(view.safeAreaLayoutGuide).inset(17)
            $0.width.height.equalTo(56)
        }
        toRegisterButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(loginButton.snp.bottom).offset(20)
        }
    }
    override func configureVC() {
        addObserver()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Keyboard
    private func addObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keybaordRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keybaordRectangle.height
            UIView.animate(withDuration: 0.3, animations: {
                self.view.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight/2)
                
            })
        }
    }
    @objc func keyboardWillHide(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            UIView.animate(withDuration: 0.3, animations: {
                self.view.transform = .identity
            })
        }
    }
    
    
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
        
        autoLoginButton.rx.tap
            .map { Reactor.Action.autoLoginDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        userIDTextField.rx.controlEvent(.editingDidBegin)
            .map { APPJAMAsset.dMainColor.color.cgColor }
            .bind(to: userIDTextField.layer.rx.borderColor)
            .disposed(by: disposeBag)
        
        userIDTextField.rx.controlEvent(.editingDidEnd)
            .map { reactor.currentState.isEmptyUserID }
            .map { $0 ? APPJAMAsset.dGrayColor.color.cgColor : UIColor.black.cgColor}
            .bind(to: userIDTextField.layer.rx.borderColor)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.controlEvent(.editingDidBegin)
            .map { APPJAMAsset.dMainColor.color.cgColor }
            .bind(to: passwordTextField.layer.rx.borderColor)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.controlEvent(.editingDidEnd)
            .map { reactor.currentState.isEmptyPassword }
            .map { $0 ? APPJAMAsset.dGrayColor.color.cgColor : UIColor.black.cgColor}
            .bind(to: passwordTextField.layer.rx.borderColor)
            .disposed(by: disposeBag)
    }
    
    override func bindState(reactor: LoginReactor) {
        let sharedState = reactor.state.share(replay: 5)
        
        sharedState
            .map { !$0.isSecurePwd }
            .bind(to: passwordTextField.rx.isSecureTextEntry)
            .disposed(by: disposeBag)
        
        sharedState
            .map { $0.isSecurePwd}
            .map { $0 ?
                UIImage(systemName: "eye")?.withTintColor(APPJAMAsset.dGrayColor.color, renderingMode: .alwaysOriginal)
                :
                UIImage(systemName: "eye.slash")?.withTintColor(APPJAMAsset.dGrayColor.color, renderingMode: .alwaysOriginal)}
            .bind(to: pwdVisiblityButton.rx.image())
            .disposed(by: disposeBag)
        
        sharedState
            .map { $0.isOnAutoLogin }
            .map { $0 ?
                UIImage(systemName: "checkmark.circle.fill")?.withTintColor(APPJAMAsset.dMainColor.color, renderingMode: .alwaysOriginal)
                :
                UIImage(systemName: "checkmark.circle")?.withTintColor(APPJAMAsset.dMainColor.color, renderingMode: .alwaysOriginal) }
            .bind(to: autoLoginButton.rx.image())
            .disposed(by: disposeBag)
        
        sharedState
            .map { $0.isValidLogin }
            .map { $0 ? APPJAMAsset.dMainColor.color : UIColor(red: 0.862, green: 0.494, blue: 0.494, alpha: 1) }
            .bind(to: loginButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        sharedState
            .map { $0.isValidLogin }
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
            
    }
}
