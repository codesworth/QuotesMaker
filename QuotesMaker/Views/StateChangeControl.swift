//
//  StateChangeControl.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 14/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

protocol StateControlDelegate:class {
    
    func stateChanged(_ type:StateChangeControl.ChangeType)
}

class StateChangeControl: UIView{
    
    enum ChangeType{
        case undo, redo
    }

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
    
    func initialize(){
        backgroundColor = .white
        addSubview(undoButt)
        addSubview(redoButt)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        undoButt.roundCorners(10)
        redoButt.roundCorners(10)
        
        NSLayoutConstraint.activate([
            undoButt.leadingAnchor.constraint(equalTo: leadingAnchor),
            undoButt.topAnchor.constraint(equalTo: topAnchor),
            undoButt.widthAnchor.constraint(equalToConstant: 20),
            undoButt.heightAnchor.constraint(equalToConstant: 20),
            redoButt.trailingAnchor.constraint(equalTo: trailingAnchor),
            redoButt.topAnchor.constraint(equalTo: topAnchor),
            redoButt.widthAnchor.constraint(equalToConstant: 20),
            redoButt.heightAnchor.constraint(equalToConstant: 20),
        ])
    }

}


extension UIButton{
    
    func registerUndo(){
        addTarget(self, action: #selector(undo), for: .touchUpInside)
    }
    
    @objc func undo(){
        
    }
}
