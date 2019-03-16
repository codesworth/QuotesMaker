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
    var previousModels:[ImageLayerModel] = []
    var redoModels:[ImageLayerModel] = []
    
    var model:ImageLayerModel!{
        didSet{
            image = model.image
        }
    }
    
    var uid:UUID = UUID()
    
    func setImage(image:UIImage){
        previousModels.push(model)
        var new = model
        new!.image = image
        model = new!
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Notifications.Name.canUndo.rawValue), object: nil)
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
        backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        model = ImageLayerModel()
        contentMode = .scaleAspectFill
        isUserInteractionEnabled = true
        setResizableGesture()
        setPanGesture()
        movedInFocus()
        clipsToBounds = true
    }

}


extension BackingImageView:StateChangeable{
    
    func stateRedo() {
        guard !redoModels.isEmpty else {return}
        let model = redoModels.pop()
        self.model = model
    }
    
    func stateUndo() {
        guard !previousModels.isEmpty else {return}
        let model = previousModels.pop()
        self.model = model
        redoModels.append(model)
        
    }
}

extension BackingImageView:BaseviewSubViewable{}
