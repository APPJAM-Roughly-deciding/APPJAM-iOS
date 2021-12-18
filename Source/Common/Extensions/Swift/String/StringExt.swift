//
//  StringExt.swift
//  APPJAM
//
//  Created by 최형우 on 2021/12/18.
//  Copyright © 2021 baegteun. All rights reserved.
//

import Foundation

extension String{
    var toURL: URL?{
        return URL(string: self)
    }
}
