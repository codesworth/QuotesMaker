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


extension CGSize{
    
    func scaledBy(_ scaler:CGFloat)->CGSize{
        return [width * scaler, height * scaler]
    }
    
    func minimum(in rect:CGRect)->CGSize{
        let minWidth = rect.width * 0.1
        let minHeight = rect.height * 0.1
        return [Swift.max(minWidth, self.width), Swift.max(minHeight, height)]
    }
    
    var min:CGFloat{
        return Swift.min(width, height)
    }
    
    var max:CGFloat{
        return Swift.max(width, height)
    }
    
    var product:Int{
        return Int(width) * Int (height)
    }
    
    struct ImageSizes {
        
        static var thumbnail:CGSize{
            return [120]
        }
    }
}
