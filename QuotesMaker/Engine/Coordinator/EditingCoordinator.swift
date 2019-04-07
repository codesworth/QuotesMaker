//
//  EditingCoordinator.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 05/04/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit



class EditingCoordinator:NSObject{
    
    var baseView:BaseView
    weak var delegate:EditingCoordinatorDelegate?
    override init(){
        
        baseView = BaseView(frame: .zero)
        let size = Dimensions.sizeForAspect(.square)
        baseView.frame = CGRect(origin: .zero, size: size)
        super.init()
    }
    
    var  layerDatasource:Alias.StackDataSource{
        guard let layers = baseView.subviews as? Alias.StackDataSource else {return []}
        return layers
    }
    
    func imageOptionSelected(){
        
        let imageView = BackingImageView(frame: baseView.subBounds)
        baseView.addSubviewable(imageView)
        imageView.model.layerFrame = imageView.makeLayerFrame()
        
    }
    
    
    func deleteCurrent(){
        if let current = baseView.currentSubview{
            current.removeFromSuperview()
            baseView.currentSubview = nil
            
        }
    }
   
    
    func shapeSelected(){
        let shape = RectView(frame: baseView.subBounds)
        baseView.addSubviewable(shape)
        shape.model.layerFrame = shape.makeLayerFrame()
       
        
    }
    
    
    func addText(){
        let textField = BackingTextView(frame: baseView.subBounds)
        
        baseView.addSubviewable(textField)
        textField.model.layerFrame = textField.makeLayerFrame()
        //if UIDevice.idiom == .phone{
            textField.addDoneButtonOnKeyboard()
        //}
    }
    
    func moveSubiewForward(){
        baseView.moveSubiewForward()
    }
    
    func moveSubiewBackward(){
        baseView.moveSubiewBackward()
    }
    
    func save(){
        baseView.save()
    }
    
    
}


extension EditingCoordinator:StylingDelegate{
    
    func didFinishStyling(_ style: Style) {
        if let current = baseView.currentSubview as? RectView{
            var model = current.model
            model.style = style
            current.updateModel(model)
        }else if let current = baseView.currentSubview as? BackingImageView{
            var model = current.model
            model.style = style
            current.updateModel(model)
        }
    }
    
    func didFinishPreviewing(_ style: Style) {
        if let current = baseView.currentSubview as? RectView{
            var model = current.model
            model.style = style
            current.model = model
        }else if let current = baseView.currentSubview as? BackingImageView{
            var model = current.model
            model.style = style
            current.model = model
        }
    }
    
}



extension EditingCoordinator:PickerColorDelegate{
    
    
    
    func colorDidChange(_ model: BlankLayerModel) {
        guard let current = baseView.currentSubview as? ShapableView else {return}
        var mod = current.model
        mod.isGradient = false
        mod.solid = model
        current.updateModel(mod)
    }
    
    //To visit during State Changeable
    func previewingWith(_ model: BlankLayerModel) {
        guard var current = baseView.currentSubview as? ShapableView else {return}
        var mod = current.model
        mod.isGradient = false
        mod.solid = model
        current.model = mod
    }
    
}

extension EditingCoordinator:GradientOptionsDelegate{
    
    func modelChanged(_ model: GradientLayerModel) {
        guard let current = baseView.currentSubview as? ShapableView else {return}
        var mod = current.model
        mod.gradient = model
        mod.isGradient = true
        current.updateModel(mod)
    }
    
}


extension EditingCoordinator:ImagePanelDelegate{
    
    func didSelect(_ option: ImagePanel.PanelOptions) {
        
        switch option {
        case .gallery:
            delegate?.launchImagePicker()
            break
        case .online:
            break
        case .rotate:
            guard let current = baseView.currentSubview as? BackingImageView else {break}
            current.rotateImage()
            break
        case .cropMode:
            delegate?.beginCroppingImage()
            break
        case .flipHorizontal:
            flipImage(.horizontal)
            break
        case .flipVertical:
            flipImage(.vertical)
            break
        }
    }
    
    func flipImage(_ side:BackingImageView.FlipSides){
        if let current = baseView.currentSubview as? BackingImageView{
            current.flip(side)
        }
    }
}

extension EditingCoordinator:FetchedAssetDelegate{
    
    func didPickImage(image:UIImage){
        print("Asset acquired: \(asset.description)")
        updateStaticImage(asset: asset)
    }

}



