//
//  EditingCoordinator.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 05/04/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit
import Photos


class EditingCoordinator:NSObject{
    
    weak var controller:UIViewController?
    var undostates:States = States()
    
    var redostates = States()
    
    var baseView:BaseView
    private var canvas:Canvas!
    weak var delegate:EditingCoordinatorDelegate?
    var existingModel:StudioModel?
    
    func constructFromModel(){
        if let model = existingModel{
            baseView.constructFrom(model: model)
            Subscription.main.post(suscription: .layerChanged, object: baseView.currentSubview)
        }
    }
    
    override init(){
        fatalError("Cannot instantiate object: Call Designated init(model:StudioModel?, canvas:Canvas)")
    }
    
    init(model:StudioModel? = nil, canvas:Canvas){
        baseView = BaseView(frame: .zero)
        self.canvas = canvas
        let size = canvas.size
        baseView.frame = CGRect(origin: .zero, size: size)
        existingModel = model
        super.init()
        constructFromModel()
        subscribeTo(subscription: .stateChange, selector: #selector(listenForStateChange(_ :)))
        
    }
    
    
    var  layerDatasource:Alias.StackDataSource{
        guard let layers = baseView.subviews as? Alias.StackDataSource else {return []}
        return layers
    }
    
    //@stateChangeable
    func imageOptionSelected(){
        
        let imageView = BackingImageView(frame: baseView.subBounds)
        baseView.addSubviewable(imageView)
        imageView.model.layerFrame = imageView.makeLayerFrame()
        let state = State(model: imageView.model, action: .add)
        undostates.append(state)
    }
    
    //@stateChangeable
    func deleteCurrent(){
        if let current = baseView.currentSubview{
            //print("is uniquely referenced: \(isKnownUniquelyReferenced)")
            current.removeFromSuperview()
            if let image = current as? BackingImageView{
                image.releaseImage()
            }
            baseView.currentSubview = nil
            let state = State(model: current.layerModel, action: .delete)
            undostates.append(state)
        }
    }
    
    
    func getCurrentModel()->LayerModel?{
        return baseView.currentSubview?.layerModel
    }
   
    //@stateChangeable
    func shapeSelected(){
        let shape = RectView(frame: baseView.subBounds)
        baseView.addSubviewable(shape)
        shape.model.layerFrame = shape.makeLayerFrame()
        let state = State(model: shape.model, action: .add)
        undostates.append(state)
    }
    
    //@stateChangeable
    func addText(){
        let textField = BackingTextView(frame: baseView.textBound)
        
        baseView.addSubviewable(textField)
        textField.model.layerFrame = textField.makeLayerFrame()
        if UIDevice.idiom == .phone{
            textField.addDoneButtonOnKeyboard()
        }
        let state = State(model: textField.model, action: .add)
        undostates.append(state)
    }
    
    func moveSubiewForward(){
        baseView.moveSubiewForward()
    }
    
    func moveSubiewBackward(){
        baseView.moveSubiewBackward()
    }
    
    //@stateChangeable
    
    func textChanged(text:String){
        guard let current = baseView.currentSubview as? BackingTextView else {return}
        undostates.append(State(model: current.model, action: .nothing))
        current.model.string = text
    }
    
    func save(message:String = "Enter project name"){
        //TODO: Verify pais user or throw alert to buy app
        if !Store.isPro(){
            if Store.main.hasProduct{
                let proAdd = UnlockProView(frame: .zero)
                proAdd.setDetail(string:"Upgrade to Studio Pro to enable saving your projects")
                proAdd.product = Store.main.studioProProduct
                DispatchQueue.main.async {
                    UIApplication.shared.keyWindow?.addSubview(proAdd)
                }
            }else{
                Store.main.requestProProduct { (success, products) in
                    guard let products = products else {return}
                    if !products.isEmpty && success{
                        let product = products.first!
                        let proAdd = UnlockProView(frame: .zero)
                        proAdd.setDetail(string:"Upgrade to Studio Pro to enable saving your projects")
                        proAdd.product = product
                        proAdd.show()
                    }
                }
            }
            
           return
        }
        //TODO: Verify name does not exist before saving
        if existingModel == nil{
            let alert = UIAlertController(title:"Save Project", message:message, preferredStyle: .alert)
            alert.addTextField(configurationHandler: nil)
            alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (ac) in
                let text = alert.textFields?.first!.text
                self.persistModel(title: text ?? "untitled")
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
            controller?.present(alert, animated: true, completion: nil)
        }else{
            let mods = baseView.generatebaseModels()
            baseView.getThumbnailSrc(name:existingModel!.name)
            existingModel?.update(models: mods, bg: baseView.backgroundColor)
            Persistence.main.save(model: existingModel!)
        }
        

    }
    
    func startOver(){
        baseView.invalidateLayers()
    }
    
    func persistModel(title:String){
        if title == ""{
            save(message: "Enter a valid name for project")
            return
        }
        if Persistence.main.fileExists(name: title, with: .json, in: .savedModels){
            save(message: "Project already exists with name \(title), choose a new project name")
        }else{
            let mods = baseView.generatebaseModels()
            baseView.getThumbnailSrc(name:title)
            existingModel = StudioModel(models: mods,name:title,type: canvas.aspectRatio)
            existingModel?.backgroundColor?.color = baseView.backgroundColor ?? .white
            Persistence.main.save(model: existingModel!)
        }
    
        
        
    }
    
    func exportImage()->UIImage?{
        return baseView.makeImageFromView(scale: canvas.scale)
    }
    

}


extension EditingCoordinator:StylingDelegate{
    
