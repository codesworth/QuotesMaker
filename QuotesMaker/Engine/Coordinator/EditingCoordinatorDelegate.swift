//
//  EditingCoordinatorDelegate.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 05/04/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import Foundation

protocol EditingCoordinatorDelegate:class {
    
    func beginCroppingImage()
    func launchImagePicker()
}

extension EditingCoordinator:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.removeFrom()
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage, let imageView = baseView.currentSubview as? BackingImageView{
            //baseView.invalidateLayers()
            imageView.setImage(image: image)
        }
        picker.removeFrom()
        
    }
    
}


extension EditingCoordinator:TextModelDelegate{
    
    func didUpdateModel(_ model: TextLayerModel) {
        var model = model
        guard let current = baseView.currentSubview as? BackingTextView else {return}
        model.string = current.textView.text
        undostates.append(State(model: current.model, action: .nothing))
        current.model = model
    }
}

