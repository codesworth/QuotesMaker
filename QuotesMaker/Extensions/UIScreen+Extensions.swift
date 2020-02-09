//
//  UIScreen+Extensions.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 10/04/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import Foundation

extension UIScreen{
    
    
    static var orientation:Orientation{
        let size = main.bounds
        if size.width > size.height{
            return .landscape
        }
        return .potrait
    }
    enum SizeNative:Int{
        case iPad_norm = 3145728
        case pro_10_5 = 3709632
        case pro_11 = 3983184
        case pro_12_9 = 5595136
    }
    //ipad mini native w1536 x h2048 scale 2 =
    //ipad 5 native w1536.0, 2048.0
    //ipad Pro 10.5 native = w1668.0, h2224.0 scale 2.0
    //ipad Pro 9.7 native  = w1536.0, h2048.0 scale 2.0
    //ipad Pro 11 native = w1668.0, h2388.0 scale 2.0
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
    
    enum Orientation{
        case potrait
        case landscape
    }
    
    static func hasNotch()->Bool{
        
        let handle = main.screenType()
        switch handle {
        case .pluses,.eight_lower,.fives,.lowly:
            return false
        case .xs_x, .xmax_xr:
            return true
        default:
            return false
        }
    }
    
    func screenType()->Handle{
        let height = UIScreen.main.bounds.height
        let interface = UIDevice.current.userInterfaceIdiom
        
        switch interface {
        case .phone:
            return handleFor(height: height)
        case .pad:
            return iPadHandleFor(native: UIScreen.main.nativeBounds.size)
        default:
            return handleFor(height: height)
        }
        
        
    }
    
    func iPadHandleFor(native size:CGSize)->Handle{
        if size.product >= SizeNative.pro_12_9.rawValue{
            return .pad_pro_maxx
        }
        if size.product >= SizeNative.pro_11.rawValue{
            return .pad_pro_11
        }
        if size.product >= SizeNative.pro_10_5.rawValue{
            return .pad_pro_10_5
        }
        if size.product >= SizeNative.iPad_norm.rawValue{
            return .pad_pro_9_7
        }
        return .pad_norm

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
