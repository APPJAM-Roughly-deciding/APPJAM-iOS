//
//  AppFlow.swift
//
//
//  Created by baegteun on 2021/11/30.
//

import RxFlow
import RxRelay
import RxSwift

struct AppStepper: Stepper{
    let steps: PublishRelay<Step> = .init()
    private let disposeBag: DisposeBag = .init()
    
    func readyToEmitSteps() {
        Observable.just(APPJAMStep.loginIsRequired)
            .bind(to: steps)
            .disposed(by: disposeBag)
    }
}

final class AppFlow: Flow{
    
    // MARK: - Properties
    var root: Presentable{
        return self.rootWindow
    }
    
    private let rootWindow: UIWindow
    
    // MARK: - Init
    
    init(
        with window: UIWindow
    ){
        self.rootWindow = window
    }
    
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    
    // MARK: - Navigate
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asAppJamStep else { return .none }
        
        switch step{
        case .loginIsRequired:
            return coordinateToLogin()
        case .registerNicknameIsRequired:
            return coordinateToRegister()
        case .mainTabbarIsRequired:
            return coordinateToMain()
        default:
            return .none
        }
    }
}

// MARK: - Method

private extension AppFlow{
    func coordinateToLogin() -> FlowContributors{
        let flow = LoginFlow(with: .init())
        Flows.use(flow, when: .created) { [unowned self] root in
            self.rootWindow.rootViewController = root
        }
        let nextStep = OneStepper(withSingleStep: APPJAMStep.loginIsRequired)
        return .one(flowContributor: .contribute(withNextPresentable: flow, withNextStepper: nextStep))
    }
    func coordinateToRegister() -> FlowContributors{
        let flow = RegisterFlow(with: .init())
        Flows.use(flow, when: .created) { [unowned self] root in
            self.rootWindow.rootViewController = root
        }
        let nextStep = OneStepper(withSingleStep: APPJAMStep.registerNicknameIsRequired)
        return .one(flowContributor: .contribute(withNextPresentable: flow, withNextStepper: nextStep))
    }
    func coordinateToMain() -> FlowContributors{
        let flow = MainFlow()
        Flows.use(flow, when: .created) { [unowned self] root in
            self.rootWindow.rootViewController = root
        }
        let nextStep = OneStepper(withSingleStep: APPJAMStep.mainTabbarIsRequired)
        return .one(flowContributor: .contribute(withNextPresentable: flow, withNextStepper: nextStep))
    }
}

