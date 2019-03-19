//
//  Generic+Protocols.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 16/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import Foundation


protocol BaseViewSubViewable{
    
    var id:String {get}
    var id_tag:Int {get}
    var uid:UUID {get}
    func focused(_ bool:Bool)
}
