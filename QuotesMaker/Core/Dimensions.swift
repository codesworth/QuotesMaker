//
//  Dimensions.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 28/02/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

let __IS_IPAD:Bool = UIDevice.idiom == .pad

class Dimensions{
    
    enum PanelHeights:CGFloat, CaseIterable{
        case fill = 170
        case gradient = 560
        case img = 200
        case layout =  670
        case text = 600
    }
    
    class func sizedRectForScale(rectSize:CGSize, scale:CGFloat)->CGSize{
        return [rectSize.width * scale, rectSize.height * scale ]
    }
    
    class var panelWidth:CGFloat{
        return UIScreen.main.bounds.width
    }
    
    class var colorPanelHeight:CGFloat{
        return 250
    }
    
    class var gradientPanelHeight:CGFloat{
        return 300
    }
    
    class var imagePanelHeight:CGFloat{
        return 250
    }
    
    class var designatedHeight:CGFloat{
        return UIScreen.main.bounds.height * 0.3
    }
    
    class func heightForPanel(_ panel:Int)->CGFloat{
        if panel == 1{
            return min(200, designatedHeight)
        }else{
            return min(300, designatedHeight)
        }
    }
    
    
    class var originalPanelPoints:CGPoint{
        return [0,UIScreen.main.bounds.height + 300]
    }
    
    class func scaledDownFrom(rect:CGSize)->CGSize{
        let lowestSide = min(rect.width, rect.height)
        let maxSide = CGFloat.fixedWidth
        let scaler = maxSide / lowestSide
        return rect.scaledBy(scaler)
        
    }
    
    class func sizedRatio(of rect:CGSize,in supeRect:CGSize)->CGSize{
        return [rect.width / supeRect.width,rect.height / supeRect.height]
    }
    
    enum AspectRatios{
        case `default`
        case square
    }
    
    class func sizeForAspect(_ ratio:AspectRatios)-> CGSize{
        switch ratio {
        case .default:
            return [.fixedWidth, .fixedWidth * (9 / 16)]
        case .square:
            return [.fixedWidth]
        }
    }
    
    class var editorSize:CGSize{
        
        return [UIScreen.main.bounds.width,UIScreen.main.bounds.height * 0.6]
        
    }
    
    struct iPadContext {
        static var nativeEditorSize:CGSize{
            return UIScreen.main.nativeBounds.size
        }
        static var size:CGSize{
            return UIScreen.main.bounds.size
        }
        static var type:UIScreen.Handle{
            return UIScreen.main.screenType()
        }
        static var controlPanelWidth:CGFloat{
            
            return size.width * 0.30
        }
        
        static var editorHeightPotrait:CGFloat{
            return size.max * 0.6
        }
        
        static var potraitPanelHeight:CGFloat{
            return size.max * 0.4
        }
        
        static var layerStackWidth:CGFloat{
            return size.width * 0.20
        }
    }
    
}
