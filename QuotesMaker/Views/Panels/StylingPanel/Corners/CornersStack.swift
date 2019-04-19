//
//  CornersStack.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 01/04/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

//protocol CornerMaskDelegate:class {
//
//    func didUpdate(_ cornerMask:CACornerMask)
//}

class CornerStack:UIView{
    
    //weak var delegate:CornerMaskDelegate?
    lazy var cornerlable:BasicLabel = {
        return .basicLabel("Round Corners")
    }()
    
    lazy var clippingView:UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .white
        v.borderlize(.gray, 0.5)
        v.roundCorners(10)
        return v
    }()
    
    private var corners:CACornerMask = []
    
    lazy var topStack:UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        return stack
    }()
    
    lazy var bottomStack:UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        return stack
    }()
    
    lazy var containerStack:UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        return stack
    }()
    
    lazy var topRButt:UIButton = {
        let butt = UIButton(frame: .zero)
        butt.setTitle("TR", for: .normal)
        butt.setTitleColor(.primary, for: .normal)
        butt.addTarget(self, action: #selector(selected(_:)), for: .touchUpInside)
        butt.backgroundColor = UIColor.groupTableViewBackground
        butt.borderlize(.gray, 0.5)
        return butt
    }()
    
    lazy var topLButt:UIButton = {
        let butt = UIButton(frame: .zero)
        butt.setTitle("TL", for: .normal)
        butt.setTitleColor(.primary, for: .normal)
        butt.addTarget(self, action: #selector(selected(_:)), for: .touchUpInside)
        butt.backgroundColor = UIColor.groupTableViewBackground
        butt.borderlize(.gray, 0.5)
        return butt
    }()
    
    lazy var bottomRButt:UIButton = {
        let butt = UIButton(frame: .zero)
        butt.setTitle("BR", for: .normal)
        butt.setTitleColor(.primary, for: .normal)
        butt.addTarget(self, action: #selector(selected(_:)), for: .touchUpInside)
        butt.backgroundColor =  UIColor.groupTableViewBackground
        butt.borderlize(.gray, 0.5)
        return butt
    }()
    
    lazy var bottomLButt:UIButton = {
        let butt = UIButton(frame: .zero)
        butt.setTitle("BL", for: .normal)
        butt.setTitleColor(.primary, for: .normal)
        butt.addTarget(self, action: #selector(selected(_:)), for: .touchUpInside)
        butt.backgroundColor = UIColor.groupTableViewBackground
        butt.borderlize(.gray, 0.5)
        return butt
    }()
    
    @objc func selected(_ sender:UIButton){
        guard let title = sender.title(for: .normal) else {return}
        switch title {
        case "TR":
            updateCorner(corner: .layerMinXMinYCorner, sender: sender)
            break
        case "TL":
            updateCorner(corner: .layerMaxXMinYCorner, sender: sender)
            break
        case "BR":
            updateCorner(corner: .layerMinXMaxYCorner, sender: sender)
        case "BL":
            updateCorner(corner: .layerMaxXMaxYCorner, sender: sender)
        default:
            break
        }
        Subscription.main.post(suscription: .cornermask, object: corners)
//        delegate?.didUpdate(corners)
        
    }
    
    func layoutCorners(corner:CACornerMask){
        self.corners = corner
        if corner.contains(.layerMinXMinYCorner){
            topRButt.backgroundColor = .primary
            topRButt.setTitleColor(.white, for: .normal)
        }else{
            topRButt.backgroundColor = .groupTableViewBackground
            topRButt.setTitleColor(.primary, for: .normal)
        }
        if corner.contains(.layerMinXMaxYCorner){
            bottomRButt.backgroundColor = .primary
            bottomRButt.setTitleColor(.white, for: .normal)
        }else{
            bottomRButt.backgroundColor = .groupTableViewBackground
            bottomRButt.setTitleColor(.primary, for: .normal)
        }
        if corner.contains(.layerMaxXMinYCorner){
            topLButt.backgroundColor = .primary
            topLButt.setTitleColor(.white, for: .normal)
        }else{
            topLButt.backgroundColor = .groupTableViewBackground
            topLButt.setTitleColor(.primary, for: .normal)
        }
        if corner.contains(.layerMaxXMaxYCorner){
            bottomLButt.backgroundColor = .primary
            bottomLButt.setTitleColor(.white, for: .normal)
        }else{
            bottomLButt.backgroundColor = .groupTableViewBackground
            bottomLButt.setTitleColor(.primary, for: .normal)
        }
    }
    
    func updateCorner(corner:CACornerMask, sender:UIButton){
        if corners.contains(corner){
            corners.remove(corner)
            sender.backgroundColor = .groupTableViewBackground
            sender.setTitleColor(.primary, for: .normal)
        }else{
            corners.insert(corner)
            sender.backgroundColor = .primary
            sender.setTitleColor(.white, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    
    private func initialize(){
        backgroundColor = .white
        topStack.addArrangedSubview(topRButt)
        topStack.addArrangedSubview(topLButt)
        bottomStack.addArrangedSubview(bottomRButt)
        bottomStack.addArrangedSubview(bottomLButt)
        containerStack.addArrangedSubview(topStack)
        containerStack.addArrangedSubview(bottomStack)
        clippingView.addSubview(containerStack)
        addSubview(clippingView)
        addSubview(cornerlable)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cornerlable.layout{
            $0.leading == leadingAnchor + 8
            $0.top == topAnchor + 40
            
        }
        clippingView.layout{
            $0.top == topAnchor + 8
            $0.trailing == trailingAnchor - 16
            $0.width |=| 180
            $0.height |=| 80
        }
        
        containerStack.layout{
            $0.top == clippingView.topAnchor
            $0.trailing == clippingView.trailingAnchor
//            $0.width |=| 200
//            $0.height |=| 100
            $0.leading == clippingView.leadingAnchor
            $0.bottom == clippingView.bottomAnchor
        }
        
        
    }
}
