//
//  Opereators.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 27/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import Foundation


func +<A: LayoutAnchor>(lhs: A, rhs: CGFloat) -> (A, CGFloat) {
    return (lhs, rhs)
}

func -<A: LayoutAnchor>(lhs: A, rhs: CGFloat) -> (A, CGFloat) {
    return (lhs, -rhs)
}


@discardableResult
func ==<A: LayoutAnchor>(lhs: LayoutProperty<A>,
                         rhs: (A, CGFloat))->NSLayoutConstraint {
    return lhs.equal(to: rhs.0, offsetBy: rhs.1)
}

@discardableResult
func ==<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: A)->NSLayoutConstraint {
    return lhs.equal(to: rhs)
}


@discardableResult
func >=<A: LayoutAnchor>(lhs: LayoutProperty<A>,
                         rhs: (A, CGFloat))->NSLayoutConstraint {
    return lhs.greaterThanOrEqual(to: rhs.0, offsetBy: rhs.1)
}

@discardableResult
func >=<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: A)->NSLayoutConstraint {
    return lhs.greaterThanOrEqual(to: rhs)
}

@discardableResult
func <=<A: LayoutAnchor>(lhs: LayoutProperty<A>,
                         rhs: (A, CGFloat))->NSLayoutConstraint {
    return lhs.lessThanOrEqual(to: rhs.0, offsetBy: rhs.1)
}

@discardableResult
func <=<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: A)->NSLayoutConstraint {
    return lhs.lessThanOrEqual(to: rhs)
}

precedencegroup LexicalArithmeticDisambiguityPrecedence{
    lowerThan:ComparisonPrecedence
}

infix operator |=| : DefaultPrecedence

infix operator -- : LexicalArithmeticDisambiguityPrecedence

@discardableResult
func |=|<A:LayoutAnchor>(lhs: LayoutProperty<A>, rhs: CGFloat)->NSLayoutConstraint{
    return lhs.equal(to: rhs)
    
}

func --(lhs:NSLayoutConstraint, rhs:String){
    lhs.identifier = rhs
}




extension NSLayoutConstraint{
    
    class func makeIdentifiers()->ids{
        return ids.init()
    }
    
    struct ids{
        
        let leading:String
        let top:String
        let trailing:String
        let bottom:String
        let left:String
        let right:String
        
        init() {
            let uuid = UUID()
            leading = uuid.uuidString
            top = uuid.uuidString
            trailing = uuid.uuidString
            bottom = uuid.uuidString
            left = uuid.uuidString
            right = uuid.uuidString
        }
    }
}
