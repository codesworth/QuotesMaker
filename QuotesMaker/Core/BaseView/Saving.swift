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
                //print(image.model.imageSrc)
                let imgMod = image.model
                let baseModel = BaseModel(type: .image, model: imgMod)
                if let src = image.model.imageSrc{ Persistence.main.updateImage(src: src)}
                return baseModel
            }
            return nil
        }
        
        
        //let basemodels =  BaseModelCollection(models: largeModel)
        return largeModel
    }
    
    func constructFrom(model:StudioModel){
        let models = model.models.sorted{$0.layerIndex < $1.layerIndex}
        backgroundColor = model.backgroundColor?.color ?? .white
        models.forEach{
            if $0.modelType == ModelType.shape.rawValue{
                let rect = RectView(frame: $0.layerFrame.awakeFrom(bounds: bounds))
                rect.model = $0.shape!
                addSubviewable(rect,center:false)
            }else if $0.modelType == ModelType.image.rawValue{
                let rect = BackingImageView(frame: $0.layerFrame.awakeFrom(bounds: bounds))
                rect.model = $0.image!
                if let src = $0.image?.imageSrc{
                    let url = URL(fileURLWithPath: src, relativeTo: FileManager.modelImagesDir)
                    print("Image source directory is:\(url.path)")
                    let image = UIImage(contentsOfFile: url.path)
                    rect.image = image
                }
                addSubviewable(rect,center:false)
            }else if $0.modelType == ModelType.text.rawValue{
                let rect = BackingTextView(frame: $0.layerFrame.awakeFrom(bounds: bounds))
                rect.model = $0.text!
                addSubviewable(rect,center:false)
            }
        }
    }
    
    func offsetLayer(){
        guard let layer = currentSubview else {return}
        layer.center = [layer.center.x + 10,layer.center.y + 10]
    }
    
    func duplicateLayer(){
        
        guard let original = selectedView as? BaseSubView else {return}
        let newlayer:BaseSubView
        if let original = original as? RectView{
            let frame = original.model.layerFrame?.awakeFrom(bounds: bounds)
            let rect = RectView(frame: frame ?? subBounds)
            rect.model = original.model
            newlayer = rect
        }
        else if let original = original as? BackingImageView{
            let frame = original.model.layerFrame?.awakeFrom(bounds: bounds)
            let img = BackingImageView(frame: frame ?? subBounds)
            img.model = original.model
            img.image = original.image
            newlayer = img
        }else{
            
            let frame = (original as? BackingTextView)?.model.layerFrame?.awakeFrom(bounds: bounds)
            let text = BackingTextView(frame: frame ?? textBound)
            text.model = (original as? BackingTextView)?.model ?? TextLayerModel()
            newlayer = text
        }
        addSubviewable(newlayer)
        offsetLayer()
    }
    
    func getThumbnailSrc(name:String){
        
        guard let image = makeImageFromView() else {return }
        let url = URL(fileURLWithPath: name, relativeTo: FileManager.previewthumbDir).addExtension(.png)
        let data = image.jpegData(compressionQuality: 0.5)
        do{
            try data?.write(to: url)
            print("The url is: \(url)")
            
        }catch  let err {
            print(":Error Occurred: \(err.localizedDescription)")
        }
        
        
    }
    
}
