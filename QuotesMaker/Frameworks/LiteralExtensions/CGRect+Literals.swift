//
//  CGRect+Literals.swift
//  LiteralExtensions
//
//  Created by Shadrach Mensah on 18/02/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


extension CGRect:ExpressibleByArrayLiteral{
    
    public typealias ArrayLiteralElement = CGFloat
    
    public init(arrayLiteral elements: CGFloat...) {
        switch elements.count {
        case 4:
            self = CGRect(x: elements.first!, y: elements[1], width: elements[2], height: elements.last!)
            break
        case 3:
            self = CGRect(x: elements.first!, y: elements[1], width: elements.last!, height: elements.last!)
            break
        case 2:
            self = CGRect(x: elements.first!, y: elements.first!, width: elements.last!, height: elements.last!)
            break
        case 1:
            self = CGRect(x: elements.first!, y: elements.first!, width: elements.first!, height: elements.first!)
        default:
            self = .zero
        }
    }

    
}



extension CGRect:ExpressibleByFloatLiteral{
    
    public typealias FloatLiteralType = Double
    
    
    public init(floatLiteral value: FloatLiteralType) {
        self = CGRect(x: value, y: value, width: value, height: value)
    }
    
    
}
