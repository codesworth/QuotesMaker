//
//  BackingImageView.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 08/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class BackingImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    var previousModels:[ImageLayerModel] = []
    var redoModels:[ImageLayerModel] = []
    
    var model:ImageLayerModel!{
        didSet{
            image = model.image
        }
    }
    var currentAngle:CGFloat = 0
    
    lazy var croppingRect:UIView = {
        let v = UIView(frame: bounds)
        v.backgroundColor = .white
        v.borderlize(.white,4)
        return v
    }()
    
    var uid:UUID = UUID()
    
    func setImage(image:UIImage){
        previousModels.push(model)
        var new = model
        new!.image = image
        model = new!
        Subscription.main.post(suscription: .canUndo, object: true)
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Notifications.Name.canUndo.rawValue), object: nil)
    }
    
    var id:String{
        return "Image \(id_tag)"
    }
    
    var id_tag: Int = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    func initialize(){
        backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        model = ImageLayerModel()
        contentMode = .scaleAspectFill
        isUserInteractionEnabled = true
        setResizableGesture()
        setPanGesture()
        movedInFocus()
        clipsToBounds = true
    }
    
    

}


extension BackingImageView:StateChangeable{
    
    func stateRedo() {
        guard !redoModels.isEmpty else {
            Subscription.main.post(suscription: .canRedo, object: false)
            return
        }
        let model = redoModels.pop()
        self.model = model
    }
    
    func stateUndo() {
        guard !previousModels.isEmpty else {
            Subscription.main.post(suscription: .canUndo, object: false)
            return
        }
        let model = previousModels.pop()
        self.model = model
        redoModels.append(model)
        Subscription.main.post(suscription: .canRedo, object: true)
        
    }
}

extension BackingImageView:BaseviewSubViewable{}

extension BackingImageView{
    
    enum FlipSides {
        case vertical,horizontal
    }
    
    func flip(_ side:FlipSides){
        guard let image =  image else {return}
        if side == .horizontal{
           let newImage = image.withHorizontallyFlippedOrientation()
            self.image = newImage
        }else{
            guard let newImage = flipImageVertically(image: image)else {return}
            self.image = newImage
        }
        
    }
    
    func rotateImage(){
        guard let image = image else {return}
//         currentAngle = currentAngle < 361 ? currentAngle + 90 : 0
//        transform = transform.rotated(by: .Angle(90))
        
        if let newImage = rotate(image){
            //image.rotate(radians: Float(CGFloat.Angle(90))){
            self.image = newImage
        }
        
    }
    
    private func flipImageVertically(image:UIImage)->UIImage?{
       
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: -image.size.width / 2, y: -image.size.height / 2)
        context.scaleBy(x: image.scale, y: image.scale)
        
        context.translateBy(x: -image.size.width / 2, y: -image.size.height / 2)
        context.draw(image.cgImage!, in: CGRect(origin: .zero, size: image.size))
    
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    private func rotate(_ image:UIImage) -> UIImage?{
        
        var rotatedSize = CGRect(origin: .zero, size: image.size).applying(CGAffineTransform(rotationAngle: .Angle(90))).size
        rotatedSize.width = floor(rotatedSize.width)
        rotatedSize.height = floor(rotatedSize.height)
        UIGraphicsBeginImageContextWithOptions(rotatedSize, false, image.scale)
        guard let context = UIGraphicsGetCurrentContext() else {return nil}
        let origin = CGPoint(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
        context.translateBy(x: origin.x, y: origin.y)
        context.rotate(by: .Angle(90))
        image.draw(in: [-image.size.width / 2, -image.size.height / 2,image.size.width,image.size.height])
        let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return rotatedImage
        
        
    }
}


extension UIImage {
    func rotate(radians: Float) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        
        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: CGFloat(radians))
        // Draw the image at its center
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
