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
        case moveUp
        case moveDown
        case wakePanel
        case select
    }
    
    let paneltab:TabControl = {
        let butt = TabControl(frame: .zero, image:#imageLiteral(resourceName: "panel") )
        butt.addTarget(self, action:#selector(wakePanel) , for: .touchUpInside)
        return butt
    }()
    let deleteButt:TabControl = {
        let butt = TabControl(frame: .zero, image: #imageLiteral(resourceName: "delete"))
        butt.addTarget(self, action:#selector(deletetabPressed) , for: .touchUpInside)
        return butt
    }()
    
    let stackButt:TabControl = {
        let butt = TabControl(frame: .zero, image: #imageLiteral(resourceName: "stack"))
        butt.addTarget(self, action:#selector(layertabPressed) , for: .touchUpInside)
        
        return butt
    }()
    
    let moveupButt:TabControl = {
       let butt = TabControl(frame: .zero, image: #imageLiteral(resourceName: "mup"))
        butt.addTarget(self, action:#selector(movedUpPressed) , for: .touchUpInside)
        
        return butt
    }()
    
    let moveDownButt:TabControl = {
        let butt = TabControl(frame: .zero, image: #imageLiteral(resourceName: "mdw"))
        butt.addTarget(self, action:#selector(movedDownPressed) , for: .touchUpInside)
        
        return butt
    }()
    
    private lazy var collectionview:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        return view
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
    
    @objc func movedDownPressed(){
        delegate?.actiondone(.moveDown)
    }
    
    @objc func movedUpPressed(){
        delegate?.actiondone(.moveUp)
    }
    
    @objc func wakePanel(){
        delegate?.actiondone(.wakePanel)
    }
    
    
    
    func initialize(){
        backgroundColor = .primary
        addSubview(deleteButt)
        addSubview(stackButt)
        addSubview(moveupButt)
        addSubview(moveDownButt)
        addSubview(paneltab)
        setCorner(4)
        
        //deleteButt.roundCorners(20)
//        if #available(iOS 11.0, *) {
//            deleteButt.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner]
//        } else {
//            var cornerMask = UIRectCorner()
//            // Fallback on earlier versions
//        }
//        stackButt.roundCorners(20)
//        if #available(iOS 11.0, *) {
//            stackButt.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMaxXMaxYCorner]
//        } else {
//            // Fallback on earlier versions
//        }
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
        paneltab.roundCorners([.layerMinXMinYCorner,.layerMinXMaxYCorner], radius: 4)
        stackButt.roundCorners([.layerMaxXMinYCorner,.layerMaxXMaxYCorner], radius: 4)
        let width = (bounds.width - 4) / 5
        subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        NSLayoutConstraint.activate([
            paneltab.topAnchor.constraint(equalTo: topAnchor),
            paneltab.leadingAnchor.constraint(equalTo: leadingAnchor),
            paneltab.bottomAnchor.constraint(equalTo: bottomAnchor),
            paneltab.widthAnchor.constraint(equalToConstant: width),
            
            deleteButt.topAnchor.constraint(equalTo: topAnchor),
            deleteButt.leadingAnchor.constraint(equalTo: paneltab.trailingAnchor, constant:1),
            deleteButt.bottomAnchor.constraint(equalTo: bottomAnchor),
            deleteButt.widthAnchor.constraint(equalToConstant: width),
            moveupButt.topAnchor.constraint(equalTo: topAnchor),
            moveupButt.leadingAnchor.constraint(equalTo: deleteButt.trailingAnchor,constant:1),
            moveupButt.bottomAnchor.constraint(equalTo: bottomAnchor),
            moveupButt.widthAnchor.constraint(equalToConstant:width),
            moveDownButt.topAnchor.constraint(equalTo: topAnchor),
            moveDownButt.leadingAnchor.constraint(equalTo: moveupButt.trailingAnchor,constant:1),
            moveDownButt.bottomAnchor.constraint(equalTo: bottomAnchor),
            moveDownButt.widthAnchor.constraint(equalToConstant:width),
            stackButt.topAnchor.constraint(equalTo: topAnchor),
            stackButt.leadingAnchor.constraint(equalTo: moveDownButt.trailingAnchor, constant:1),
            stackButt.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackButt.widthAnchor.constraint(equalToConstant: width),
        ])
    }
}
