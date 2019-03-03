//
//  QMBaseVC.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 28/02/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class QMBaseVC: UIViewController {
    
    @IBOutlet weak var studioPanel: StudioPanel!
    private var colorPanel:ColorSliderPanel!
    private var gradientPanel:GradientPanel!
    @IBOutlet weak var baseView:BaseView!
    private var  optionsView:OptionsStack?
    private var aspectRatio:Dimensions.AspectRatios = .square
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        studioPanel.delegate = self
        let attr = NSAttributedString(string: "Quote Maker", attributes: [.font:UIFont.font(.painter),.foregroundColor:UIColor.white])
        navigationController?.title = attr.string
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
        let points = Dimensions.originalPanelPoints
        colorPanel = ColorSliderPanel(frame: [points.x,points.y,Dimensions.panelWidth,150])
        gradientPanel = GradientPanel(frame: [points.x,points.y - 150, Dimensions.panelWidth,300])
        
        let size = Dimensions.sizeForAspect(.square)
        NSLayoutConstraint.activate([
            baseView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            baseView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            baseView.widthAnchor.constraint(equalToConstant: size.width),
            baseView.heightAnchor.constraint(equalToConstant: size.height)
        ])
        if optionsView == nil{
            setupOverlayOptions()
        }
        
    }
    
    func setupOverlayOptions(){
        let size = Dimensions.sizeForAspect(aspectRatio)
        optionsView = OptionsStack(frame:[0,0,size.width,size.height])
        optionsView!.delegate = self
        baseView.addSubview(optionsView!)
    }
    
    func setupGradientInteractiveView(){
       
        if colorPanel.isInView{colorPanel.removeFromSuperview();colorPanel.frame.origin.x = Dimensions.originalPanelPoints.x}
         if gradientPanel.isInView{return}
        //let gIview = GradientPanel(frame: [8,view.frame.height - 310,view.frame.width - 16,200])
        gradientPanel.delegate = self
        view.addSubview(gradientPanel)
        UIView.animate(withDuration: 1) {
            self.gradientPanel.frame.origin.x = 8
        }
        gradientPanel.isInView = true
        
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
        setupColorPanel()
    }
    
    func blankGradientSelected(){
        let blank = BackingGradientlayer()
        blank.bounds.size = baseView.bounds.size
        baseView.addLayer(blank)
        setupGradientInteractiveView()
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

        switch id {
        case 1:
            imageOptionSelected()
            break
        case 2:
            break
        case 3:
            blankImageSelected()
            break
        case 4:
            blankGradientSelected()
            break
        default:
            break
        }
        
        optionsView?.removeFromSuperview()
        optionsView = nil
    }
}



extension QMBaseVC:PickerColorDelegate{
    
    func setupColorPanel(){
        if gradientPanel.isInView{gradientPanel.removeFromSuperview();gradientPanel.frame.origin.x = Dimensions.originalPanelPoints.x}
        if colorPanel.isInView{return}
        colorPanel.delegate = self
        view.addSubview(colorPanel)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.4, options: .curveEaseInOut, animations: {
            self.colorPanel.frame.origin.x = 8
        })
        colorPanel.isInView = true
    }
    
    func colorDidChange(_ color: UIColor) {
        baseView.currentSublayer?.backgroundColor  = color.cgColor
    }
}


extension QMBaseVC:GradientOptionsDelegate{
    
    func modelChanged(_ model: GradientLayerModel) {
        if let gLayer = baseView.currentSublayer as? BackingGradientlayer{
            gLayer.model = model
        }
    }
}


extension QMBaseVC:StudioPanelDelegate{
    
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
            break
        case .addFilter:
            break
        }
    }
    
    func actionFromPanel(_ process: Processes) {
        moveToProcess(process)
    }
}
