//
//  PanelExtensions.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 14/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


//extension StudioVC:StateControlDelegate{
//
//
//    func stateChanged(_ type: StateChangeControl.ChangeType) {
//
//        if let current = baseView.currentSubview as? StateChangeable{
//            if type == .undo {current.stateUndo()}
//            else{current.stateRedo()}
//        }
//    }
//
//    @objc func listenForStateChanged(_ notification:Notification){
//        guard let state = notification.userInfo?[.info] as? State else {return}
//        changes.push(state)
//        print(changes)
//    }
//
//}






extension StudioVC:EditorPanelDelegate{
    
    func moveToProcess(_ process:Processes){
        
        switch process.subProcess {
        case .selectImage:
            imageOptionSelected()
            break
        case .addShadpe:
            shapeSelected()
            break
        case .addText:
            addText()
            break
        case .addFilter:
            //baseView.transformViewTolayer()
            break
        case .preview:
            //launchPreview()
            break
        case .save:
            coordinator.save()
            break
        case .startOver:
            //baseView.invalidateLayers()
            break
        }
    }
    
    func actionFromPanel(_ process: Processes) {
        moveToProcess(process)
    }
    
//    func launchPreview(){
//        let preview = QPreviewView(frame: UIScreen.main.bounds)
//        preview.center = view.center
//        let image = baseView.makeImageFromView()
//        preview.setImage(image)
//        view.addSubview(preview)
//    }
}


extension StudioVC:ImagePanelDelegate{
    
    
    func initCropmode(){
        if let current = coordinator.baseView.currentSubview as? BackingImageView{
            //current.beginCropping()
            guard let image = current.image else {return}
            guard let cropper = PhotoTweaksViewController(image: image) else {return}
            cropper.delegate = self
            cropper.autoSaveToLibray = false
            cropper.maxRotationAngle = CGFloat(Double.pi / 4)
            present(cropper, animated: true, completion: nil)
        }
    }
    
}

extension StudioVC:PhotoTweaksViewControllerDelegate{
    func photoTweaksControllerDidCancel(_ controller: PhotoTweaksViewController!) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    func photoTweaksController(_ controller: PhotoTweaksViewController!, didFinishWithCroppedImage croppedImage: UIImage!) {
        controller.dismiss(animated: true, completion: nil)
        guard let current = coordinator.baseView.currentSubview as? BackingImageView else {return}
        current.setImage(image: croppedImage)
    }
}



extension StudioVC:BaseViewProtocol{
    
    func wakePanelForCurrent() {
        
    }
    
    
//    func wakePanelForCurrent() {
//        guard let current = baseView.currentSubview else{return}
//        if let wrapper = current as?RectView{
//            if wrapper.isGradient{
//                setupGradientInteractiveView()
//            }else{
//                setupColorPanel()
//            }
//        }else if let _ = current as? BackingImageView{
//            setupImageInteractiveView()
//        }
//    }
    
}


extension StudioVC:StudioTabDelegate{
    
    func actiondone(_ action: StudioTab.TabActions) {
        switch action {
        case .delete:
            if let current = coordinator.baseView.currentSubview{
                current.removeFromSuperview()
                coordinator.baseView.currentSubview = nil
                dismissPanels()
            }
            break
        case .layers:
            makeStackTable()
//            baseView.enterResizeMode()
            break
        case .moveUp:
            coordinator.moveSubiewForward()
            break
        case .moveDown:
            coordinator.moveSubiewBackward()
            break
        case .stylePanel:
            //wakePanelForCurrent()
            setupStyleInteractivePanel()
            break
        case .fill:
            setupColorPanel()
        case .gradient:
            setupGradientInteractiveView()
        case .imgPanel:
            setupImageInteractiveView()
            break
        case .undo:
            undoState()
            break
        case .redo:
            break
        default:
            break
        }
    }
    
    func undoState(){
        guard let state = changes.pop() else {return}
        switch state.model.type {
        case .shape:
           shapeUndo(state)
            break
        default:
            break
        }
    }
    
    func shapeUndo(_ state:State){
//        guard let model = state.model as? ShapeModel else{return}
//        guard let view = (baseView.subviews as? [BaseView.BaseSubView])?.first(where: { (v) -> Bool in
//            return v.getIndex == model.layerIndex
//        }) else {
//
//            return
//        }
//        if let shapeView = view as? RectView{
//            shapeView.model = model
//
//        }
    }
    
    @discardableResult // ("For Testing")
    func makeStackTable()->LayerStack?{
        guard stack == nil else {return nil}
        let datasource = coordinator.layerDatasource
        stack = LayerStack(frame: CGRect(origin: .zero, size: coordinator.baseView.bounds.size.scaledBy(0.9)), dataSource: datasource)
        stack?.center = coordinator.baseView.center
        stack?.alpha = 0
        self.view.addSubview(stack!)
        Utils.fadeIn(stack!)
        stack?.delegate = self
        return stack
        
    }
    
    
}

extension StudioVC:StackTableDelegate{
    
    func didDismiss() {
        Utils.fadeOut(stack!) {
            self.stack = nil
        }
    }
    
    
    func didSelectView(with uid: UUID) {
        let view = coordinator.layerDatasource.first{$0.uid == uid}
        print(view ?? "No view Found. Casting error || Use LLDB `po assert(type(of:baseView.subviews) == Alias.StackDataSource.self)`")
        if let sub = view as? RectView {
            coordinator.baseView.currentSubview = sub
            
        }else if let sub = view as? BackingImageView{
            coordinator.baseView.currentSubview = sub
        }else if let sub = view as? BackingTextView{
            coordinator.baseView.currentSubview = sub
        }
    }
    
    
}

