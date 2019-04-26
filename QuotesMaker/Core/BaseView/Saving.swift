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
    
    func constructFrom(model:[StudioModel]){
        
    }
    
    func offsetLayer(){
        guard let layer = currentSubview else {return}
        layer.center = [layer.center.x + 10,layer.center.y + 10]
    }
    
    func duplicateLayer(){
        
        guard let original = selectedView as? BaseSubView else {return}
        guard let newlayer = original.mutableCopy() as? BaseSubView else {fatalError("Error Casting with mutable copy")}
        addSubviewable(newlayer)
        offsetLayer()
    }
    
    func getThumbnailSrc()->URL?{
        guard let image = makeImageFromView() else {return nil}
        let id = UUID().uuidString
        let url = URL(fileURLWithPath: id, relativeTo: FileManager.previewthumbDir).addExtension(.jpg)
        let data = image.jpegData(compressionQuality: 0.5)
        do{
            try data?.write(to: url)
            return url
        }catch  let err {
            print(":Error Occurred: \(err.localizedDescription)")
        }
        
        return nil
    }
    
}
