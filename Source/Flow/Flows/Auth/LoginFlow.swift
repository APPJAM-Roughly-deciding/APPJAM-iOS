//
//  LoginFlow.swift
//  APPJAM
//
//  Created by 최형우 on 2021/12/18.
//  Copyright © 2021 baegteun. All rights reserved.
//

import RxFlow
import RxRelay

struct LoginStepper: Stepper{
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step{
        return APPJAMStep.loginIsRequired
    }
}

final class LoginFlow: Flow{
    // MARK: - Properties
    var root: Presentable{
        return self.rootVC
    }
    
    let stepper: LoginStepper
    private let rootVC = UINavigationController()
    
    private let registerReactor = RegisterReactor()
    
    // MARK: - Init
    init(
        with stepper: LoginStepper
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
        case .loginIsRequired:
            return coordinateToLogin()
        case .registerNicknameIsRequired:
            return navigateToNicknameRegister()
        case .mainTabbarIsRequired:
            return .end(forwardToParentFlowWithStep: APPJAMStep.mainTabbarIsRequired)
        case let .errorAlert(title, message):
            return navigateToAlert(title: title, msg: title)
        default:
            return .none
        }
    }
}

// MARK: - Method
private extension LoginFlow{
    func coordinateToLogin() -> FlowContributors{
        let reactor = LoginReactor()
        let vc = LoginVC(reactor: reactor)
        self.rootVC.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
    func navigateToNicknameRegister() -> FlowContributors{
        return .end(forwardToParentFlowWithStep: APPJAMStep.registerNicknameIsRequired)
    }
    func navigateToAlert(title: String?, msg: String?) -> FlowContributors{
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(.init(title: "확인", style: .cancel))
        self.rootVC.present(alert, animated: true)
        return .none
    }
}
