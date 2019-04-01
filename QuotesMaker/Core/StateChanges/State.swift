//
//  State.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 01/04/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import Foundation


struct State{
    
    enum StateActions{
        case delete
        case add
        case nothing
    }
    
    var model:LayerModel
    var action:StateActions
    
    init(model:LayerModel,action:StateActions) {
        self.model = model
        self.action = action
    }
    
}


extension State:Equatable{
    
    static func == (lhs: State, rhs: State) -> Bool {
        return lhs.model.updateTime == rhs.model.updateTime
    }
    
}
