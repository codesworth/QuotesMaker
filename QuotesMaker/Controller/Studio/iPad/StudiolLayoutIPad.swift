//
//  StudiolLayoutIPad.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 02/04/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import Foundation


extension StudioVC{
    
    func iPadLayout(){
        studioTab.layout{
            $0.top == view.topAnchor
            $0.leading == view.leadingAnchor
            $0.trailing == view.trailingAnchor
            $0.height |=| 40
        }
    }
}
