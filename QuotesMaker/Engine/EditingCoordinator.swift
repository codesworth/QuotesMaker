//
//  EditingCoordinator.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 05/04/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


class EditingCoordinator{
    
    var baseView:BaseView
    
    init(){
        baseView = BaseView(frame: .zero)
        let size = Dimensions.sizeForAspect(.square)
        baseView.frame = CGRect(origin: .zero, size: size)
    }
    
    
    
    
}
