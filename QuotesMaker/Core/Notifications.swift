//
//  Notifications.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 15/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import Foundation


class Notifications{
    
    enum Name:String {
        case canUndo,canRedo
    }
    
    private static let _main = Notifications()
    
    static var main:Notifications{
        return _main
    }
    
//    func publish(name:Name){
//        NotificationCenter.default.post(name: name.rawValue, object: <#T##Any?#>)
//    }
    
    
    
}
