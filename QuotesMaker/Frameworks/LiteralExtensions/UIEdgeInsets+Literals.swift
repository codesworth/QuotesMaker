//
//  UIEdgeInsets.swift
//  LiteralExtensions
//
//  Created by Shadrach Mensah on 18/02/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


extension UIEdgeInsets:ExpressibleByArrayLiteral{
    
    public init(arrayLiteral elements: CGFloat...) {
        switch elements.count {
        case 4:
            self = UIEdgeInsets(top: elements.first!, left: elements[1], bottom: elements[2], right: elements.last!)
            break
        case 3:
            self =  UIEdgeInsets(top: elements.first!, left: elements[1], bottom: elements.last!, right: elements.last!)
            break
        case 2:
            self =  UIEdgeInsets(top: elements.first!, left: elements.first!,bottom: elements.last!, right: elements.last!)
            break
        case 1:
            self =  UIEdgeInsets(top: elements.first!, left: elements.first!, bottom: elements.first!, right: elements.first!)
        default:
            self = .zero
        }
    }
}



extension UIEdgeInsets:ExpressibleByFloatLiteral{
    
    public typealias FloatLiteralType = Double
    
    
    public init(floatLiteral value: FloatLiteralType) {
        let value = CGFloat(value)
        self = UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }
    
    
}


