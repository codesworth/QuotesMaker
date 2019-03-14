//
//  StateChangeControl.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 14/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class StateChangeControl: MaterialView {

    let undoButt:UIButton = {
        let butt = UIButton(frame: .zero)
        butt.setTitle("Undo", for: .normal)
        butt.setTitleColor(.primary, for: .normal)
        butt.backgroundColor = .white
        butt.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        butt.addTarget(self, action: #selector(actionUndone), for: .touchUpInside)
        return butt
    }()
    
    @objc func actionUndone(){
        
    }
    
    let redoButt:UIButton = {
        let butt = UIButton(frame: .zero)
        butt.setTitle("Redo", for: .normal)
        butt.setTitleColor(.primary, for: .normal)
        butt.backgroundColor = .white
        butt.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        return butt
    }()

}
