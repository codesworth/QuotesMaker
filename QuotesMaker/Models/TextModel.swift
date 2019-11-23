//
//  TextModel.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 05/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


struct TextLayerModel:Codable {
    
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        string = try container.decodeIfPresent(String.self, forKey: .string) ?? "Hello"
        _textColor = try container.decodeIfPresent(StudioColor.self, forKey: ._textColor) ?? StudioColor(color: .black)
        _font =  try container.decodeIfPresent(StudioFont.self, forKey: ._font) ?? StudioFont(font: UIFont(name: "RobotoMono-Regular", size: 20)!)
        shadowBlur = try container.decodeIfPresent(CGFloat.self, forKey: .shadowBlur) ?? 0
        shadowOffset = try container.decodeIfPresent(CGSize.self, forKey: .shadowOffset) ?? .zero
        strikeThrough = try container.decodeIfPresent(Int.self, forKey: .strikeThrough) ?? 0
        _strikeThroughColor = try container.decodeIfPresent(StudioColor.self, forKey: ._strikeThroughColor) ?? nil
        _strokeColor = try container.decodeIfPresent(StudioColor.self, forKey: ._strokeColor) ?? nil
        _underlineColor = try container.decodeIfPresent(StudioColor.self, forKey: ._underlineColor) ?? nil
        underlineStyle = try container.decodeIfPresent(Int.self, forKey: .underlineStyle) ?? 0
        strokeWidth = try container.decodeIfPresent(Int.self, forKey: .strokeWidth) ?? 0
        obliquess = try container.decodeIfPresent(Int.self, forKey: .obliquess) ?? 0
        layerFrame = try container.decodeIfPresent(LayerFrame.self, forKey: .layerFrame)
        alignment = try container.decodeIfPresent(Int.self, forKey: .alignment) ?? 0
        shadowAlpha = try container.decodeIfPresent(CGFloat.self, forKey: .shadowAlpha) ?? 0.3
        _shadowColor = try container.decodeIfPresent(StudioColor.self, forKey: ._shadowColor) ?? .clear
        style = try container.decodeIfPresent(Style.self, forKey: .style) ?? Style()
        layerIndex = try container.decodeIfPresent(CGFloat.self, forKey: .layerIndex) ?? 0
        updateTime = try container.decodeIfPresent(TimeInterval.self, forKey: .updateTime) ?? Date().timeIntervalSinceReferenceDate
    }
    
    var string:String = "Hello"
    private var _textColor:StudioColor = .black
    var _font:StudioFont = StudioFont(font: UIFont(name: "RobotoMono-Regular", size: 20)!)
    var font:UIFont{
        get{
            return _font.font ?? UIFont(name: "RobotoMono-Regular", size: 20)!
        }
        set{
            _font = StudioFont(font: newValue)
        }
    }
    
    

    private  var shadowBlur:CGFloat = 0
    private var shadowOffset:CGSize = .zero
    var strikeThrough:Int = 0
    private var _strikeThroughColor:StudioColor?
    private var _strokeColor:StudioColor?
    var underlineStyle:Int = 0
    var strokeWidth:Int = 0
    var obliquess:Int = 0
    var layerFrame:LayerFrame?
    var alignment:Int = 0
    
    
    func setAlignment()->NSTextAlignment{
        if alignment == 0{
            return .left
        }
        if alignment == 1{
            return .center
        }
        if alignment == 2{
            return .right
        }
        if alignment == 3{
            return .justified
        }
        
        return .natural
    }
    
    var shadow:NSShadow{
        get{
            let shadow = NSShadow()
            shadow.shadowColor = shadowColor
            shadow.shadowBlurRadius = shadowBlur
            shadow.shadowOffset = shadowOffset
            return shadow
        }
        set{
            shadowColor = newValue.shadowColor as? UIColor ?? shadowColor
            shadowBlur = newValue.shadowBlurRadius
            shadowOffset = newValue.shadowOffset
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
            .shadow:shadow,
            
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
