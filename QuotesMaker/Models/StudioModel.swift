//
//  StudioModel.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 24/04/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import Foundation


public struct StudioModel:Codable{
    
    private var id:String
    private var dateCreated:TimeInterval
    private var lastModified:TimeInterval
    private var models:[LayerModel]
}
