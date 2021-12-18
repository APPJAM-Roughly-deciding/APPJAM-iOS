//
//  HomeFlow.swift
//  APPJAM
//
//  Created by 최형우 on 2021/12/19.
//  Copyright © 2021 baegteun. All rights reserved.
//

import RxFlow
import RxRelay

struct HomeStepper: Stepper{
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step{
        return APPJAMStep.homeIsRequired
    }
}

final class HomeFlow: Flow{
    // MARK: - Properties
    var root: Presentable{
        return self.rootVC
    }
    
    let stepper: HomeStepper
    private let rootVC = UINavigationController()
    
    // MARK: - Init
    init(
        with stepper: HomeStepper
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
        case .homeIsRequired:
            return coordinateToHome()
            
        default:
            return .none
        }
    }
}

// MARK: - Method
private extension HomeFlow{
    func coordinateToHome() -> FlowContributors{
        let reactor = HomeReactor()
        let vc = HomeVC(reactor: reactor)
        self.rootVC.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
}
