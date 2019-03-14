//
//  StudioTab.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 14/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class StudioTab: MaterialView {
    
    let undoButt:UIButton = {
        let butt = UIButton(frame: .zero)
        butt.setTitle("Undo", for: .normal)
        butt.setTitleColor(.primary, for: .normal)
        butt.backgroundColor = .white
        butt.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        return butt
    }()
    
    let redoButt:UIButton = {
        let butt = UIButton(frame: .zero)
        butt.setTitle("Redo", for: .normal)
        butt.setTitleColor(.primary, for: .normal)
        butt.backgroundColor = .white
        butt.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        return butt
    }()
    
    let stackButt:UIButton = {
        let butt = UIButton(frame: .zero)
        butt.setTitle("Layers", for: .normal)
        butt.setTitleColor(.primary, for: .normal)
        butt.backgroundColor = .white
        butt.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        return butt
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    func initialize(){
        backgroundColor = .primary
        addSubview(undoButt)
        addSubview(stackButt)
        addSubview(redoButt)
        setCorner(20)
        undoButt.roundCorners(20)
        undoButt.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner]
        redoButt.roundCorners(20)
        redoButt.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMaxXMaxYCorner]
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = (bounds.width / 3) - 2
        subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        NSLayoutConstraint.activate([
            undoButt.topAnchor.constraint(equalTo: topAnchor),
            undoButt.leadingAnchor.constraint(equalTo: leadingAnchor),
            undoButt.bottomAnchor.constraint(equalTo: bottomAnchor),
            undoButt.widthAnchor.constraint(equalToConstant: width),
            stackButt.topAnchor.constraint(equalTo: topAnchor),
            stackButt.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackButt.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackButt.widthAnchor.constraint(equalToConstant: width),
            redoButt.topAnchor.constraint(equalTo: topAnchor),
            redoButt.trailingAnchor.constraint(equalTo: trailingAnchor),
            redoButt.bottomAnchor.constraint(equalTo: bottomAnchor),
            redoButt.widthAnchor.constraint(equalToConstant: width),
        ])
    }
}
