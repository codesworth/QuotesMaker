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
        if option == .gallery{
            launchPicker()
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
    
    @discardableResult
    func makeStackTable()->LayerStack?{
        let baseView = BaseView(frame: [100])
        
        if let datasource = baseView.subviews as? Alias.StackDataSource{
            let stack = LayerStack(frame: baseView.frame, dataSource: datasource)
            stack.alpha = 0
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.view.addSubview(stack)
                stack.alpha = 1
            }, completion: nil)
            stack.delegate = self
            return stack
        }
        
      return nil
    }
    
    
}

extension StudioVC:StackTableDelegate{
    
    func didSelectView(with tag: Int) {
        let view = (baseView.subviews as? Alias.StackDataSource)?.first{$0.id_tag == tag}
        print(view ?? "No view Found. Casting error || Use LLDB `po assert(type(of:baseView.subviews) == Alias.StackDataSource`")
    }
}

