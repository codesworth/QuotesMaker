//
//  Extensions.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 28/02/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


extension CGRect{
    
    
    
}


extension CGFloat{
    static var fixedWidth:CGFloat{
        return UIScreen.main.bounds.width * 0.9
    }
}



extension UIColor{
    
    class var primary:UIColor{
        return UIColor(red: 238/255, green: 2/255, blue: 144/255, alpha: 1)
    }
    
    class var blankWhite:UIColor{
        return UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
    }
}


extension Array{
    
    mutating func push(_ element:Element){
        if count > 10 {
            self = Array(dropFirst())
            append(element)
        }else{
            append(element)
        }
    }
    
    mutating func pop()->Element{
        return popLast()!
    }
}


extension Int{
    
    func nsNumber()->NSNumber{
        return NSNumber(value: self)
    }
}


extension UIView{
    
    func makeLayerFrame()->LayerFrame{
        guard let `super` = superview else {
            fatalError("You Cannot Call UIView.makeLayerFrame() on a view without a superview. Do you know what you are doing?? 🤦‍♂️🤦‍♂️🤦‍♂️")
        }
        
        let initialOrigin = frame.origin
        let origin:CGPoint = [initialOrigin.x / `super`.bounds.maxX,initialOrigin.y / `super`.bounds.maxY]
        let sizedRatio = Dimensions.sizedRatio(of: frame.size, in: `super`.frame.size)
        return LayerFrame(origin, sized: sizedRatio)
    }
    
    
}
