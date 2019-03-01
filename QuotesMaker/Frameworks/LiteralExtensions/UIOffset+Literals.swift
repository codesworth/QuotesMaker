//
//  CGPath+Literals.swift
//  LiteralExtensions
//
//  Created by Shadrach Mensah on 18/02/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


extension UIOffset:ExpressibleByArrayLiteral{
    
    public typealias ArrayLiteralElement = CGFloat
    
    public init(arrayLiteral elements: CGFloat...) {
        if elements.count > 1{
            self = UIOffset(horizontal: elements.first!, vertical: elements.last!)
        }else{
            if elements.isEmpty{
                self = UIOffset.zero
            }else{
                self = UIOffset(horizontal: elements.first!, vertical: elements.first!)
            }
        }
    }
    
}

extension UIOffset:ExpressibleByIntegerLiteral{
    
    public typealias IntegerLiteralType = Int
    
    public init(integerLiteral value: IntegerLiteralType) {
        let value = CGFloat(value)
        self = UIOffset(horizontal: value, vertical: value)
    }
}


extension UIOffset:ExpressibleByFloatLiteral{
    
    public typealias FloatLiteralType = Double
    
    public init(floatLiteral value: FloatLiteralType) {
        let value = CGFloat(value)
        self = UIOffset(horizontal: value, vertical: value)
    }
}
