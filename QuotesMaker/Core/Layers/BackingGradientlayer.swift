//
//  BackingFilterOverLay.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 02/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//



import UIKit

class BackingGradientlayer: CAGradientLayer {
    
    override init(layer: Any) {
        super.init()
        setup()
    }
    
//    private var gradientLayer:CAGradientLayer = CAGradientLayer()
//    private var pathLayer =  CAShapeLayer()
    
    var previousModels:[GradientLayerModel] = []
    
    var model:GradientLayerModel!{

        didSet{
            if previousModels.isEmpty{previousModels.push(model)}else{previousModels.push(oldValue)}
            startPoint = model.startPoint
            endPoint = model.endPoint
            locations = model.locations
            colors = model.gradientColors()
        }
    }
    
    override init() {
        super.init()
        setup()
        
    }
    
    init(shape:SuperRectView.shapeTypes){
        super.init()
        setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func previewingmodels(model:GradientLayerModel){
        self.model = model
    }
    
    func setup(){
//        addSublayer(pathLayer)
//        let path = UIBezierPath(ovalIn: [10,10,200,200])
//        pathLayer.path = path.cgPath
//        pathLayer.fillColor = UIColor.magenta.cgColor
//        pathLayer.strokeColor = UIColor.orangeRed.cgColor
//        gradientLayer = CAGradientLayer(layer: pathLayer)
//        pathLayer.insertSublayer(gradientLayer, at: 100)
//        //pathLayer.masksToBounds = true
        model = GradientLayerModel.defualt()
    }
}
