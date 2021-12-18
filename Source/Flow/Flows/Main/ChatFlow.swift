//
//  ChatFlow.swift
//  APPJAM
//
//  Created by 최형우 on 2021/12/19.
//  Copyright © 2021 baegteun. All rights reserved.
//

import RxFlow
import RxRelay

struct ChatStepper: Stepper{
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step{
        return APPJAMStep.chatIsRequired
    }
}

final class ChatFlow: Flow{
    // MARK: - Properties
    var root: Presentable{
        return self.rootVC
    }
    
    let stepper: ChatStepper
    private let rootVC = UINavigationController()
    
    // MARK: - Init
    init(
        with stepper: ChatStepper
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
            
        default:
            return .none
        }
    }
}

// MARK: - Method
private extension ChatFlow{
    
}
