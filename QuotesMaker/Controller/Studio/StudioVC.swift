//
//  QMBaseVC.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 28/02/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class StudioVC: UIViewController {
    
    typealias StateChanges = ModelCollection<State>
    lazy var editorView:StudioEditorView = {
        let editor = StudioEditorView(frame:[0])//CGRect(origin: [0,100], size: Dimensions.editorSize))
        editor.clipsToBounds = true
        return editor
    }()
    
    var studioHeight: CGFloat!
    var changes:StateChanges = StateChanges()
    var studioPanel: EditorPanel!
    var colorPanel:ColorSliderPanel!
    var gradientPanel:GradientPanel!
    var studioTab:StudioTab!
    var imagePanel:ImagePanel!
    var stylingPanel:StylingPanel!
    
    var baseView:BaseView!
    var stack:LayerStack?
    //private var textField = BackingTextView(frame: .zero)
    private var aspectRatio:Dimensions.AspectRatios = .square
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    
    func setupCanvas(){
        let size = Dimensions.sizeForAspect(.square)
        baseView.frame = CGRect(origin: .zero, size: size)
        editorView.addCanvas(baseView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseView = BaseView(frame: .zero)
        studioTab = StudioTab(frame: .zero)
        studioPanel = EditorPanel(frame: .zero)
        studioPanel.backgroundColor = .seafoamBlue
        view.addSubview(studioPanel)
        studioTab.delegate = self
        view.addSubview(studioTab)
        view.addSubview(editorView)
        studioPanel.delegate = self
        baseView.delegate = self
        subscribeTo(subscription: .stateChange, selector: #selector(listenForStateChanged(_:)))
        let attr = NSAttributedString(string: "Quote Maker", attributes: [.font:UIFont.font(.painter),.foregroundColor:UIColor.white])
        navigationController?.title = attr.string
        setupViews()
        //print("Orientations: \(UIDevice.current.orientation.rawValue)")
        print("This is Height::: \(UIScreen.main.bounds) and scale:: \(UIScreen.main.scale)")
        print("This is native bound::: \(UIScreen.main.nativeBounds) and scale:: \(UIScreen.main.nativeScale)")

    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    func setHeight(){
        let handle = UIScreen.main.screenType()
        switch handle {
        case .xmax_xr:
            studioHeight = 130
            return
        case .xs_x:
            studioHeight = 130
            return
        case .pluses:
            studioHeight = 120
            return
        default:
            studioHeight = 100
            return
        }
    }
    
    func setupViews(){
        setHeight()
        let idiom = UIDevice.current.userInterfaceIdiom
        if idiom == .phone{
            self.layout()
        }else {
            
        }
        setupCanvas()
        
        
    }
    

    
    func setupGradientInteractiveView(){
        if imagePanel.isInView{Utils.animatePanelsOut(imagePanel)}
        if colorPanel.isInView{Utils.animatePanelsOut(colorPanel)}
        if gradientPanel.isInView{return}
        
        gradientPanel.delegate = self
        view.addSubview(gradientPanel)
        Utils.animatePanelsIn(gradientPanel)
        gradientPanel.isInView = true
        if let current = baseView.currentSubview as? ShapableView{
            current.layerChanged(true)
        }
        
    }
    
    func setupImageInteractiveView(){
        
        if colorPanel.isInView{Utils.animatePanelsOut(colorPanel)}
        if gradientPanel.isInView{Utils.animatePanelsOut(gradientPanel)}
        if imagePanel.isInView{return}
        if baseView.currentSubview == nil {return}
        imagePanel.delegate = self
        view.addSubview(imagePanel)
        Utils.animatePanelsIn(imagePanel)
        imagePanel.isInView = true
        
    }
    
    func setupStyleInteractivePanel(){
        if colorPanel.isInView{Utils.animatePanelsOut(colorPanel)}
        if gradientPanel.isInView{Utils.animatePanelsOut(gradientPanel)}
        if imagePanel.isInView{Utils.animatePanelsOut(gradientPanel)}
        if let current = baseView.currentSubview as? BackingTextView {
            current.textView.becomeFirstResponder()
            return
        }
        
        stylingPanel.delegate = self
        view.addSubview(stylingPanel)
        Utils.animatePanelsIn(stylingPanel)
        stylingPanel.isInView = true
        
    }
    
    func imageOptionSelected(){

        let imageView = BackingImageView(frame: baseView.subBounds)
        baseView.addSubviewable(imageView)
        imageView.model.layerFrame = imageView.makeLayerFrame()
        setupImageInteractiveView()
    }
    
    func launchPicker(){
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    func shapeSelected(){
        let shape = RectView(frame: baseView.subBounds)
        baseView.addSubviewable(shape)
        shape.model.layerFrame = shape.makeLayerFrame()
        setupColorPanel()

    }
    
    func blankGradientSelected(){

//        let grad = RectView(frame: baseView.subBounds, layer: BackingGradientlayer())
//        grad.isGradient = true
//        baseView.addSubviewable(grad)
//        setupGradientInteractiveView()
    }
    
    func addText(){
        let textField = BackingTextView(frame: baseView.subBounds)
        
        baseView.addSubviewable(textField)
        textField.model.layerFrame = textField.makeLayerFrame()
        textField.addDoneButtonOnKeyboard()
    }
    

    
    func dismissPanels(){
        if imagePanel.isInView{
            Utils.animatePanelsOut(imagePanel)
            
        }
        if gradientPanel.isInView{Utils.animatePanelsOut(gradientPanel)}
        if colorPanel.isInView{Utils.animatePanelsOut(colorPanel)}
    }

}

extension StudioVC:PickerColorDelegate{
    
    func setupColorPanel(){
        if imagePanel.isInView{Utils.animatePanelsOut(imagePanel)}
        if gradientPanel.isInView{Utils.animatePanelsOut(gradientPanel)}
        if stylingPanel.isInView{Utils.animatePanelsOut(stylingPanel)}
        if colorPanel.isInView{return}
        colorPanel.delegate = self
        view.addSubview(colorPanel)
        Utils.animatePanelsIn(colorPanel)
        colorPanel.isInView = true
        if let current = baseView.currentSubview as? ShapableView{
            current.layerChanged(false)
        }
    }
    
    func colorDidChange(_ model: BlankLayerModel) {
        guard let current = baseView.currentSubview as? ShapableView else {return}
        var mod = current.model
        mod.solid = model
        current.updateModel(mod)
    }
    
    //To visit during State Changeable
    func previewingWith(_ model: BlankLayerModel) {
        guard var current = baseView.currentSubview as? ShapableView else {return}
        var mod = current.model
        mod.solid = model
        current.model = mod
    }
    
}



extension StudioVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        imagePanel.isInView = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage, let imageView = baseView.currentSubview as? BackingImageView{
            //baseView.invalidateLayers()
            imageView.setImage(image: image)
        }
        picker.dismiss(animated: true, completion: nil)
        imagePanel.isInView = true
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
            //ShapeSelected()
            break
        case 4:
            blankGradientSelected()
            break
        default:
            break
        }
        
    }
}


extension StudioVC:StylingDelegate{
    
    func didFinishStyling(_ style: Style) {
        if let current = baseView.currentSubview as? RectView{
            var model = current.model
            model.style = style
            current.updateModel(model)
        }else if let current = baseView.currentSubview as? BackingImageView{
            var model = current.model
            model.style = style
            current.updateModel(model)
        }
    }
    
    func didFinishPreviewing(_ style: Style) {
        if let current = baseView.currentSubview as? RectView{
            var model = current.model
            model.style = style
            current.model = model
        }else if let current = baseView.currentSubview as? BackingImageView{
            var model = current.model
            model.style = style
            current.model = model
        }
    }
    
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
