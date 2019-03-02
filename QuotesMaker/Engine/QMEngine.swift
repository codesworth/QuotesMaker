//
//  QMEngine.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 02/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import Foundation



class QMEngine:NSObject{
    
   
    
    var currentProcess:Processes.Process = .createImagebackground
    
    override init() {}
    
    func  next(_ opcode:Int)-> Processes.Process{
        switch opcode {
        case 1:
            return .createImagebackground
        default:
            return .createImagebackground
        }
    }
}


struct Processes {
    enum Process{
        case createImagebackground,createOverlay,createText
        
    }
    
    enum SubProcesses {
        case selectImage
    
    }
}
