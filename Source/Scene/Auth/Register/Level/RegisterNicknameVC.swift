//
//  RegisterNicknameVC.swift
//  APPJAM
//
//  Created by 최형우 on 2021/12/18.
//  Copyright © 2021 baegteun. All rights reserved.
//

import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift


final class RegisterNicknameVC: baseVC<RegisterReactor>{
    // MARK: - Properties
    private let logoImageView = UIImageView()
    
    private let descriptionLabel = RegisterLabel(text: "사용할 닉네임을 입력해주세요")
    
    private let nicknameTextField = AuthTextField(placeholder: "Nickname")
    
    private let nextButton = RegisterNextButton(title: "다음")
    
    private let dismissButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
    }
    
    private let exclamanationImageView = UIImageView().then {
        $0.image = UIImage(systemName: "exclamationmark.circle")?.withTintColor(APPJAMAsset.dSubMainColor.color, renderingMode: .alwaysOriginal)
        $0.isHidden = true
    }
    
    private let exclamanationLabel = UILabel().then {
        $0.text = "이름을 10글자 이하로 입력하세요."
        $0.font = UIFont(font: APPJAMFontFamily.NotoSansCJKKR.regular, size: 14)
        $0.textColor = APPJAMAsset.dSubMainColor.color
    }
    
    // MARK: - UI
    override func addView() {
        [
            logoImageView, descriptionLabel, nicknameTextField,
            nextButton, dismissButton, exclamanationImageView, exclamanationLabel
        ].forEach{ view.addSubview($0) }
        
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(bound.height*0.1584)
            $0.centerX.equalToSuperview()
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(bound.height*0.1941)
            $0.centerX.equalToSuperview()
        }
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(bound.height*0.0357)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        exclamanationLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(nicknameTextField)
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(4)
        }
        nextButton.snp.makeConstraints {
            $0.top.equalTo(exclamanationLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        dismissButton.snp.makeConstraints {
            $0.top.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        exclamanationImageView.snp.makeConstraints {
            $0.centerY.equalTo(nicknameTextField)
            $0.trailing.equalTo(nicknameTextField.snp.trailing).inset(17)
        }
        
    }
    override func configureVC() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Reactor
    override func bindView(reactor: RegisterReactor) {
        nicknameTextField.rx.text
            .orEmpty
            .observe(on: MainScheduler.asyncInstance)
            .map { Reactor.Action.updateNickname($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        dismissButton.rx.tap
            .map { Reactor.Action.dismissDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .map { Reactor.Action.toRegisterIDButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)   
    }
    override func bindAction(reactor: RegisterReactor) {
        nicknameTextField.rx.controlEvent(.editingDidBegin)
            .map { APPJAMAsset.dMainColor.color.cgColor }
            .bind(to: nicknameTextField.layer.rx.borderColor)
            .disposed(by: disposeBag)
        
        nicknameTextField.rx.controlEvent(.editingDidEnd)
            .map { reactor.currentState.nicknameIsValid }
            .map { $0 ? APPJAMAsset.dGrayColor.color.cgColor : UIColor.black.cgColor }
            .bind(to: nicknameTextField.layer.rx.borderColor)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: RegisterReactor) {
        let sharedState = reactor.state.share(replay: 3).observe(on: MainScheduler.asyncInstance)
        
        sharedState
            .map { $0.nicknameIsValid && $0.nickname.isEmpty == false }
            .map { $0 ? APPJAMAsset.dMainColor.color : APPJAMAsset.dSubMainColor.color }
            .bind(to: nextButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        sharedState
            .map { $0.nicknameIsValid }
            .subscribe(onNext: { [weak self] isValid in
                self?.nextButton.isEnabled = isValid
                self?.exclamanationImageView.isHidden = isValid
            })
            .disposed(by: disposeBag)
        
        sharedState
            .map { $0.nicknameIsValid }
            .map { $0 ? "" : "이름을 10글자 이하로 입력하세요."}
            .bind(to: exclamanationLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    
}
