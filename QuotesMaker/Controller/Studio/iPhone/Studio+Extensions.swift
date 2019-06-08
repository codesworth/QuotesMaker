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
        case .home:
            goHome()
            break
        case .selectImage:
            imageOptionSelected()
            break
        case .addShadpe:
            shapeSelected()
            break
        case .addText:
            addText()
            break
        case .preview:
            //coordinator.
            break
        case .save:
            coordinator.save()
            break
        case .startOver:
            coordinator.startOver()
            break
        }
    }
    
    func goHome(){
        let alert = UIAlertController(title: "Info", message: "Are you sure you want leave studio. All unsaved edits would be lost", preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let action2 = UIAlertAction(title: "Exit Studio", style: .destructive) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        alert.addAction(action2)
        present(alert, animated: true, completion: nil)
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


extension StudioVC:EditingCoordinatorDelegate{
    
    func launchImagePicker() {
        launchPicker()
    }
    
    func beginCroppingImage() {
        initCropmode()
    }
    
    func initCropmode(){
        if let current = coordinator.baseView.currentSubview as? BackingImageView{
            //current.beginCropping()
            guard let image = current.image else {return}
            guard let cropper = PhotoTweaksViewController(image: image) else {return}
            cropper.delegate = coordinator
            cropper.autoSaveToLibray = false
            cropper.maxRotationAngle = CGFloat(Double.pi / 4)
            present(cropper, animated: true, completion: nil)
        }
    }
    
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
            //undoState()
            break
        case .redo:
            break
        }
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
        stack?.delegate = coordinator
        return stack
        
    }
    
    
}


