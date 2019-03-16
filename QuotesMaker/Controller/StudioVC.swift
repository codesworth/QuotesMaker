//
//  QMBaseVC.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 28/02/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class StudioVC: UIViewController {
    
    @IBOutlet weak var studioHeight: NSLayoutConstraint!
    @IBOutlet weak var studioPanel: StudioPanel!
    private var colorPanel:ColorSliderPanel!
    private var gradientPanel:GradientPanel!
    private var studioTab:StudioTab!
    private var imagePanel:ImagePanel!
    @IBOutlet weak var baseView:BaseView!
    var stack:LayerStack?
    //private var textField = BackingTextView(frame: .zero)
    private var aspectRatio:Dimensions.AspectRatios = .square
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        studioTab = StudioTab(frame: .zero)
        studioTab.delegate = self
        view.addSubview(studioTab)
        studioPanel.delegate = self
        baseView.delegate = self
        //automaticallyAdjustsScrollViewInsets = false
        let attr = NSAttributedString(string: "Quote Maker", attributes: [.font:UIFont.font(.painter),.foregroundColor:UIColor.white])
        navigationController?.title = attr.string

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
        studioTab.translatesAutoresizingMaskIntoConstraints = false
        let points = Dimensions.originalPanelPoints
        colorPanel = ColorSliderPanel(frame: [points.x,points.y,Dimensions.panelWidth,Dimensions.colorPanelHeight])
        colorPanel.stateDelegate = self
        gradientPanel = GradientPanel(frame: [points.x,points.y - 150, Dimensions.panelWidth,Dimensions.gradientPanelHeight])
        gradientPanel.stateDelegate = self
        imagePanel = ImagePanel(frame: [points.x,points.y,Dimensions.panelWidth,Dimensions.imagePanelHeight])
        imagePanel.stateDelegate = self
        let size = Dimensions.sizeForAspect(.square)
        NSLayoutConstraint.activate([
            baseView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            baseView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            baseView.widthAnchor.constraint(equalToConstant: size.width),
            baseView.heightAnchor.constraint(equalToConstant: size.height),
            studioTab.topAnchor.constraint(equalTo: baseView.bottomAnchor, constant: 16),
            studioTab.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            studioTab.widthAnchor.constraint(equalToConstant: size.width),
            studioTab.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        let handle = UIScreen.main.screenType()
        switch handle {
        case .xmax_xr:
            studioHeight.constant = 130
            return
        case .xs_x:
            studioHeight.constant = 130
            return
        case .pluses:
            studioHeight.constant = 120
            return    
        default:
            studioHeight.constant = 100
            return
        }
//        if optionsView == nil{
//            setupOverlayOptions()
//        }
        
    }
    
//    func setupOverlayOptions(){
//        let size = Dimensions.sizeForAspect(aspectRatio)
//        optionsView = OptionsStack(frame:[0,0,size.width,size.height])
//        optionsView!.delegate = self
//        baseView.addSubview(optionsView!)
//    }
    
    func setupGradientInteractiveView(){
        if imagePanel.isInView{Utils.animatePanelsOut(imagePanel)}
        if colorPanel.isInView{Utils.animatePanelsOut(colorPanel)}
         if gradientPanel.isInView{return}
        
        gradientPanel.delegate = self
        view.addSubview(gradientPanel)
        Utils.animatePanelsIn(gradientPanel)
        gradientPanel.isInView = true
        
    }
    
    func setupImageInteractiveView(){
        
        if colorPanel.isInView{Utils.animatePanelsOut(colorPanel)}
        if gradientPanel.isInView{Utils.animatePanelsOut(gradientPanel)}
        if imagePanel.isInView{return}
        imagePanel.delegate = self
        view.addSubview(imagePanel)
        Utils.animatePanelsIn(imagePanel)
        imagePanel.isInView = true
        
    }
    
    func imageOptionSelected(){
        let imageView = BackingImageView(frame: baseView.bounds)
        baseView.addSubview(imageView)
        setupImageInteractiveView()
    }
    
    func launchPicker(){
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    func blankImageSelected(){
    
//        if let current = baseView.subLayers?.first(where: {type(of: $0) == BlankImageBackingLayer.self}) {
//            baseView.currentSublayer = current
//        }else{
//            let blank = BlankImageBackingLayer()
//            blank.bounds.size = baseView.bounds.size
//            baseView.addLayer(blank)
//        }
        let blank = WrapperView(frame: baseView.bounds, layer: BlankImageBackingLayer())
        baseView.addSubview(blank)
        setupColorPanel()

    }
    
    func blankGradientSelected(){
//        if let current = baseView.subLayers?.first(where: {type(of: $0) == BackingGradientlayer.self}) {
//            baseView.currentSublayer = current
//        }else{
//            let blank = BackingGradientlayer()
//            blank.bounds.size = baseView.bounds.size
//            baseView.addLayer(blank)
//        }
        let grad = WrapperView(frame: baseView.bounds, layer: BackingGradientlayer())
        grad.isGradient = true
        baseView.addSubview(grad)
        setupGradientInteractiveView()
    }
    
    func addText(){
        let textField = BackingTextView(frame: [0,0,baseView.bounds.width * 0.7,40])
        baseView.addSubview(textField)
        textField.center = baseView.center
//        textField.delegate = self
        textField.addDoneButtonOnKeyboard()
//        let size = baseView.bounds.size.scaledBy(0.5)
//        //let height = textField.text!.height(withConstrainedWidth: size.width, font: textField.font!)
//        textField.frame.size = size
//        textField.center = [baseView.bounds.midX,baseView.bounds.midY]
//        baseView.addSubview(textField)
        //NotificationCenter.default.addObserver(self, selector: #selector(resetHeight), name: UITextView.textDidChangeNotification, object: nil)
    }
    
//    @objc func resetHeight(){
////       let size = baseView.bounds.size.scaledBy(0.5)
////
////        let height = textField.text!.height(withConstrainedWidth: size.width, font: textField.font!)
////        textField.frame.size = [size.width,height]
////        textField.center = [baseView.bounds.midX,baseView.bounds.midY]
//        var size = textField.frame.size
//        let cheight = textField.text!.height(withConstrainedWidth: size.width, font: textField.font!)
//        if cheight > size.height {
//            size.height = cheight
//            if cheight > baseView.bounds.height * 0.8 {
//                size.width = baseView.bounds.width * 0.8
//                size.height = textField.text!.height(withConstrainedWidth: size.width, font: textField.font!)
//            }
//            DispatchQueue.main.async {
//                self.textField.frame.size = size
//                self.textField.center = [self.baseView.bounds.midX,self.baseView.bounds.midY]
//            }
//        }
//    }
    
    func dismissPanels(){
        if imagePanel.isInView{Utils.animatePanelsOut(imagePanel)}
        if gradientPanel.isInView{Utils.animatePanelsOut(gradientPanel)}
        if colorPanel.isInView{Utils.animatePanelsOut(colorPanel)}
    }

}

extension StudioVC:PickerColorDelegate{
    
    func setupColorPanel(){
        if imagePanel.isInView{Utils.animatePanelsOut(imagePanel)}
        if gradientPanel.isInView{Utils.animatePanelsOut(gradientPanel)}
        if colorPanel.isInView{return}
        colorPanel.delegate = self
        view.addSubview(colorPanel)
        Utils.animatePanelsIn(colorPanel)
        colorPanel.isInView = true
    }
    
    func colorDidChange(_ model: BlankLayerModel) {
        guard let current = baseView.currentSubview as? WrapperView else {return}
        current.updateModel(model)
    }
    
}



extension StudioVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage, let imageView = baseView.currentSubview as? BackingImageView{
            //baseView.invalidateLayers()
            imageView.setImage(image: image)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}


extension StudioVC:OptionsSelectedDelegate{
    
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
        
//        optionsView?.removeFromSuperview()
//        optionsView = nil
    }
}
