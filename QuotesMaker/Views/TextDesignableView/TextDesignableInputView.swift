//
//  TextDesignableInputView.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 06/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit



protocol TextModelDelegate:class {
    func didUpdateModel(_ model:TextLayerModel)
}

class TextDesignableInputView:UIView{
    
    var fonts = UIFont.getFeaturedFonts()
    
    lazy var titleLable:BasicLabel = {
        let lab = BasicLabel(frame: .zero, font: .systemFont(ofSize: 16, weight: .regular))
        lab.attributedText = NSAttributedString(string: "Fonts", attributes: [:])
        return lab
    }()
    
    var model:TextLayerModel!
    var chosenFont:String!
    weak var delegate:TextModelDelegate?
    
    lazy var fontCollectionview:UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        let col = UICollectionView(frame: .zero, collectionViewLayout: flow)
        col.backgroundColor = .clear
        return col
    }()
    
    lazy var headlineline:LineView = {
        return LineView.getLine()
    }()
    
    lazy var firstline:LineView = {
        return LineView.getLine()
    }()
    
    lazy var secondline:LineView = {
        return LineView.getLine()
    }()
    
    lazy var thirdline:LineView = {
        return LineView.getLine()
    }()
    
    lazy var fourthline:LineView = {
        return LineView.getLine()
    }()
    
    lazy var fifthline:LineView = {
        return LineView.getLine()
    }()
    
    lazy var fontSizeLable:BasicLabel = {
        let lab = BasicLabel.basicMake()
        lab.text = "Size: "
        return lab
    }()
    lazy var underlinelable:BasicLabel = {
        let lab = BasicLabel.basicMake()
        lab.text = "Underline"
        return lab
    }()
    
    lazy var underlineStylelable:BasicLabel = {
        let lab = BasicLabel.basicMake()
        lab.text = "Style"
        return lab
    }()
    
    lazy var underlineColorlable:BasicLabel = {
        let lab = BasicLabel.basicMake()
        lab.text = "Color"
        return lab
    }()
    
    lazy var strokeLabel:BasicLabel = {
        let lab = BasicLabel.basicMake()
        lab.text = "Text Stroke"
        return lab
    }()
    
    lazy var strokeWidthLabel:BasicLabel = {
        let lab = BasicLabel.basicMake()
        lab.text = "Stroke width:"
        return lab
    }()
    
    lazy var strokeColorLabel:BasicLabel = {
        let lab = BasicLabel.basicMake()
        lab.text = "Stroke Color"
        return lab
    }()
    
    lazy var strikeLabel:BasicLabel = {
        let lab = BasicLabel.basicMake()
        lab.text = "Strikethrough"
        return lab
    }()
    
    lazy var strikeStyleLabel:BasicLabel = {
        let lab = BasicLabel.basicMake()
        lab.text = "Style"
        return lab
    }()
    
    lazy var strikeColorLabel:BasicLabel = {
        let lab = BasicLabel.basicMake()
        lab.text = "Color"
        return lab
    }()
    
    lazy var obliqLabel:BasicLabel = {
        let lab = BasicLabel.basicMake()
        lab.text = "Obliqueness"
        return lab
    }()
    
    lazy var obliqStyleLabel:BasicLabel = {
        let lab = BasicLabel.basicMake()
        lab.text = "Style: "
        return lab
    }()
    
    lazy var fontColorLable:BasicLabel = {
        let lab = BasicLabel.basicMake()
        lab.text = "Color"
        return lab
    }()
    
    lazy var scrollView:UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.bounces = true
        scroll.isScrollEnabled = true
        return scroll
    }()
    
    lazy var contentView:UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .white
        return v
    }()
    
    lazy var fontSizeStepper:UIStepper = {
        let stepper = UIStepper(frame: .zero)
        stepper.maximumValue = 100
        stepper.minimumValue = 10
        stepper.stepValue = 1
        stepper.value = 27
        stepper.tintColor = .primary
        return stepper
    }()
    
    lazy var colorSlider:ColorSlider = {
        let slider = ColorSlider(orientation: .horizontal, previewSide: .top)
        return slider
    }()
    
    lazy var strokeWidthStepper:UIStepper = {
        let stepper = UIStepper(frame: .zero)
        stepper.maximumValue = 100
        stepper.minimumValue = -10
        stepper.stepValue = 1
        stepper.value = 0
        stepper.tintColor = .primary
        return stepper
    }()
    
    lazy var strokeColorSlider:ColorSlider = {
        let slider = ColorSlider(orientation: .horizontal, previewSide: .top)
        return slider
    }()
    
    lazy var underlineStyleStepper:UIStepper = {
        let stepper = UIStepper(frame: .zero)
        stepper.maximumValue = 8
        stepper.minimumValue = 0
        stepper.stepValue = 1
        stepper.value = 0
        stepper.tintColor = .primary
        return stepper
    }()
    
    lazy var underlineColorSlider:ColorSlider = {
        let slider = ColorSlider(orientation: .horizontal, previewSide: .top)
        return slider
    }()
    
    lazy var strikeThroughStyleStepper:UIStepper = {
        let stepper = UIStepper(frame: .zero)
        stepper.maximumValue = 8
        stepper.minimumValue = 0
        stepper.stepValue = 1
        stepper.value = 0
        stepper.tintColor = .primary
        return stepper
    }()
    
    lazy var strikeThroghColorSlider:ColorSlider = {
        let slider = ColorSlider(orientation: .horizontal, previewSide: .top)
        return slider
    }()
    
    lazy var obliqueStepper:UIStepper = {
        let stepper = UIStepper(frame: .zero)
        stepper.maximumValue = 10
        stepper.minimumValue = -10
        stepper.stepValue = 1
        stepper.value = 0
        stepper.tintColor = .primary
        return stepper
    }()
    
    lazy var shadowView:ShadowPanel = {
        let selectors:ShadowPanel.Selectors =
            (#selector(shadowColorChanged(_:)),
             #selector(shadowRadiusChanged(_:)),
             #selector(shadowXChanged(_:)),
             #selector(shadowYChanged(_:)),
             #selector(shadowOpacityChanged(_:)),
             #selector(shadowColorChanging(_:)),
             #selector(shadowOpacityChanging(_:)))
        let panel = ShadowPanel(frame: .zero)
        panel.setTargets(object: self, selectors: selectors)
        return panel
        
    }()
    

    
    
    
    init(frame: CGRect, model:TextLayerModel) {
        super.init(frame:frame)
        initialize()
        self.model = model
        chosenFont = model.font.fontName
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    func initialize(){
        addsubviews()
        registrationsAndtargetSets()
    }
    

    
    override func layoutSubviews() {
        super.layoutSubviews()
        subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        scrollView.subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        contentView.subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        setConstraints()
        
    }
    
    func addsubviews(){
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLable)
        contentView.addSubview(fontSizeLable)
        contentView.addSubview(firstline)
        contentView.addSubview(secondline)
        contentView.addSubview(thirdline)
        contentView.addSubview(strokeWidthStepper)
        contentView.addSubview(strokeColorSlider)
        contentView.addSubview(underlineStyleStepper)
        contentView.addSubview(underlineColorSlider)
        contentView.addSubview(strikeThroughStyleStepper)
        contentView.addSubview(strikeThroghColorSlider)
        contentView.addSubview(obliqueStepper)
        contentView.addSubview(fontSizeStepper)
        contentView.addSubview(fontColorLable)
        contentView.addSubview(colorSlider)
        contentView.addSubview(fontCollectionview)
        contentView.addSubview(fourthline)
        contentView.addSubview(fifthline)
        contentView.addSubview(strokeColorLabel)
        contentView.addSubview(strokeWidthLabel)
        contentView.addSubview(strokeLabel)
        contentView.addSubview(strikeColorLabel)
        contentView.addSubview(strikeStyleLabel)
        contentView.addSubview(strikeLabel)
        contentView.addSubview(underlinelable)
        contentView.addSubview(underlineColorlable)
        contentView.addSubview(underlineStylelable)
        contentView.addSubview(obliqLabel)
        contentView.addSubview(obliqStyleLabel)
        contentView.addSubview(headlineline)
    }
}









extension TextDesignableInputView{
    
    
}


//Font Type
//Font size
//Font Color
//Stroke Width
//strokecolor
//underlineStyle
//underlineColor
// underline
//strikethrough
