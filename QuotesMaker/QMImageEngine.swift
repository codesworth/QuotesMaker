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
        return currentImage
    }
    
    
}
