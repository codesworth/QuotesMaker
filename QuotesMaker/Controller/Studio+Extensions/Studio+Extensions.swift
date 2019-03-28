//
//  PanelExtensions.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 14/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


extension StudioVC:StateControlDelegate{
    
    
    func stateChanged(_ type: StateChangeControl.ChangeType) {
        
        if let current = baseView.currentSubview as? StateChangeable{
            if type == .undo {current.stateUndo()}
            else{current.stateRedo()}
        }
    }
    
    
    
}



extension StudioVC:GradientOptionsDelegate{
    
    func modelChanged(_ model: GradientLayerModel) {
        guard let current = baseView.currentSubview as? ShapableView else {return}
        var mod = current.model
        mod.gradient = model
        current.updateModel(mod)
    }
    
}


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
            launchPreview()
        case .save:
            baseView.save()
            break
        case .startOver:
            baseView.invalidateLayers()
            break
        }
    }
    
    func actionFromPanel(_ process: Processes) {
        moveToProcess(process)
    }
    
    func launchPreview(){
        let preview = QPreviewView(frame: UIScreen.main.bounds)
        preview.center = view.center
        let image = baseView.makeImageFromView()
        preview.setImage(image)
        view.addSubview(preview)
    }
}


extension StudioVC:ImagePanelDelegate{
    
    func didSelect(_ option: ImagePanel.PanelOptions) {
        
        switch option {
        case .gallery:
            launchPicker()
            break
        case .online:
            break
        case .rotate:
            guard let current = baseView.currentSubview as? BackingImageView else {break}
            current.rotateImage()
            break
        case .cropMode:
            initCropmode()
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
    
    func initCropmode(){
        if let current = baseView.currentSubview as? BackingImageView{
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
        guard let current = baseView.currentSubview as? BackingImageView else {return}
        current.setImage(image: croppedImage)
    }
}



extension StudioVC:BaseViewProtocol{
    
    func wakePanelForCurrent() {
        guard let current = baseView.currentSubview else{return}
        if let wrapper = current as? WrapperView{
            if wrapper.isGradient{
                setupGradientInteractiveView()
            }else{
                setupColorPanel()
            }
        }else if let _ = current as? BackingImageView{
            setupImageInteractiveView()
        }
    }
    
}


extension StudioVC:StudioTabDelegate{
    
    func actiondone(_ action: StudioTab.TabActions) {
        switch action {
        case .delete:
            if let current = baseView.currentSubview{
                current.removeFromSuperview()
                baseView.currentSubview = nil
                dismissPanels()
            }
            break
        case .layers:
            makeStackTable()
//            baseView.enterResizeMode()
            break
        case .moveUp:
            baseView.moveSubiewForward()
            break
        case .moveDown:
            baseView.moveSubiewBackward()
            break
        case .stylePanel:
            //wakePanelForCurrent()
            setupStyleInteractivePanel()
            break
        case .fill:
            setupColorPanel()
        case .gradient:
            setupGradientInteractiveView()
        default:
            break
        }
    }
    
    @discardableResult // ("For Testing")
    func makeStackTable()->LayerStack?{
        guard stack == nil else {return nil}
        if let datasource = baseView.subviews as? Alias.StackDataSource{
            stack = LayerStack(frame: CGRect(origin: .zero, size: baseView.bounds.size.scaledBy(0.9)), dataSource: datasource)
            stack?.center = baseView.center
            stack?.alpha = 0
            self.view.addSubview(stack!)
            Utils.fadeIn(stack!)
            stack?.delegate = self
            return stack
        }
        
      return nil
    }
    
    
}

extension StudioVC:StackTableDelegate{
    
    func didDismiss() {
        Utils.fadeOut(stack!) {
            self.stack = nil
        }
    }
    
    
    func didSelectView(with uid: UUID) {
        let view = (baseView.subviews as? Alias.StackDataSource)?.first{$0.uid == uid}
        print(view ?? "No view Found. Casting error || Use LLDB `po assert(type(of:baseView.subviews) == Alias.StackDataSource.self)`")
        if let sub = view as? WrapperView{
            baseView.currentSubview = sub
            
        }else if let sub = view as? BackingImageView{
            baseView.currentSubview = sub
        }else if let sub = view as? BackingTextView{
            baseView.currentSubview = sub
        }
    }
    
    
}

