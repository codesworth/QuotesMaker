//
//  Saving.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 24/04/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import Foundation


extension BaseView{
    
    func generatebaseModels()->[BaseModel]{
        
        let largeModel = subviews.compactMap { (subview) -> BaseModel? in
            guard let baseSub = subview as? BaseSubView else {return nil}
            if let rect = baseSub as? RectView{
                let rectMod = rect.model
                let baseModel = BaseModel(type: .shape, model: rectMod)
                return baseModel
            }
            if let text = baseSub as? BackingTextView{
                let textMod = text.model
                let baseModel = BaseModel(type: .text, model: textMod)
                return baseModel
            }
            
            if let image = baseSub as? BackingImageView{
                image.generateImageSource()
                print(image.model.imageSrc)
                let imgMod = image.model
                let baseModel = BaseModel(type: .image, model: imgMod)
                return baseModel
            }
            return nil
        }
        
        
        //let basemodels =  BaseModelCollection(models: largeModel)
        return largeModel
    }
}
