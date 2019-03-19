//
//  +Resizing.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 18/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


extension BaseView{
    
    
    func enterResizeMode(){
        
        guard let current = currentSubview else {return}
        resizingMode = true
        let frame = current.frame
        resizerView.frame = frame
        resizerView.contentView = current
        addSubview(resizerView)
        
    }
    
    func exitResizingModeFromGet()->UIView?{
        guard resizingMode else {return subviews.last}
        let frame = resizerView.frame
        let view = resizerView.contentView!
        addSubview(view)
        view.frame = frame
        resizerView.removeFromSuperview()
        return view
    }
}
