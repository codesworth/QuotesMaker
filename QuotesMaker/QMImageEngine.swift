//
//  QMImageEngine.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 24/02/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import CoreImage
import UIKit

class ImageEngine{
    
    private var baseCIImage:CIImage?
    private var currentImage:UIImage?
    
    init(image:UIImage) {
        baseCIImage = image.ciImage
        currentImage = image
    }
    
    func getCurrentOutputImage()->UIImage?{
        guard let image = baseCIImage else { return nil}
        return UIImage(ciImage: image)
    }
    
    func addFilter(_ filter:Filters){
        switch filter {
        case .bloom:
            addBloom()
            break
        }
    }
    
    func addBloom(){
        guard let base = baseCIImage else {return}
        let filter = CIFilter(name: "CIBloom", parameters: [kCIInputRadiusKey: 8, kCIInputIntensityKey: 1.25,kCIInputImageKey:base])
        baseCIImage = filter?.outputImage
        
    }
    
}



extension ImageEngine{
    
    enum Filters {
        case bloom
    }
}
