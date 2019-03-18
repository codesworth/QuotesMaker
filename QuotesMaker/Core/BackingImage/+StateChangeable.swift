//
//  +StateChangeable.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 18/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


extension BackingImageView:StateChangeable{
    
    func stateRedo() {
        guard !redoModels.isEmpty else {
            Subscription.main.post(suscription: .canRedo, object: false)
            return
        }
        let model = redoModels.pop()
        self.model = model
        previousModels.append(model)
        Subscription.main.post(suscription: .canUndo, object: true)
    }
    
    func stateUndo() {
        guard !previousModels.isEmpty else {
            Subscription.main.post(suscription: .canUndo, object: false)
            return
        }
        let model = previousModels.pop()
        self.model = model
        redoModels.append(model)
        Subscription.main.post(suscription: .canRedo, object: true)
        
    }
}
