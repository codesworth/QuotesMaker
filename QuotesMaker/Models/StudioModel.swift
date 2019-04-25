//
//  StudioModel.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 24/04/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import Foundation


struct StudioModel:Codable{
    
    public private (set) var thumbImageSrc:URL?
    private var name:String
    public private (set) var id:String = UUID().uuidString
    private var dateCreated:TimeInterval
    private var lastModified:TimeInterval
    private var models:[BaseModel] = []
    
    init(models:[BaseModel],name:String = "untitled", url:URL? = nil) {
        self.models = models
        dateCreated = Date().timeIntervalSinceReferenceDate
        lastModified = Date().timeIntervalSinceReferenceDate
        self.name = name
        thumbImageSrc = url
    }
    
    mutating func modified(){
      lastModified = Date().timeIntervalSinceReferenceDate
    }
    
    
}


class Image{
    
    public private (set) var rawData:[[[UInt8]]] = [
        [
            [0x4F, 0x6B, 153,109, 0b0101_0001, 0b1110_0010],
            [0xFF, 0xBA, 100, 255, 0b1001_1000, 0b0001_0101],
            [0x12, 0x1C, 192, 10, 0b1111_0001, 0b0110_0100],
        ],
        [
            [0x4F, 0x6B, 153,109, 0b0101_0001, 0b1110_0010],
            [0xFF, 0xBA, 100, 255, 0b1001_1000, 0b0001_0101],
            [0x12, 0x1C, 192, 10, 0b1111_0001, 0b0110_0100],
        ],
        [
            [0x4F, 0x6B, 153,109, 0b0101_0001, 0b1110_0010],
            [0xFF, 0xBA, 100, 255, 0b1001_1000, 0b0001_0101],
            [0x12, 0x1C, 192, 10, 0b1111_0001, 0b0110_0100],
        ],
        [
            [0x4F, 0x6B, 153,109, 0b0101_0001, 0b1110_0010],
            [0xFF, 0xBA, 100, 255, 0b1001_1000, 0b0001_0101],
            [0x12, 0x1C, 192, 10, 0b1111_0001, 0b0110_0100],
        ],
        [
            [0b1110_0010, 0b0101_0001, 0x4F, 109, 153, 0x6B],
            [0b0001_0101, 0b1001_1000, 0xFF, 255, 100, 0xBA],
            [0b0110_0100, 0b1111_0001, 0x12, 10, 192, 0x1C],
        ],
        [
            [0x4F, 0x6B, 153,109, 0b0101_0001, 0b1110_0010],
            [0xFF, 0xBA, 100, 255, 0b1001_1000, 0b0001_0101],
            [0x12, 0x1C, 192, 10, 0b1111_0001, 0b0110_0100],
            ],
        [
            [0b1110_0010, 0b0101_0001, 0x4F, 109, 153, 0x6B],
            [0b0001_0101, 0b1001_1000, 0xFF, 255, 100, 0xBA],
            [0b0110_0100, 0b1111_0001, 0x12, 10, 192, 0x1C],
            ]
    ]
}
