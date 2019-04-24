//
//  TextModel.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 05/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


struct TextLayerModel {
    
    var string:String = "Hello"
    private var _textColor:StudioColor = .black
    var _font:StudioFont = StudioFont(font: UIFont.font(.painter, size: 27))
    var font:UIFont{
        get{
            return _font.font ?? UIFont.font(.painter, size: 27)
        }
        set{
            _font = StudioFont(font: newValue)
        }
    }

    var strikeThrough:Int = 0
    private var _strikeThroughColor:StudioColor?
    private var _strokeColor:StudioColor?
    var underlineStyle:Int = 0
    var strokeWidth:Int = 0
    var obliquess:Int = 0
    var layerFrame:LayerFrame?
    
    var shadow:NSShadow{
        get{
            let shadow = NSShadow()
            shadow.shadowColor = UIColor.clear
            shadow.shadowBlurRadius = 0
            shadow.shadowOffset = .zero
            return shadow
        }
    }
    var shadowAlpha:CGFloat = 0.30
    private var _shadowColor:StudioColor = .clear
    
    var textColor:UIColor{
        get{
            return _textColor.color
        }
        set{
            _textColor = StudioColor(color: newValue)
        }
    }
    
    
    var strikeThroughColor:UIColor?{
        get{
            return _strikeThroughColor?.color
        }
        set{
            _strikeThroughColor = (newValue != nil) ? StudioColor(color: newValue!):nil
        }
    }
    
    
    var strokeColor:UIColor?{
        get{
            return _strikeThroughColor?.color
        }
        set{
            _strikeThroughColor = (newValue != nil) ? StudioColor(color: newValue!) : nil
        }
    }
    
    private var _underlineColor:StudioColor?
    var underlineColor:UIColor?{
        get{
            return _underlineColor?.color
        }
        set{
            _underlineColor = (newValue != nil) ? StudioColor(color: newValue!) : nil
        }
    }

    var shadowColor:UIColor{
        get{
            return _shadowColor.color
        }
        set{
            _shadowColor = StudioColor(color: newValue)
        }
    }
    var style:Style = Style()
    var layerIndex: CGFloat = 0
    init() {
        
        
    }
    
    var updateTime: TimeInterval = Date().timeIntervalSinceReferenceDate
    mutating func update(){
        updateTime = Date().timeIntervalSinceReferenceDate
    }
    
    var type:ModelType{
        return .text
    }
    
    func outPutString()->NSAttributedString{
        
        var attributes:[NSAttributedString.Key:Any?] = [
            .font : font,
            .foregroundColor: textColor,
            .strikethroughStyle : strikeThrough.nsNumber(),
            .strikethroughColor : strikeThroughColor,
            .strokeColor : strokeColor,
            .underlineStyle: underlineStyle.nsNumber(),
            .strokeWidth : strokeWidth.nsNumber(),
            .obliqueness : obliquess.nsNumber(),
            .underlineColor:underlineColor,
            .shadow:shadow
        ]
        attributes.forEach{if $0.value == nil{attributes.removeValue(forKey: $0.key)}}
        return NSAttributedString(string: string, attributes: attributes as [NSAttributedString.Key : Any])
    }
}

extension TextLayerModel:LayerModel{}


/*
extension NSAttributedString.Key {
    
    
    /************************ Attributes ************************/
    @available(iOS 6.0, *)
    public static let font: NSAttributedString.Key
    
    @available(iOS 6.0, *)
    public static let paragraphStyle: NSAttributedString.Key // NSParagraphStyle, default defaultParagraphStyle
    
    @available(iOS 6.0, *)
    public static let foregroundColor: NSAttributedString.Key // UIColor, default blackColor
    
    @available(iOS 6.0, *)
    public static let backgroundColor: NSAttributedString.Key // UIColor, default nil: no background
    
    @available(iOS 6.0, *)
    public static let ligature: NSAttributedString.Key // NSNumber containing integer, default 1: default ligatures, 0: no ligatures
    
    @available(iOS 6.0, *)
    public static let kern: NSAttributedString.Key // NSNumber containing floating point value, in points; amount to modify default kerning. 0 means kerning is disabled.
    
    @available(iOS 6.0, *)
    public static let strikethroughStyle: NSAttributedString.Key // NSNumber containing integer, default 0: no strikethrough
    
    @available(iOS 6.0, *)
    public static let underlineStyle: NSAttributedString.Key // NSNumber containing integer, default 0: no underline
    
    @available(iOS 6.0, *)
    public static let strokeColor: NSAttributedString.Key // UIColor, default nil: same as foreground color
    
    @available(iOS 6.0, *)
    public static let strokeWidth: NSAttributedString.Key // NSNumber containing floating point value, in percent of font point size, default 0: no stroke; positive for stroke alone, negative for stroke and fill (a typical value for outlined text would be 3.0)
    
    @available(iOS 6.0, *)
    public static let shadow: NSAttributedString.Key // NSShadow, default nil: no shadow
    
    @available(iOS 7.0, *)
    public static let textEffect: NSAttributedString.Key // NSString, default nil: no text effect
    
    
    @available(iOS 7.0, *)
    public static let attachment: NSAttributedString.Key // NSTextAttachment, default nil
    
    @available(iOS 7.0, *)
    public static let link: NSAttributedString.Key // NSURL (preferred) or NSString
    
    @available(iOS 7.0, *)
    public static let baselineOffset: NSAttributedString.Key // NSNumber containing floating point value, in points; offset from baseline, default 0
    
    @available(iOS 7.0, *)
    public static let underlineColor: NSAttributedString.Key // UIColor, default nil: same as foreground color
    
    @available(iOS 7.0, *)
    public static let strikethroughColor: NSAttributedString.Key // UIColor, default nil: same as foreground color
    
    @available(iOS 7.0, *)
    public static let obliqueness: NSAttributedString.Key // NSNumber containing floating point value; skew to be applied to glyphs, default 0: no skew
    
    @available(iOS 7.0, *)
    public static let expansion: NSAttributedString.Key // NSNumber containing floating point value; log of expansion factor to be applied to glyphs, default 0: no expansion
    
    
    @available(iOS 7.0, *)
    public static let writingDirection: NSAttributedString.Key // NSArray of NSNumbers representing the nested levels of writing direction overrides as defined by Unicode LRE, RLE, LRO, and RLO characters.  The control characters can be obtained by masking NSWritingDirection and NSWritingDirectionFormatType values.  LRE: NSWritingDirectionLeftToRight|NSWritingDirectionEmbedding, RLE: NSWritingDirectionRightToLeft|NSWritingDirectionEmbedding, LRO: NSWritingDirectionLeftToRight|NSWritingDirectionOverride, RLO: NSWritingDirectionRightToLeft|NSWritingDirectionOverride,
*/
