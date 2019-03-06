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
        lab.attributedText = NSAttributedString(string: "Fonts", attributes: [.underlineStyle:1])
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
    
    lazy var fontSizeLable:BasicLabel = {
        let lab = BasicLabel.basicMake()
        lab.text = "Size: "
        return lab
    }()
    lazy var underlinelable:BasicLabel = {
        let lab = BasicLabel.basicMake()
        lab.text = "Size: "
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
        stepper.minimumValue = 10
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
        stepper.maximumValue = 100
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
        stepper.maximumValue = 100
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
        stepper.maximumValue = 100
        stepper.minimumValue = 0
        stepper.stepValue = 1
        stepper.value = 0
        stepper.tintColor = .primary
        return stepper
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
    }
}



extension TextDesignableInputView:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fonts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(FontCells.self)", for: indexPath) as? FontCells{
            let font = fonts[indexPath.row]
            cell.configure(font: font)
            return cell
        }
        return FontCells()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return [80,60]
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        chosenFont = fonts[indexPath.row].font.fontName
        let newFont = UIFont(name: chosenFont, size: CGFloat(fontSizeStepper.value))!
        model.font = newFont
        delegate?.didUpdateModel(model)
    }
    
}

extension TextDesignableInputView{
    
    @objc func colorSliderChanged(_ slider:ColorSlider){
        
        let color = slider.color
        model.textColor = color
        delegate?.didUpdateModel(model)
    }
    
    @objc func fontSizeXhanged(_ stepper:UIStepper){
        let val = stepper.value
        fontSizeLable.text =  "Size: \(val)"
        let newFont = UIFont(name: chosenFont, size: CGFloat(val))!
        model.font = newFont
        delegate?.didUpdateModel(model)
    }
    
    @objc func strokecolorSliderChanged(_ slider:ColorSlider){
        
        let color = slider.color
        model.strokeColor = color
        delegate?.didUpdateModel(model)
    }
    
    @objc func strokeWidthCanged(_ stepper:UIStepper){
        let val = stepper.value
        fontSizeLable.text =  "Size: \(val)"
        model.strokeWidth = Int(val)
        delegate?.didUpdateModel(model)
    }
    
    @objc func underlineStyleColorChanged(_ slider:ColorSlider){
        
        let color = slider.color
        model.underlineColor = color
        delegate?.didUpdateModel(model)
    }
    
    @objc func underlineStyleChanged(_ stepper:UIStepper){
        let val = stepper.value
        
        model.underlineStyle = Int(val)
        delegate?.didUpdateModel(model)
    }
    
    @objc func strikeThroughcolorSliderChanged(_ slider:ColorSlider){
        
        let color = slider.color
        model.strikeThroughColor = color
        delegate?.didUpdateModel(model)
    }
    
    @objc func strikeThroughStylehanged(_ stepper:UIStepper){
        let val = stepper.value
        model.strikeThrough = Int(val)
        delegate?.didUpdateModel(model)
    }
    
    @objc func obliquessChanged(_ stepper:UIStepper){
        let val = stepper.value
        model.obliquess = Int(val)
        delegate?.didUpdateModel(model)
    }
    
    func registrationsAndtargetSets(){
        fontCollectionview.register(UINib(nibName: "\(FontCells.self)", bundle: nil), forCellWithReuseIdentifier: "\(FontCells.self)")
        colorSlider.addTarget(self, action: #selector(colorSliderChanged(_:)), for: .valueChanged)
        fontSizeStepper.addTarget(self, action: #selector(fontSizeXhanged(_:)), for: .valueChanged)
        fontCollectionview.delegate = self
        fontCollectionview.dataSource = self
        strokeColorSlider.addTarget(self, action: #selector(strokecolorSliderChanged(_:)), for: .valueChanged)
        strokeWidthStepper.addTarget(self, action: #selector(strokeWidthCanged(_:)), for: .valueChanged)
        underlineColorSlider.addTarget(self, action: #selector(underlineStyleColorChanged(_:)), for: .valueChanged)
        underlineStyleStepper.addTarget(self, action: #selector(underlineStyleChanged(_:)), for: .valueChanged)
        strikeThroghColorSlider.addTarget(self, action: #selector(strikeThroughcolorSliderChanged(_:)), for: .valueChanged)
        strikeThroughStyleStepper.addTarget(self, action: #selector(strikeThroughStylehanged(_:)), for: .valueChanged)
        obliqueStepper.addTarget(self, action: #selector(obliquessChanged(_:)), for: .valueChanged)
    }
    
    
}



extension TextDesignableInputView{
    
    func setConstraints(){
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.widthAnchor.constraint(equalTo: widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 540),
            titleLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLable.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            headlineline.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 4),
            headlineline.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 48),
            headlineline.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -48),
            headlineline.heightAnchor.constraint(equalToConstant: 1),
            fontCollectionview.topAnchor.constraint(equalTo: headlineline.bottomAnchor, constant: 12),
            fontCollectionview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            fontCollectionview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            fontCollectionview.heightAnchor.constraint(equalToConstant: 80),
            firstline.topAnchor.constraint(equalTo: fontCollectionview.bottomAnchor, constant: 8),
            firstline.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            firstline.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            firstline.heightAnchor.constraint(equalToConstant: 1),
            fontSizeLable.topAnchor.constraint(equalTo: firstline.bottomAnchor, constant: 8),
            fontSizeLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            fontColorLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            fontColorLable.topAnchor.constraint(equalTo: firstline.bottomAnchor, constant: 12),
            fontSizeStepper.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            fontSizeStepper.topAnchor.constraint(equalTo: fontSizeLable.bottomAnchor, constant: 8),
            colorSlider.topAnchor.constraint(equalTo: fontColorLable.bottomAnchor, constant: 8),
            colorSlider.leadingAnchor.constraint(equalTo: fontSizeStepper.trailingAnchor, constant: 30),
            colorSlider.heightAnchor.constraint(equalToConstant: 20),
            colorSlider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            secondline.topAnchor.constraint(equalTo: colorSlider.bottomAnchor, constant: 24),
            secondline.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            secondline.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            secondline.heightAnchor.constraint(equalToConstant: 1),
            
        ])
    }
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
