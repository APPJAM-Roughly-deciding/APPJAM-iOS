//
//  RegisterPasswordVC.swift
//  APPJAM
//
//  Created by 최형우 on 2021/12/18.
//  Copyright © 2021 baegteun. All rights reserved.
//

import UIKit
import Then
import SnapKit
import RxCocoa
import RxSwift

final class RegisterPasswordVC: baseVC<RegisterReactor>{
    // MARK: - Properties
    private let logoImageView = UIImageView()
    
    private let descriptionLabel = RegisterLabel(text: "사용할 비밀번호를 입력해주세요")
    
    private let PasswordTextField = AuthTextField(placeholder: "password")
    
    private let nextButton = RegisterNextButton(title: "완료")
    
    private let exclamanationImageView = UIImageView().then {
        $0.image = UIImage(systemName: "exclamationmark.circle")?.withTintColor(APPJAMAsset.dSubMainColor.color, renderingMode: .alwaysOriginal)
    }
    
    private let exclamanationLabel = UILabel().then {
        $0.text = ""
        $0.font = UIFont(font: APPJAMFontFamily.NotoSansCJKKR.regular, size: 14)
        $0.textColor = APPJAMAsset.dSubMainColor.color
    }
    
    // MARK: - UI
    override func addView() {
        [
            logoImageView, descriptionLabel, PasswordTextField, nextButton,
            exclamanationLabel, exclamanationImageView
        ].forEach{ view.addSubview($0) }
    }
    override func setLayout() {
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(bound.height*0.1584)
            $0.centerX.equalToSuperview()
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(bound.height*0.1941)
            $0.centerX.equalToSuperview()
        }
        PasswordTextField.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(bound.height*0.0357)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        exclamanationLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(PasswordTextField)
            $0.top.equalTo(PasswordTextField.snp.bottom).offset(4)
        }
        nextButton.snp.makeConstraints {
            $0.top.equalTo(exclamanationLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        exclamanationImageView.snp.makeConstraints {
            $0.centerY.equalTo(PasswordTextField)
            $0.trailing.equalTo(PasswordTextField.snp.trailing).inset(17)
        }
    }
    override func configureVC() {
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    // MARK: - Reactor
    override func bindView(reactor: RegisterReactor) {
        PasswordTextField.rx.text
            .orEmpty
            .observe(on: MainScheduler.asyncInstance)
            .map { Reactor.Action.updatePassword($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .map { Reactor.Action.registerButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
    }
    
    override func bindAction(reactor: RegisterReactor) {
        PasswordTextField.rx.controlEvent(.editingDidBegin)
            .map { APPJAMAsset.dMainColor.color.cgColor }
            .bind(to: PasswordTextField.layer.rx.borderColor)
            .disposed(by: disposeBag)
        
        PasswordTextField.rx.controlEvent(.editingDidEnd)
            .map { reactor.currentState.passwordIsValid }
            .map { $0 ? APPJAMAsset.dGrayColor.color.cgColor : UIColor.black.cgColor }
            .bind(to: PasswordTextField.layer.rx.borderColor)
            .disposed(by: disposeBag)
    }
    
    override func bindState(reactor: RegisterReactor) {
        let sharedState = reactor.state.share(replay: 3).observe(on: MainScheduler.asyncInstance)
        
        sharedState
            .map { $0.passwordIsValid && $0.password.isEmpty == false }
            .map { $0 ? APPJAMAsset.dMainColor.color : APPJAMAsset.dSubMainColor.color }
            .bind(to: nextButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        sharedState
            .map { $0.passwordIsValid }
            .subscribe(onNext: { [weak self] isValid in
                self?.nextButton.isEnabled = isValid
                self?.exclamanationImageView.isHidden = isValid
            })
            .disposed(by: disposeBag)
        
        sharedState
            .map { $0.passwordExclamanation.rawValue }
            .bind(to: exclamanationLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
