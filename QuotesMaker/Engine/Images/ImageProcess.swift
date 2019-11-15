//
//  ImageEngine.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 06/10/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import ImageIO



public class ImageProcess{
    
    
    static let main = ImageProcess()
    
    private let scaleMultiplier:CGFloat = 3
    
    func resizeImage(_ image:UIImage, for size:CGSize)->UIImage{
        if let data = image.pngData(){
            return downSampleImage(data: data, size: size) ?? image
        }
        return image
    }
    
    private func downSampleImage(data:Data, size:CGSize)->UIImage?{
        let option = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let source = CGImageSourceCreateWithData(data as CFData, option) else {return nil}
        let scale = UIScreen.main.scale * 2
        let maxDimensPix = max(size.width, size.height) * scale
        let downOpts = [kCGImageSourceCreateThumbnailFromImageAlways: true,
                        kCGImageSourceShouldCacheImmediately: true, kCGImageSourceCreateThumbnailWithTransform: true,
                        kCGImageSourceThumbnailMaxPixelSize: maxDimensPix] as CFDictionary
        
        let cgImage = CGImageSourceCreateThumbnailAtIndex(source, 0, downOpts)
        return (cgImage != nil) ?  UIImage(cgImage: cgImage!) : nil
    }
}
