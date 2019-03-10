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
    private var textField = BackingTextView(frame: .zero)
    //private var  optionsView:OptionsStack?
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
        colorPanel = ColorSliderPanel(frame: [points.x,points.y,Dimensions.panelWidth,200])
        gradientPanel = GradientPanel(frame: [points.x,points.y - 150, Dimensions.panelWidth,250])
        
        let size = Dimensions.sizeForAspect(.square)
        NSLayoutConstraint.activate([
            baseView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            baseView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            baseView.widthAnchor.constraint(equalToConstant: size.width),
            baseView.heightAnchor.constraint(equalToConstant: size.height)
        ])
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
       
        if colorPanel.isInView{Utils.animatePanelsOut(colorPanel)}
         if gradientPanel.isInView{return}
        
        gradientPanel.delegate = self
        view.addSubview(gradientPanel)
        Utils.animatePanelsIn(gradientPanel)
        gradientPanel.isInView = true
        
    }
    
    @objc func imageOptionSelected(){
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
        
    }
    
    func blankImageSelected(){
    
        if let current = baseView.subLayers?.first(where: {type(of: $0) == BlankImageBackingLayer.self}) {
            baseView.currentSublayer = current
        }else{
            let blank = BlankImageBackingLayer()
            blank.bounds.size = baseView.bounds.size
            baseView.addLayer(blank)
        }

        setupColorPanel()

    }
    
    func blankGradientSelected(){
        if let current = baseView.subLayers?.first(where: {type(of: $0) == BackingGradientlayer.self}) {
            baseView.currentSublayer = current
        }else{
            let blank = BackingGradientlayer()
            blank.bounds.size = baseView.bounds.size
            baseView.addLayer(blank)
        }
        
        setupGradientInteractiveView()
    }
    
    func setTextLayer(){
        textField.delegate = self
        textField.addDoneButtonOnKeyboard()
        let size = baseView.bounds.size.scaledBy(0.5)
        //let height = textField.text!.height(withConstrainedWidth: size.width, font: textField.font!)
        textField.frame.size = size
        textField.center = [baseView.bounds.midX,baseView.bounds.midY]
        baseView.addSubview(textField)
        NotificationCenter.default.addObserver(self, selector: #selector(resetHeight), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    @objc func resetHeight(){
//       let size = baseView.bounds.size.scaledBy(0.5)
//
//        let height = textField.text!.height(withConstrainedWidth: size.width, font: textField.font!)
//        textField.frame.size = [size.width,height]
//        textField.center = [baseView.bounds.midX,baseView.bounds.midY]
        var size = textField.frame.size
        let cheight = textField.text!.height(withConstrainedWidth: size.width, font: textField.font!)
        if cheight > size.height {
            size.height = cheight
            if cheight > baseView.bounds.height * 0.8 {
                size.width = baseView.bounds.width * 0.8
                size.height = textField.text!.height(withConstrainedWidth: size.width, font: textField.font!)
            }
            DispatchQueue.main.async {
                self.textField.frame.size = size
                self.textField.center = [self.baseView.bounds.midX,self.baseView.bounds.midY]
            }
        }
    }

}




extension QMBaseVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            baseView.invalidateLayers()
            let imageLayer = BackingImageView(frame: baseView.bounds)
            imageLayer.image = image
            baseView.addSubview(imageLayer)
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
        
//        optionsView?.removeFromSuperview()
//        optionsView = nil
    }
}



extension QMBaseVC:PickerColorDelegate{
    
    func setupColorPanel(){
        if gradientPanel.isInView{Utils.animatePanelsOut(gradientPanel)}
        if colorPanel.isInView{return}
        colorPanel.delegate = self
        view.addSubview(colorPanel)
        Utils.animatePanelsIn(colorPanel)
        colorPanel.isInView = true
    }
    
    func colorDidChange(_ color: UIColor) {
        baseView.currentSublayer?.backgroundColor  = color.cgColor
    }
    
    func donePressed() {
        Utils.animatePanelsOut(colorPanel)
    }
}


extension QMBaseVC:GradientOptionsDelegate{
    
    func modelChanged(_ model: GradientLayerModel) {
        if let gLayer = baseView.currentSublayer as? BackingGradientlayer{
            gLayer.model = model
        }
    }
    
    func donePressed(_ model: GradientLayerModel) {
        Utils.animatePanelsOut(gradientPanel)
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
            setTextLayer()
            break
        case .addFilter:
            baseView.transformViewTolayer()
            break
        }
    }
    
    func actionFromPanel(_ process: Processes) {
        moveToProcess(process)
    }
}




extension QMBaseVC:UITextViewDelegate{
    
    
    func textViewDidChange(_ textView: UITextView) {
        print("SO this is the text that changed: \(String(describing: textView.text))")
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
         print("SO this is the text that changed: \(String(describing: textView.text))")
    }
    
    
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        return true
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        print("This is the text: \(textField.text ?? "")")
//    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        self.textField.textlayer.setText(string)
//        return true
//    }
}
