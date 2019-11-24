//
//  Canvas.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 05/05/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import Foundation

/*
 enum AspectRatios:Int,CaseIterable,Codable{
 case `default`
 case instagram
 case facebook
 case facebook_stories
 case ig_horizontal
 case ig_vertical
 case ig_stories
 case pinterest
 case snapchat
 case twitter
 case twitter_header
 case facebook_header
 
 }
 
 */


struct Canvas:Equatable {
    
    private enum WidthSizes:CGFloat{
        case `default` = 500.00
        case facebook_twitter = 1200
        case ig_and_snap_stories = 1080
        case pinterest = 800
        case twitter_header = 1500
        case facebook_header = 640
    }
    
    enum AspectRatios:Int,CaseIterable,Codable{
        
        case instagram
        case ig_horizontal
        case pinterest
        case snapchat
        case ig_vertical
        case facebook_stories
        case ig_stories
        case twitter_header
        case facebook_header
        
    }
    private enum Ratios:CGFloat{
        case instagram = 1.00
        case facebook = 1.91082802548
        case stories = 0.5625
        case ig_horizontal = 1.90812720848
        case ig_vertical = 0.8
        case pinterest = 0.66666666666
        case twitter = 1.77777777778
        case twitter_header = 3.00
        
        
    }
    
    public private (set) var icon:String
    public private (set)  var name:String
    public private (set) var aspectRatio:AspectRatios
    public private (set) var size:CGSize
    public private (set) var scale:CGFloat
    public private (set) var ratio:CGFloat
    
    init(aspect:AspectRatios) {
        switch aspect {
        case .instagram:
            name = "Instagram Post"
            aspectRatio = aspect
            size = [.fixedWidth]
            scale = WidthSizes.ig_and_snap_stories.rawValue / size.width
            icon = "ig_square"
            ratio = Ratios.instagram.rawValue
            break
//        case .facebook:
//            name = "Facebook Post"
//            aspectRatio = aspect
//            size = [.fixedWidth, .fixedWidth * (1 / Ratios.facebook.rawValue)]
//            scale = WidthSizes.facebook_twitter.rawValue / size.width
//            icon = "fb"
//            ratio = Ratios.facebook.rawValue
//            break
        case .facebook_stories:
            name = "Facebook Story"
            aspectRatio = aspect
            size = [.fixedWidthHG, .fixedWidthHG * (1 / Ratios.stories.rawValue)]
            scale = WidthSizes.ig_and_snap_stories.rawValue / size.width
            icon = "fb_story"
            ratio = Ratios.stories.rawValue
            break
        case .ig_stories:
            name = "Instagram Story"
            aspectRatio = aspect
            size = [.fixedWidthHG, .fixedWidthHG * (1 / Ratios.stories.rawValue)]
            scale = WidthSizes.ig_and_snap_stories.rawValue / size.width
            icon = "ig"
            ratio = Ratios.stories.rawValue
            break
        case .snapchat:
            name = "Snapchat"
            aspectRatio = aspect
            size = [.fixedWidthHG, .fixedWidthHG * (1 / Ratios.stories.rawValue)]
            scale = WidthSizes.ig_and_snap_stories.rawValue / size.width
            icon = "sn"
            ratio = Ratios.stories.rawValue
            break
        case .ig_vertical:
            name = "IG Vertical"
            aspectRatio = aspect
            size = [.fixedWidth, .fixedWidth * (1 / Ratios.ig_vertical.rawValue)]
            scale = WidthSizes.ig_and_snap_stories.rawValue / size.width
            icon = "ig_vertical"
            ratio = Ratios.ig_vertical.rawValue
            break
        case .ig_horizontal:
            name = "IG Horizontal"
            aspectRatio = aspect
            size = [.fixedWidth, .fixedWidth * (1 / Ratios.ig_horizontal.rawValue)]
            scale = WidthSizes.ig_and_snap_stories.rawValue / size.width
            icon = "ig_horizontal"
            ratio = Ratios.ig_horizontal.rawValue
            break
        case .pinterest:
            name = "Pinterest"
            aspectRatio = aspect
            size = [.fixedWidth * 0.80, (.fixedWidth * 0.80) * (1 / Ratios.pinterest.rawValue)]
            scale = WidthSizes.pinterest.rawValue / size.width
            icon = "pn"
            ratio = Ratios.pinterest.rawValue
            break
//        case .twitter:
//            name = "Twitter Post"
//            aspectRatio = aspect
//            size = [.fixedWidth, .fixedWidth * (1 / Ratios.twitter.rawValue)]
//            scale = WidthSizes.facebook_twitter.rawValue / size.width
//            icon = "tw"
//            break
        case .twitter_header:
            name = "Twitter Header"
            aspectRatio = aspect
            size = [.fixedWidth, .fixedWidth * (1 / Ratios.twitter_header.rawValue)]
            scale = WidthSizes.twitter_header.rawValue / size.width
            icon = "tw_header"
            ratio = Ratios.twitter_header.rawValue
            break
        case .facebook_header:
            name = "FB Header"
            aspectRatio = aspect
            size = [.fixedWidth, .fixedWidth * (1 / Ratios.twitter.rawValue)]
            scale = WidthSizes.facebook_header.rawValue / size.width
            icon = "fb_header"
            ratio = Ratios.twitter.rawValue
            break
//        default:
//            name = "Regular"
//            aspectRatio = aspect
//            size = [.fixedWidth]
//            scale = WidthSizes.default.rawValue / size.width
//            icon = "rg"
//            break
        }
    }
    
    
}
