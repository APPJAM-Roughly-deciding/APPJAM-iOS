//
//  StepExt.swift
//  APPJAM
//
//  Created by 최형우 on 2021/12/18.
//  Copyright © 2021 baegteun. All rights reserved.
//

import RxFlow

extension Step{
    var asAppJamStep: APPJAMStep?{
        return self as? APPJAMStep
    }
}
