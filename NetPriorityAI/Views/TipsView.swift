//
//  TipView.swift
//  NetPriorityAI
//
//  Created by Lung Hao Tung on 9/13/25.
//
import SwiftUI
import TipKit

struct GeneralPopOverTip: Tip {
    let title: Text
    let message: Text?
}

extension GeneralPopOverTip {
    @Parameter
    static var buttonPressed: Bool = false
    
    var rules: [Rule] {
        [
            #Rule(Self.$buttonPressed) {
                $0 == true
            }
        ]
    }
}


