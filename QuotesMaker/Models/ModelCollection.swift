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
        //print(container.contains(element))
        if !container.contains(element){
            container.append(element)
        }
    }
    
    mutating func pop()->Element?{
        return container.popLast()
    }
    
    var isMulti:Bool{
        return container.count > 1
    }
    
    var isEmpty:Bool{
        return container.isEmpty
    }
    
}


//extension ModelCollection:ExpressibleByArrayLiteral{
//
//
//    init(arrayLiteral elements: Element...) {
////        let set:Set<Element> = elements
//    }
//}
