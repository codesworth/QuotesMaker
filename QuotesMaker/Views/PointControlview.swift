//
//  PointControlview.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 05/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

protocol IntemediaryPadDelegate:class {
    func receivedControlUpdate(_ point:CGPoint)
}

class PointControlView: UIView {
    
    lazy var segments:UISegmentedControl = {
        let seg = UISegmentedControl(frame: .zero)
        seg.insertSegment(withTitle: "Start Point", at: 0, animated: true)
        seg.insertSegment(withTitle: "End Point", at: 1, animated: true)
        seg.tintColor = .gray
        seg.selectedSegmentIndex = 0
        return seg
    }()
    
    lazy var pad:PointControlPad = {
        let pad = PointControlPad(frame: .zero)
        return pad
    }()
    
    weak var delegate:IntemediaryPadDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func commonInit(){
        backgroundColor = .white
        addSubview(segments)
        addSubview(pad)
        pad.delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        NSLayoutConstraint.activate([
            segments.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            segments.leadingAnchor.constraint(equalTo: leadingAnchor),
            segments.trailingAnchor.constraint(equalTo: trailingAnchor),
            segments.heightAnchor.constraint(equalToConstant: 28),
            pad.topAnchor.constraint(equalTo: segments.bottomAnchor, constant: 8),
            pad.leadingAnchor.constraint(equalTo: leadingAnchor),
            pad.trailingAnchor.constraint(equalTo: trailingAnchor),
            pad.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}


extension PointControlView:PadControlDelegate{
    
    func didUpdateControl(_ point: CGPoint) {
        delegate?.receivedControlUpdate(point)
    }
}
