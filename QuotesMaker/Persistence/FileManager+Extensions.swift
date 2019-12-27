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
        case modelImages
        case previewThumbnails
        case exported
        case templates
    }
    
    static var modelDir:URL{
        return homeDir.appendingPathComponent(Directories.savedModels.rawValue, isDirectory:true)
    }
    
    static var exportedDir:URL{
        return homeDir.appendingPathComponent(Directories.exported.rawValue, isDirectory:true)
    }
    
    static var templatesDir:URL{
        return homeDir.appendingPathComponent(Directories.templates.rawValue,isDirectory:true)
    }
    
    static var modelImagesDir:URL{
        return homeDir.appendingPathComponent(Directories.modelImages.rawValue,isDirectory:true)
    }
    
    static var previewthumbDir:URL{
        return homeDir.appendingPathComponent(Directories.previewThumbnails.rawValue,isDirectory:true)
    }
    
    enum Extensions:String{
        case json, txt, plist,isdm, png, jpg, jpeg
    }
    
    
}

extension URL{
    
    func addExtension(_ ex:FileManager.Extensions) -> URL{
        return self.appendingPathExtension(ex.rawValue)
    }
    
    //static func filePath(_ name:String `in`:)
}
