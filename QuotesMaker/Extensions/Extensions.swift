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
    
    static var fixedWidthHG:CGFloat{
        
        let idiom = UIDevice.current.userInterfaceIdiom
        if idiom == .phone{
            return UIScreen.main.bounds.width * 0.7
        }else if idiom == .pad{
            return 350
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
        case .duplicate:
            return #imageLiteral(resourceName: "duplicate")
        }
    }
    
    class var alignLeft:UIImage?{
        return #imageLiteral(resourceName: "left")
    }
    class var alignCenter:UIImage?{
        return #imageLiteral(resourceName: "center")
    }
    
    class var alignRight:UIImage?{
        return #imageLiteral(resourceName: "right")
    }
    
    class var alignJustify:UIImage?{
        return #imageLiteral(resourceName: "justify")
    }
    
    enum ImageSizes:Int{
        case supermax = 32000000
        case max = 16000000
        case medium = 8000000
        case minlg = 4000000
        case min = 1000000
    }
    
    var studioImage:UIImage?{
        if let data = dataFromJPEG(){
            return UIImage(data: data)
        }
        return nil
    }
    
    func dataFromJPEG()-> Data?{
        var compression:CGFloat = 1
        if let data = jpegData(compressionQuality: compression){
            if data.count < ImageSizes.min.rawValue{
                compression = 0.6
                return jpegData(compressionQuality: compression)
            }
            if data.count < ImageSizes.minlg.rawValue{
                compression = 0.5
                return jpegData(compressionQuality: compression)
            }
            if data.count < ImageSizes.medium.rawValue{
                compression = 0.4
                return jpegData(compressionQuality: compression)
            }
            if data.count < ImageSizes.max.rawValue{
                compression = 0.2
                return jpegData(compressionQuality: compression)
            }
            
            compression = 0.1
            return jpegData(compressionQuality: compression)
            
        }
        return nil
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

func toSignficant(x:Double)->String{
   return String(format: "%.1f", x)
}

func toSignficant(x:Float)->String{
    return String(format: "%.1f", x)
}

func toSignficant(x:CGFloat)->String{
    return String(format: "%.1f", x)
}


extension UIStoryboard{
    class var storyboard:UIStoryboard{
        if UIDevice.idiom == .pad{
            return UIStoryboard(name: "iPadMain", bundle: .main)
        }
        return UIStoryboard(name: "Main", bundle: .main)
    }
}
