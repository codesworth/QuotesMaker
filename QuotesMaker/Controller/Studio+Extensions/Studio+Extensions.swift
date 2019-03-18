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
        if let current = baseView.currentSubview as? WrapperView{
            current.updateModel(model)
        }
    }
    
}


extension StudioVC:StudioPanelDelegate{
    
    func moveToProcess(_ process:Processes){
        
        switch process.subProcess {
        case .selectImage:
            imageOptionSelected()
            break
        case .addBlankOverlay:
            blankImageSelected()
            break
        case .addGradientOverlay:
            blankGradientSelected()
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
            current.beginCropping()
        }
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
                dismissPanels()
            }
            break
        case .layers:
            makeStackTable()
            break
        case .moveUp:
            baseView.moveSubiewForward()
            break
        case .moveDown:
            baseView.moveSubiewBackward()
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

