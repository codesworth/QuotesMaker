//
//  LayerModel.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 07/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import Foundation

protocol LayerModel {
    

    //var priority:LayerFrame.LayerPriority {get}
    mutating func layerFrame(_ frame:LayerFrame)
}


