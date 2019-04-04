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


extension UIDevice{
    
    class var idiom:UIUserInterfaceIdiom{
        return current.userInterfaceIdiom
    }
}


extension CGFloat{
    static var fixedWidth:CGFloat{
        let idiom = UIDevice.current.userInterfaceIdiom
        if idiom == .phone{
            return UIScreen.main.bounds.width * 0.9
        }else if idiom == .pad{
            return 500
        }
        return 0
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
    
    
    //ipad mini native w1536 x h2048 scale 2
    //ipad 5 native w1536.0, 2048.0
    //ipad Pro 10.5 native = w1668.0, h2224.0 scale 2.0 
    //ipad Pro 9.7 native  = w1536.0, h2048.0 scale 2.0
    //ipad Pro 11 native = w11668.0, h2388.0 scale 2.0
    //ipad Pro 12.9 native = w2048.0, h2732.0 scale 2.0
    //iphone xsmaxx native w1242.0, h2688.0 scale 3.0
    //iphone xs native w1125.0, h2436.0 scale 3.0
    //iphone xr native w828.0, h1792.0 scale 2
    //iphone x native w1125.0, h2436.0 scale 3
    //iphorn 8plus w1242.0, h2208.0 and scale:: 3.0
    //iphone 8 native w750.0, h1334.0) and scale:: 2.0
    // iphone 7plus native 1242.0, 2208.0) and scale:: 3.0
    // iphone 6plyusn native 1242.0, 2208.0) and scale:: 3.0
    //iphone 7 750.0, 1334.0) and scale:: 2.0
    //iphone 6s 750.0, 1334.0) and scale:: 2.0
    //iphone 6 750.0, 1334.0) and scale:: 2.0
    //iphone SE 640.0, 1136.0) and scale:: 2.0
    //iphone 5s 640.0, 1136.0) and scale:: 2.0 =
    
    enum Handle{
        
        case pad_norm
        case pad_pro_9_7
        case pad_pro_10_5
        case pad_pro_11
        case pad_pro_maxx
        case xmax_xr
        case xs_x
        case pluses
        case eight_lower
        case fives
        case lowly
        
        case ipad
    }
    

   /**
    struct Size {
        private let x:CGFloat
        private let y:CGFloat
        let orientation:UIDeviceOrientation
        let scale:CGFloat
        
        init(bounds:CGSize, orientation:UIDeviceOrientation, scale:CGFloat) {
            self.orientation = orientation
            self.scale = scale
            switch orientation {
            case .portrait,.portraitUpsideDown:
                x = bounds.width
                y = bounds.height
            case .landscapeLeft,.landscapeRight:
                x = bounds.height
                y = bounds.width
            default:
                x = bounds.width
                y = bounds.height
            }
        }
        
        func getType()->Handle{
            if (x == )
        }
    }
 */
    
    func screenType()->Handle{
        let height = UIScreen.main.bounds.height
        let interface = UIDevice.current.userInterfaceIdiom
        
        switch interface {
        case .phone:
            return handleFor(height: height)
        case .pad:
            return .ipad
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



extension UIViewController {
        func add(_ child: UIViewController, to parentView:UIView? = nil) {
            addChild(child)
            if let v = parentView{
                v.addSubview(child.view)
            }else{
                view.addSubview(child.view)
            }
            child.didMove(toParent: self)
        }
        
        func removeFrom() {
            guard parent != nil else {
                return
            }
            
            willMove(toParent: nil)
            removeFromParent()
            
            view.removeFromSuperview()
        }
        
}
