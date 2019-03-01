//
//  CGSize.swift
//  LiteralExtensions
//
//  Created by Shadrach Mensah on 18/02/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


extension CGSize:ExpressibleByArrayLiteral{
    
    public typealias ArrayLiteralElement = CGFloat
    
    public init(arrayLiteral elements: CGFloat...) {
        if elements.count > 1{
            self = CGSize(width: elements.first!, height: elements.last!)
        }else{
            if elements.isEmpty{
                self = CGSize.zero
            }else{
                self = CGSize(width: elements.first!, height: elements.first!)
            }
        }
    }
}


extension CGSize:ExpressibleByIntegerLiteral{
    
    public typealias IntegerLiteralType = Int
    
    public init(integerLiteral value: IntegerLiteralType) {
        
        self = CGSize(width: value, height: value)
    }
}


extension CGSize:ExpressibleByFloatLiteral{
    
    public typealias FloatLiteralType = Double
    
    public init(floatLiteral value: FloatLiteralType) {
        self = CGSize(width: value, height: value)
    }
}
