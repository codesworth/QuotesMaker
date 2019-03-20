//
//  ModelCollection.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 20/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import Foundation


struct ModelCollection<Element:Equatable>{
    
    private var container:Array<Element> = []
    
    mutating func push(_ element:Element){
        guard container.contains(element) else {
            container.append(element)
            return
        }
    }
    
    mutating func pop()->Element?{
        return container.popLast()
    }
    
}


//extension ModelCollection:ExpressibleByArrayLiteral{
//
//
//    init(arrayLiteral elements: Element...) {
////        let set:Set<Element> = elements
//    }
//}
