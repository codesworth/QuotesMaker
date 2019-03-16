//
//  Notifications.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 15/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


class Subscription{
    
    enum Name:String {
        
        case canUndo,canRedo,layerChanged
    }

    private static let _main = Subscription()
    
    static var main:Subscription{
        return _main
    }
    
    
    func post(suscription name:Name, object:Any?){
        if let object = object{
            NotificationCenter.default.post(name: NSNotification.Name(name.rawValue), object: nil,userInfo:[.info:object])
        }else{
            NotificationCenter.default.post(name: NSNotification.Name(name.rawValue), object: nil)
        }
    }
    
    
}


extension NSObject{
    func subscribeTo(subscription name:Subscription.Name,selector:Selector){
        NotificationCenter.default.addObserver(self, selector: selector, name: NSNotification.Name(name.rawValue), object: nil)
    }
    
    func unsubscribe(){
        NotificationCenter.default.removeObserver(self)
    }
}


