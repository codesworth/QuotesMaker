//
//  Coordinator+StateChanges.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 06/05/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import Foundation


extension EditingCoordinator:StateChangeable{
    
    func stateRedo() {
        
    }
    
    func stateUndo() {
        if let state = states.pop()
    }
    
}