    //@stateChangeable
    func didFinishStyling(_ style: Style) {
        if let current = baseView.currentSubview as? RectView{
            var model = current.model
            model.style = style
            current.updateModel(model)
            let state = State(model: model, action: .nothing)
            undostates.append(state)
        }else if let current = baseView.currentSubview as? BackingImageView{
            var model = current.model
            model.style = style
            current.updateModel(model)
            let state = State(model: model, action: .nothing)
            undostates.append(state)
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
    
    
    //@stateChangeable
    func colorDidChange(_ model: BlankLayerModel) {
        guard let current = baseView.currentSubview as? ShapableView else {return}
        var mod = current.model
        mod.isGradient = false
        mod.solid = model
        current.updateModel(mod)
        let state = State(model: mod, action: .nothing)
        undostates.append(state)
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
    
    //@stateChangeable
    func modelChanged(_ model: GradientLayerModel) {
        guard var current = baseView.currentSubview as? ShapableView else {return}
        var mod = current.model
        mod.gradient = model
        mod.isGradient = true
        current.model = mod
        let state = State(model: mod, action: .nothing)
        undostates.append(state)
    }
    
    func previewingModel(_ model: GradientLayerModel) {
        guard let current = baseView.currentSubview as? ShapableView else {return}
        var mod = current.model
        mod.gradient = model
        mod.isGradient = true
        current.updateModel(mod)
    }
    
}


extension EditingCoordinator:ImagePanelDelegate{
    
    //@stateChangeable
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
        case .filter:
            filter()
            break
        case .aspect(let mode):
            changeAspect(mode)
            break
        }
    }
    
    func changeAspect(_ mode:ImageLayerModel.ContentMode){
        if let current = baseView.currentSubview as? BackingImageView{
            current.changeAspect(mode)
        }
    }
    
    private func filter(){
        if let controller = controller as? iPadStudioVC, let image = (baseView.currentSubview as? BackingImageView)?.image{
            //let size = (baseView.currentSubview as! BackingImageView).bounds.size
            controller.launchImageFilter(image:image)
        }else if let controller = controller as? StudioVC, let image = (baseView.currentSubview as? BackingImageView)?.image{
            controller.launchImageFilter(image:image)
        }
    }
    
    func flipImage(_ side:BackingImageView.FlipSides){
        if let current = baseView.currentSubview as? BackingImageView{
            current.flip(side)
        }
    }
}


extension EditingCoordinator: ImageFilterDelegate{
    func apply(_ filter: String) {
        if let current = baseView.currentSubview as? BackingImageView{
            current.addFilter(filter: filter)
        }
    }
    
    func donePressed() {
        if let current = baseView.currentSubview as? BackingImageView{
            current.confirmFilter()
        }
    }
    
    
}

extension EditingCoordinator:FetchedAssetDelegate{
    //@stateChangeable
    func didPickImage(image:UIImage){
        if let base = baseView.currentSubview as? BackingImageView{
            base.setImage(image: image)
        }
    }


}


extension EditingCoordinator:StackTableDelegate{
    func didDismiss() {
        (controller as? StudioVC)?.toggleStack()
    }
    
    
    
    func didSelectView(with uid: UUID) {
        let view = layerDatasource.first{$0.uid == uid}
        print(view ?? "No view Found. Casting error || Use LLDB `po assert(type(of:baseView.subviews) == Alias.StackDataSource.self)`")
        if let sub = view as? RectView {
            baseView.selectedView = sub
            
        }else if let sub = view as? BackingImageView{
            baseView.selectedView = sub
        }else if let sub = view as? BackingTextView{
            baseView.selectedView = sub
        }
    }
    
    
}


extension EditingCoordinator:PhotoTweaksViewControllerDelegate{
    func photoTweaksControllerDidCancel(_ controller: PhotoTweaksViewController!) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    func photoTweaksController(_ controller: PhotoTweaksViewController!, didFinishWithCroppedImage croppedImage: UIImage!) {
        controller.dismiss(animated: true, completion: nil)
        guard let current = baseView.currentSubview as? BackingImageView else {return}
        current.setImage(image: croppedImage)
    }
}

