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
    
    enum Directories:String {
        case savedModels
        case temp
        case userAccount
        case userData
    }
    
    static var modelDir:URL{
        return homeDir.appendingPathComponent(Directories.savedModels.rawValue, isDirectory:true)
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

class Persistence{
    
    
    
    private static let _main = Persistence()
    
    static var main:Persistence{
        return _main
    }
    
    func save(model:StudioModel){
        let encoder = JSONEncoder()
        do{
            let data = try encoder.encode(model)
            let url = FileManager.modelDir.appendingPathComponent(model.id).addExtension(.json)
            try data.write(to: url)
        }catch let err{
            print("Error Occurred with sig: \(err.localizedDescription)")
        }
    
    }
    
}
