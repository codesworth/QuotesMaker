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
        
        case canUndo,canRedo,layerChanged,layerReArranged,activatedLayer,cornermask,
        noSub,stateChange,roundedCornerRadiusValueChanged,moreFonts, purchaseNotification, failedPurchase, showXCrossHairs,showYCrossHairs,unshowYCrossHairs,unshowXCrossHairs,unshowAllCrossHairs, refreshRecent,refreshTemplates, fontsChanged
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
    
    func unsubscribe(_ name:Subscription.Name){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: name.rawValue), object: nil)
    }
}



