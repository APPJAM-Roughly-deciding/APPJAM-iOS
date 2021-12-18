//
//  RegisterIDVC.swift
//  APPJAM
//
//  Created by 최형우 on 2021/12/18.
//  Copyright © 2021 baegteun. All rights reserved.
//

import UIKit
import RxCocoa
import SnapKit
import Then
import RxSwift

final class RegisterIDVC: baseVC<RegisterReactor>{
    // MARK: - Properties
    private let logoImageView = UIImageView()
    
    private let descriptionLabel = RegisterLabel(text: "사용할 아이디를 입력해주세요")
    
    private let IDTextField = AuthTextField(placeholder: "id")
    
    private let nextButton = RegisterNextButton(title: "다음")
    
    private let exclamanationImageView = UIImageView().then {
        $0.image = UIImage(systemName: "exclamationmark.circle")?.withTintColor(APPJAMAsset.dSubMainColor.color, renderingMode: .alwaysOriginal)
        $0.isHidden = true
    }
    
    private let exclamanationLabel = UILabel().then {
        $0.text = "아이디를 10글자 이하로 입력하세요."
        $0.font = UIFont(font: APPJAMFontFamily.NotoSansCJKKR.regular, size: 14)
        $0.textColor = APPJAMAsset.dSubMainColor.color
    }
    
    // MARK: - UI
    override func addView() {
        [
            logoImageView, descriptionLabel, IDTextField, nextButton,
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
        IDTextField.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(bound.height*0.0357)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        exclamanationLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(IDTextField)
            $0.top.equalTo(IDTextField.snp.bottom).offset(4)
        }
        nextButton.snp.makeConstraints {
            $0.top.equalTo(exclamanationLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        exclamanationImageView.snp.makeConstraints {
            $0.centerY.equalTo(IDTextField)
            $0.trailing.equalTo(IDTextField.snp.trailing).inset(17)
        }
    }
    override func configureVC() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    // MARK: - Reactor
    override func bindView(reactor: RegisterReactor) {
        IDTextField.rx.text
            .orEmpty
            .observe(on: MainScheduler.asyncInstance)
            .map { Reactor.Action.updateUserID($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .map { Reactor.Action.toRegisterPasswordButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
    }
    override func bindAction(reactor: RegisterReactor) {
        IDTextField.rx.controlEvent(.editingDidBegin)
            .map { APPJAMAsset.dMainColor.color.cgColor }
            .bind(to: IDTextField.layer.rx.borderColor)
            .disposed(by: disposeBag)
        
        IDTextField.rx.controlEvent(.editingDidEnd)
            .map { reactor.currentState.userIdIsValid }
            .map { $0 ? APPJAMAsset.dGrayColor.color.cgColor : UIColor.black.cgColor }
            .bind(to: IDTextField.layer.rx.borderColor)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: RegisterReactor) {
        let sharedState = reactor.state.share(replay: 3).observe(on: MainScheduler.asyncInstance)
        
        sharedState
            .map { $0.userIdIsValid && $0.userID.isEmpty == false }
            .map { $0 ? APPJAMAsset.dMainColor.color : APPJAMAsset.dSubMainColor.color }
            .bind(to: nextButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        sharedState
            .map { $0.userIdIsValid }
            .subscribe(onNext: { [weak self] isValid in
                self?.nextButton.isEnabled = isValid
                self?.exclamanationImageView.isHidden = isValid
            })
            .disposed(by: disposeBag)
        
        sharedState
            .map { $0.userIdExclamanation.rawValue }
            .bind(to: exclamanationLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
