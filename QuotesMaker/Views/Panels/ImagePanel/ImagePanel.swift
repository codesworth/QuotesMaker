//
//  ImagePanel.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 11/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

protocol ImagePanelDelegate :class {
    func didSelect(_ option:ImagePanel.PanelOptions)
    
}

//Image Options: Rotate
//Flip left right up down

class ImagePanel: MaterialView {
    
    enum PanelOptions{
        case gallery
        case online
        case cropMode
        case rotate
        case flipVertical
        case flipHorizontal
        case filter
        case aspect(ImageLayerModel.ContentMode)
    }
    
    var aspectIndex = 0
    var contentModes = ImageLayerModel.ContentMode.allCases
    
    lazy var cropButton:TabControl = {
        let tab = TabControl(frame: .zero, image: #imageLiteral(resourceName: "crop"))
        tab.addtarget(self, selector: #selector(cropPressed(_:)))
        return tab
    }()
    
    lazy var rotateButton:TabControl = {
        let tab = TabControl(frame: .zero, image: #imageLiteral(resourceName: "rotate"))
        tab.addtarget(self, selector: #selector(rotatePressed(_:)))
        return tab
    }()
    
    lazy var flipHorizButton:TabControl = {
        let tab = TabControl(frame: .zero, image: #imageLiteral(resourceName: "hflip"))
        tab.addtarget(self, selector: #selector(flipHPressed(_:)))
        return tab
    }()
    
    lazy var flipvertButton:TabControl = {
        let tab = TabControl(frame: .zero, image: #imageLiteral(resourceName: "vflip"))
        tab.addtarget(self, selector: #selector(flipVPressed(_:)))
        return tab
    }()
    
//    lazy var testActionsSegment:UISegmentedControl = {
//        let seg = UISegmentedControl(frame: .zero)
//        seg.insertSegment(withTitle: "Rotate", at: 0, animated: true)
//        seg.insertSegment(withTitle: "Crop", at: 1, animated: true)
//        seg.insertSegment(withTitle: "flip side", at: 2, animated: true)
//        seg.insertSegment(withTitle: "flip up", at: 3, animated: true)
//        seg.tintColor = .primary
//        seg.addTarget(self, action: #selector(segChanged(_:)), for: .valueChanged)
//
//        return seg
//    }()
    
    
    lazy var stack:UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.spacing = 1
        return stack
    }()
    
    lazy var firstline:LineView = {
        let line = LineView(frame: .zero)
        return line
    }()
    
    
    weak var stateDelegate:StateControlDelegate?
    
//    lazy var stateControl:StateChangeControl = {
//        let view = StateChangeControl(frame: .zero)
//        view.undoButt.addTarget(self, action: #selector(undo), for: .touchUpInside)
//        view.redoButt.addTarget(self, action: #selector(redo), for: .touchUpInside)
//        return view
//    }()
    
    

    
    var height:CGFloat{
        if __IS_IPAD{
            return 250
        }
        return 300
    }
    
    lazy var secondline:LineView = {
        let line = LineView(frame: .zero)
        return line
    }()
    weak var delegate:ImagePanelDelegate?
    lazy var header:BasicLabel = {
        let label = BasicLabel(frame: .zero, font: .systemFont(ofSize: 16, weight: .medium))
        label.text = "Image Options"
        return label
    }()
    
    
    
    lazy var closeButton:CloseButton = {
        let butt = CloseButton(type: .roundedRect)
        butt.addTarget(self, action: #selector(donePressed), for: .touchUpInside)
        
        return butt
    }()
    
    
    
    lazy var pickFromGalleryButton:UIButton = {
        let butt = UIButton(frame: [0])
        butt.backgroundColor = .clear
        butt.backgroundColor = .primary
        butt.setTitle("Add From Photos", for: .normal)
        butt.setTitleColor(.white, for: .normal)
        butt.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        butt.titleLabel?.numberOfLines = 2
        butt.borderlize()
        
        return butt
    }()
    
    lazy var addFilterButton:UIButton = {
        let butt = UIButton(frame: [0])
        butt.backgroundColor = .clear
        butt.backgroundColor = .primary
        butt.setTitle("Filters", for: .normal)
        butt.setTitleColor(.white, for: .normal)
        butt.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        butt.titleLabel?.numberOfLines = 2
        butt.borderlize()
        
        return butt
    }()
    
    lazy var aspectSegment:UISegmentedControl = { [unowned self] by in
        let segment = UISegmentedControl(frame: .zero)
        for (index, mode) in contentModes.enumerated(){
            segment.insertSegment(withTitle: mode.rawValue.capitalized, at: index, animated: true)
        }
        segment.selectedSegmentIndex = aspectIndex
        segment.tintColor = .primary
        segment.addTarget(self, action: #selector(aspectChanged(_:)), for: .valueChanged)
        return segment
    }(())
    
    lazy var scrollView:UIScrollView = {
        return .panelScrollView()
    }()
    
    lazy var contentView:UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .white
        return v
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    func addStackViews(){
        stack.addArrangedSubview(rotateButton)
        stack.addArrangedSubview(cropButton)
        stack.addArrangedSubview(flipHorizButton)
        stack.addArrangedSubview(flipvertButton)
    }
    
    func initialize(){
        backgroundColor = .white
        addSubview(header)
        //addSubview(stateControl)
        addSubview(scrollView)
        addSubview(closeButton)
        scrollView.addSubview(contentView)
        contentView.addSubview(firstline)
        contentView.addSubview(secondline)
        contentView.addSubview(pickFromGalleryButton)
        contentView.addSubview(addFilterButton)
        contentView.addSubview(aspectSegment)
        //contentView.addSubview(testActionsSegment)
        addStackViews()
        contentView.addSubview(stack)
        pickFromGalleryButton.addTarget(self, action: #selector(pickImageFromGallery), for: .touchUpInside)
        addFilterButton.addTarget(self, action: #selector(addFilters), for: .touchUpInside)
    }
    
    
    
    
    
}


