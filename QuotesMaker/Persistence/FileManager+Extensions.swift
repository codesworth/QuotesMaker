//
//  FileManager+Extensions.swift
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
    
    enum Directories:String {
        case savedModels
        case temp
        case userAccount
        case userData
    }
    
    static var modelDir:URL{
        return homeDir.appendingPathComponent(Directories.savedModels.rawValue)
    }
    
    enum Extensions:String{
        case json, txt, plist,isdm
    }
    
    
}

extension URL{
    
    func addExtension(_ ex:FileManager.Extensions) -> URL{
        return self.appendingPathExtension(ex.rawValue)
    }
}
