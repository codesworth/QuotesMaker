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
    
    static var fixedHeight:CGFloat{
        return UIScreen.main.bounds.height * 0.8
    }
    
        
    static func Angle(_ degree:CGFloat)-> CGFloat{
        return (.pi * degree) / 180
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
    
    var isMulti:Bool{
        return count > 1
    }
}


extension Int{
    
    func nsNumber()->NSNumber{
        return NSNumber(value: self)
    }
}


extension UIView{
    
    
    
    
}

extension UIScreen{
    
    //ipad Pro 10.5 = 834
    //ipad Pro 9.7 = 1024.0 scale 2.0
    enum Handle{
        case pad_mini
        case pad_norm
        case pad_pro_min
        case pad_pro_11
        case pad_pro_maxx
        case xmax_xr
        case xs_x
        case pluses
        case eight_lower
        case fives
        case lowly
    }
    
    func screenType()->Handle{
        let height = UIScreen.main.bounds.height
        let interface = UIDevice.current.userInterfaceIdiom
        
        switch interface {
        case .phone:
            return handleFor(height: height)
        default:
            return handleFor(height: height)
        }
        
        
    }
    
    func handleFor(height:CGFloat)->Handle{
        if height > 890{
            return .xmax_xr
        }
        if height > 800 {
            return .xs_x
        }
        
        if height > 700 {
            return .pluses
        }
        
        if height > 650 {
            return .eight_lower
        }
        
        if height > 550 {
            return .fives
        }
        
        return .lowly
    }
}


extension UIScrollView{
    
    class func panelScrollView()->UIScrollView{
        let scroll = UIScrollView(frame: .zero)
        scroll.bounces = true
        scroll.isScrollEnabled = true
        return scroll
    }
}


extension UIImage{
    
    class func image(for tab:StudioTab.TabActions)->UIImage{
        switch tab {
        case .stylePanel:
           return #imageLiteral(resourceName: "panel")
        case .moveUp:
            return #imageLiteral(resourceName: "mup")
        case .moveDown:
            return #imageLiteral(resourceName: "mdw")
        case .delete:
            return #imageLiteral(resourceName: "delete")
        case .layers:
            return #imageLiteral(resourceName: "stack")
        case .fill:
            return #imageLiteral(resourceName: "paint")
        case .gradient:
            return #imageLiteral(resourceName: "ic_grad")
        case .imgPanel:
            return #imageLiteral(resourceName: "img_ic")
        case .undo:
            return #imageLiteral(resourceName: "undo_arrow")
        case .redo:
            return #imageLiteral(resourceName: "redo_arrow")
        }
    }
}
