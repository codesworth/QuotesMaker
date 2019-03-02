//
//  QMBaseVC.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 28/02/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class QMBaseVC: UIViewController {
    
    @IBOutlet weak var colorPanel: ColorSliderPanel!
    @IBOutlet weak var baseView:BaseView!
    private var  optionsView:OptionsStack!
    private var aspectRatio:Dimensions.AspectRatios = .square
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setTouchRegisters()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    func setupViews(){
        
        baseView.translatesAutoresizingMaskIntoConstraints = false
        let size = Dimensions.sizeForAspect(.square)
        NSLayoutConstraint.activate([
            baseView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            baseView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            baseView.widthAnchor.constraint(equalToConstant: size.width),
            baseView.heightAnchor.constraint(equalToConstant: size.height)
        ])
        setupOverlayOptions()
        
    }
    
    func setupOverlayOptions(){
        let size = Dimensions.sizeForAspect(aspectRatio)
        optionsView = OptionsStack(frame:[0,0,size.width,size.height])
        optionsView.delegate = self
        baseView.addSubview(optionsView)
    }
    
    @objc func imageOptionSelected(){
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    func blankImageSelected(){
        let blank = BlankImageBackingLayer()
        blank.bounds.size = baseView.bounds.size
        baseView.addLayer(blank)
    }
    
    func setTouchRegisters(){
//        baseView.isUserInteractionEnabled = true
//        let tap = UITapGestureRecognizer(target: self, action: #selector(baseViewTapped(_:)))
//        tap.numberOfTapsRequired = 1
//        baseView.addGestureRecognizer(tap)
    }

}


extension QMBaseVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            let layer = ImageBackingLayer()
            layer.addImage(image)
            baseView.addLayer(layer)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}


extension QMBaseVC:OptionsSelectedDelegate{
    
    func didPressButton(_ id: Int) {
        optionsView.removeFromSuperview()
        if id == 1{
            imageOptionSelected()
        }else{
           blankImageSelected()
        }
    }
}
