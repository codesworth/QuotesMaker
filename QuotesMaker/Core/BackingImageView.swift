//
//  BackingImageView.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 08/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class BackingImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    var model:ImageLayerModel!{
        didSet{
            
        }
    }
    
    var id:String{
        return "Image \(id_tag)"
    }
    var id_tag: Int = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    func initialize(){
        model = ImageLayerModel()
        contentMode = .scaleAspectFill
        isUserInteractionEnabled = true
        setResizableGesture()
        setPanGesture()
        movedInFocus()
        clipsToBounds = true
    }

}
