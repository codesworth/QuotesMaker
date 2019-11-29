//
//  PointControlview.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 05/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

protocol IntemediaryPadDelegate:class {
    func receivedControlUpdate(_ point:CGPoint, at:Int)
    func final(_ point:CGPoint, at:Int)
}

class PointControlView: UIView {
    
    lazy var segments:UISegmentedControl = {
        let seg = UISegmentedControl(frame: .zero)
        seg.insertSegment(withTitle: "Start Point", at: 0, animated: true)
        seg.insertSegment(withTitle: "End Point", at: 1, animated: true)
        seg.tintColor = .primaryDark
        seg.selectedSegmentIndex = 0
        return seg
    }()
    
    lazy var label:BasicLabel = {
        let label = BasicLabel(frame: .zero, font: .systemFont(ofSize: 16, weight: .regular))
        label.text = "Gradient Orientation"
        label.textColor = .white
        return label
    }()
    
    lazy var pad:PointControlPad = {
        let pad = PointControlPad(frame: .zero)
        return pad
    }()
    
    weak var delegate:IntemediaryPadDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    private var currentIndex = 0
    
    func commonInit(){
        backgroundColor = .secondaryDark
        //layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMinYCorner]
        addSubview(segments)
        addSubview(pad)
        addSubview(label)
        pad.delegate = self
        segments.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        
    }
    
    @objc func segmentChanged(_ segment:UISegmentedControl){
        currentIndex = segment.selectedSegmentIndex
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            segments.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
            segments.leadingAnchor.constraint(equalTo: leadingAnchor),
            segments.trailingAnchor.constraint(equalTo: trailingAnchor),
            segments.heightAnchor.constraint(equalToConstant: 28),
            pad.topAnchor.constraint(equalTo: segments.bottomAnchor, constant: 16),
            pad.centerXAnchor.constraint(equalTo: centerXAnchor),
            pad.widthAnchor.constraint(equalToConstant: 200),
            pad.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}


extension PointControlView:PadControlDelegate{
    
    func didUpdateControl(_ point: CGPoint) {
        delegate?.receivedControlUpdate(point, at: currentIndex)
    }
    
    func finalPoint(_ point: CGPoint) {
        delegate?.final(point, at: currentIndex)
    }
}
