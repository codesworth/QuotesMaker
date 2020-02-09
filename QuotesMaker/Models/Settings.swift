//
//  Settings.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 23/12/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import Foundation


struct Settings:Codable{
    
    var icloudSupport:Bool
    var projectAlbums:Bool
    
    mutating func saveiCloudSupport(_ value:Bool){
        icloudSupport = value
        UserDefaults.standard.set(value, forKey: CodingKeys.icloudSupport.stringValue)
        
    }
    
    mutating func saveProjectAlbumPhotos(_ value:Bool){
        projectAlbums = value
        UserDefaults.standard.set(value, forKey: CodingKeys.projectAlbums.stringValue)
        
    }
    
    init(){
        icloudSupport = UserDefaults.standard.bool(forKey: CodingKeys.icloudSupport.stringValue)
        projectAlbums = UserDefaults.standard.bool(forKey: CodingKeys.projectAlbums.stringValue)
    }
}
