//
//  CGPoint+Literals.swift
//  LiteralExtensions
//
//  Created by Shadrach Mensah on 18/02/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit
import simd


extension CGPoint:ExpressibleByArrayLiteral{
    
    public typealias ArrayLiteralElement = CGFloat
    
    public init(arrayLiteral elements: CGFloat...) {
        if elements.count > 1{
            self = CGPoint(x: elements.first!, y: elements.last!)
        }else{
            if elements.isEmpty{
                self = CGPoint.zero
            }else{
                self = CGPoint(x: elements.first!, y: elements.first!)
            }
        }
    }
}


extension CGPoint:ExpressibleByIntegerLiteral{
    
    public typealias IntegerLiteralType = Int
    
    public init(integerLiteral value: IntegerLiteralType) {
        
        self = CGPoint(x: value, y: value)
    }
}


extension CGPoint:ExpressibleByFloatLiteral{
    
    public typealias FloatLiteralType = Double
    
    public init(floatLiteral value: FloatLiteralType) {
        self = CGPoint(x: value, y: value)
    }
}


extension CGPoint{
    
    
    init(_ double2:double2) {
        self.init(x: double2.x, y: double2.y)
    }
    
    var lenght:CGFloat{
        return CGFloat(simd.length(double2(self)))
    }
    
    func clampedWithin(_ bounds:CGRect)->CGPoint{
        return CGPoint(
            clamp(double2(self), min: double2(x:bounds.minX, y:bounds.minY), max: double2(x: bounds.maxX, y: bounds.maxY))
        )
    }
    
    static func +(_ lhs:CGPoint, rhs:CGPoint)->CGPoint{
        return CGPoint(double2(lhs) + double2(rhs))
    }
    
    static func +=(_ lhs:CGPoint, rhs:CGPoint)->CGPoint{
        return [lhs.x + rhs.x, lhs.y + rhs.y]
    }
    
    static func -=(_ lhs:CGPoint, rhs:CGPoint)->CGPoint{
        return [lhs.x - rhs.x, lhs.y - rhs.y]
    }
    
    mutating func constrainedPositvely()->CGPoint{
        if x < 0  {x = 0}
        if y < 0 {y = 0}
        return self
    }

}


extension double2{
    
    init(_ point:CGPoint) {
        self.init(x: point.x, y: point.y)
    }
    init(x:CGFloat, y:CGFloat) {
        self.init(x: x.native, y: y.native)
    }
}
