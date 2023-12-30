//
//  TAnchorKey.swift
//  DanielKeep
//
//  Created by Dani Benet on 30/12/23.
//

import SwiftUI

struct TAnchorKey: PreferenceKey {
    typealias Value = [String:Anchor<CGRect>]
    
    static var defaultValue: [String : Anchor<CGRect>] = [:]
    
    static func reduce(value: inout [String : Anchor<CGRect>], nextValue: () -> [String : Anchor<CGRect>]) {
        value.merge(nextValue()) { $1 }
    }
}
