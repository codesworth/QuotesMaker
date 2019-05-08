//
//  ModelCollection.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 20/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import Foundation


struct States{
    
    private var container:Array<State> = []
    
    mutating func push(_ element:State){
        if !container.contains(element){
            container.append(element)
        }
    }
    
    mutating func append(_ element: State){
        if exceeds{
            container = container.reversed()
            container.removeLast()
            container = container.reversed()
        }
        container.append(element)
    }
    
    @discardableResult
    mutating func pop()->State?{
        return container.popLast()
    }
    
    var exceeds:Bool{
        return container.count > 50
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
