//
//  RegisterFlow.swift
//  APPJAM
//
//  Created by 최형우 on 2021/12/18.
//  Copyright © 2021 baegteun. All rights reserved.
//

import RxFlow
import RxRelay

struct RegisterStepper: Stepper{
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step{
        return APPJAMStep.registerNicknameIsRequired
    }
}

final class RegisterFlow: Flow{
    // MARK: - Properties
    var root: Presentable{
        return self.rootVC
    }
    
    let stepper: RegisterStepper
    private let rootVC = UINavigationController()
    
    private let reactor = RegisterReactor()
    
    // MARK: - Init
    init(
        with stepper: RegisterStepper
    ){
        self.stepper = stepper
    }
    
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    // MARK: - Navigate
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asAppJamStep else { return .none }
        
        switch step{
        case .registerNicknameIsRequired:
            return coordinateToRegisterNickname()
        case .loginIsRequired:
            return coordinateToLogin()
        case .registerIDIsRequired:
            return navigateToRegisterID()
        case .registerPasswordIsRequired:
            return navigateToRegisterPassword()
        case let .alert(title, message):
            return navigateToAlert(title: title, msg: message)
        default:
            return .none
        }
    }
}

// MARK: - Method
private extension RegisterFlow{
    func coordinateToLogin() -> FlowContributors{
        return .end(forwardToParentFlowWithStep: APPJAMStep.loginIsRequired)
    }
    func coordinateToRegisterNickname() -> FlowContributors{
        let vc = RegisterNicknameVC(reactor: reactor)
        self.rootVC.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
    func navigateToRegisterID() -> FlowContributors{
        let vc = RegisterIDVC(reactor: reactor)
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
    func navigateToRegisterPassword() -> FlowContributors{
        let vc = RegisterPasswordVC(reactor: reactor)
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
    func navigateToAlert(title: String?, msg: String?) -> FlowContributors{
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(.init(title: "확인", style: .default, handler: { _ in
            _ = self.reactor.mutate(action: .toLogin)
        }))
        self.rootVC.present(alert, animated: true)
        return .none
    }
}
