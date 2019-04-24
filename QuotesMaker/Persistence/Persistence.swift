//
//  Persistence.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 24/04/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import Foundation


extension FileManager{
    
    static var homeDir:URL{
        return `default`.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}

class Persistence{
    
    enum Directories:String {
        case savedModels
        case temp
        case userAccount
        case userData
    }
    
    private static let _main = Persistence()
    
    static var main:Persistence{
        return _main
    }
    
    func save(model:StudioModel){}
    
}
