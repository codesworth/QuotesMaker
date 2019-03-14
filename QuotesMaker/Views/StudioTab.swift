//
//  StudioTab.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 14/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

protocol StudioTabDelegate:class {
    
    func actiondone(_ action:StudioTab.TabActions)
}

class StudioTab: MaterialView {
    
    enum TabActions{
        case delete
        case layers
    }
    
    let deleteButt:UIButton = {
        let butt = UIButton(frame: .zero)
        butt.setTitle("Delete", for: .normal)
        butt.setTitleColor(.primary, for: .normal)
        butt.backgroundColor = .white
        butt.addTarget(self, action:#selector(deletetabPressed) , for: .touchUpInside)
        butt.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        return butt
    }()
    
    let stackButt:UIButton = {
        let butt = UIButton(frame: .zero)
        butt.setTitle("Layers", for: .normal)
        butt.setTitleColor(.primary, for: .normal)
        butt.backgroundColor = .white
        butt.addTarget(self, action:#selector(layertabPressed) , for: .touchUpInside)
        butt.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        return butt
    }()
    
    weak var delegate:StudioTabDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    @objc func deletetabPressed(){
        delegate?.actiondone(.delete)
    }
    
    @objc func layertabPressed(){
        delegate?.actiondone(.layers)
    }
    
    func initialize(){
        backgroundColor = .primary
        addSubview(deleteButt)
        addSubview(stackButt)
        setCorner(20)
        deleteButt.roundCorners(20)
        deleteButt.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner]
        stackButt.roundCorners(20)
        stackButt.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMaxXMaxYCorner]
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
        let width = (bounds.width / 2) - 1
        subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        NSLayoutConstraint.activate([
            deleteButt.topAnchor.constraint(equalTo: topAnchor),
            deleteButt.leadingAnchor.constraint(equalTo: leadingAnchor),
            deleteButt.bottomAnchor.constraint(equalTo: bottomAnchor),
            deleteButt.widthAnchor.constraint(equalToConstant: width),
            stackButt.topAnchor.constraint(equalTo: topAnchor),
            stackButt.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackButt.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackButt.widthAnchor.constraint(equalToConstant: width),
        ])
    }
}
