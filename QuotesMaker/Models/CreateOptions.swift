//
//  CreateOptions.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 02/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import Foundation


struct Options {
    
    
    let name:String
    let position:Int
    
    static func getDefaultOptions()->[Options]{
        let titles = ["Pick Image From Gallery","Pick Online","Surprise Me","Start Blank"]
        var options:Array<Options> = []
        for i in 1...4{
            let option = Options(name: titles[i - 1], position: i)
            options.append(option)
        }
        
        return options
    }
    
    
    
}


