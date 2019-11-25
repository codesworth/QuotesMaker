//
//  QMBaseVC.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 28/02/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit



class StudioVC: UIViewController {
    
    
    lazy var editorView:StudioEditorView = {
        let editor = StudioEditorView(frame:[0])//CGRect(origin: [0,100], size: Dimensions.editorSize))
        editor.clipsToBounds = true
        return editor
    }()
    var canvas:Canvas!
    var tabTopConstraint:NSLayoutConstraint!
    var coordinator:EditingCoordinator!
    var studioHeight: CGFloat!
    var studioPanel: EditorPanel!
    var colorPanel:ColorSliderPanel!
    var gradientPanel:GradientPanel!
    var studioTab:StudioTab!
    var imagePanel:ImagePanel!
    var stylingPanel:StylingPanel!
    var stackShowing = false
    var imageLayerExists = false
    var tabsShowing = false
    
    
    var stack:LayerStack?
    
    
    
    init(model:StudioModel? = nil, canvas:Canvas) {
        self.canvas = canvas
        self.coordinator = EditingCoordinator(model: model, canvas: canvas)
        super.init(nibName: nil, bundle: nil)
        
    }
    
    
    func setupCanvas(){
        
        editorView.addCanvas(coordinator.baseView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let value = UIInterfaceOrientation.landscapeLeft.rawValue
        //UIDevice.current.setValue(value, forKey: "orientation")
        //setupDevice()
        view.backgroundColor = .primaryDark
        studioTab = StudioTab(frame: .zero)
        studioPanel = EditorPanel(frame: .zero)
        //studioTab.isHidden = true
        studioTab.delegate = self
        
        view.addSubview(editorView)
        view.addSubview(studioPanel)
        view.addSubview(studioTab)
        studioPanel.delegate = self
        coordinator.delegate = self
        coordinator.controller = self
        //subscribeTo(subscription: .stateChange, selector: #selector(listenForStateChanged(_:)))
        let attr = NSAttributedString(string: "Quote Maker", attributes: [.font:UIFont(name: "RobotoMono-Regular", size: 45)!,.foregroundColor:UIColor.white])
        navigationController?.title = attr.string
        setupViews()
        makeStackTable()
        //print("Orientations: \(UIDevice.current.orientation.rawValue)")
        subscribeTo(subscription: .moreFonts, selector: #selector(launchMoreFonts(_:)))

    }
    
    func launchImageFilter(image:UIImage){
        let imageVc = ImageFilterVC(image: image, size: canvas.size)
        imageVc.delegate = coordinator
        present(imageVc, animated: true, completion: nil)
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    
    @objc func launchMoreFonts(_ notifcation:Notification){
        if let nav = UIStoryboard.storyboard.instantiateViewController(withIdentifier: "MoreFontsVCNav") as? UINavigationController, let fonts = nav.viewControllers.first as? MoreFontsVC{
            fonts.delegate = coordinator
            fonts.model = coordinator.getCurrentModel() as? TextLayerModel ?? TextLayerModel()
            present(nav, animated: true, completion: nil)
        }
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
        self.layout()
        setupCanvas()
        
        
    }
    

    
    func setupGradientInteractiveView(){
        if imagePanel.isInView{Utils.animatePanelsOut(imagePanel)}
        if colorPanel.isInView{Utils.animatePanelsOut(colorPanel)}
        if gradientPanel.isInView{return}
        
        gradientPanel.delegate = coordinator
        view.addSubview(gradientPanel)
        Utils.animatePanelsIn(gradientPanel)
        gradientPanel.isInView = true
//        if let current = coordinator.baseView.currentSubview as? ShapableView{
//            current.layerChanged(true)
//        }
        
    }
    
    func setupImageInteractiveView(){
        
        if colorPanel.isInView{Utils.animatePanelsOut(colorPanel)}
        if gradientPanel.isInView{Utils.animatePanelsOut(gradientPanel)}
        if imagePanel.isInView{return}
        
        imagePanel.delegate = coordinator
        view.addSubview(imagePanel)
        Utils.animatePanelsIn(imagePanel)
        imagePanel.isInView = true
        
        
    }
    
    func setupColorPanel(){
        if imagePanel.isInView{Utils.animatePanelsOut(imagePanel)}
        if gradientPanel.isInView{Utils.animatePanelsOut(gradientPanel)}
        if stylingPanel.isInView{Utils.animatePanelsOut(stylingPanel)}
        if colorPanel.isInView{return}
        colorPanel.delegate = coordinator
        view.addSubview(colorPanel)
        Utils.animatePanelsIn(colorPanel)
        colorPanel.isInView = true
        //if let current = coordinator.baseView.currentSubview as? ShapableView{
         //   current.layerChanged(false)
        //}
    }
    
    func setupStyleInteractivePanel(){
        if colorPanel.isInView{Utils.animatePanelsOut(colorPanel)}
        if gradientPanel.isInView{Utils.animatePanelsOut(gradientPanel)}
        if imagePanel.isInView{Utils.animatePanelsOut(gradientPanel)}
        if let current = coordinator.baseView.currentSubview as? BackingTextView {
            current.textView.becomeFirstResponder()
            current.designInputView?.model = coordinator.getCurrentModel() as? TextLayerModel ?? TextLayerModel()
            return
        }
        
        stylingPanel.delegate = coordinator
        view.addSubview(stylingPanel)
        Utils.animatePanelsIn(stylingPanel)
        stylingPanel.isInView = true
        
    }
    
    
    func showTabs(){
        if tabsShowing{return}
        tabsShowing = true
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseIn], animations: {
            [unowned self] in
            self.tabTopConstraint.constant = 30
            //self.studioTab.isHidden = false
        })
    }
    
    func hideTabs(){
        if !tabsShowing{return}
        tabsShowing = false
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseIn], animations: { [unowned self] in
            self.tabTopConstraint.constant = -30
            //self.studioTab.isHidden = true
        })
    }
    
    func imageOptionSelected(){
        
        //coordinator.imageOptionSelected()
        //setupImageInteractiveView()
        imageLayerExists = false
        launchPicker()
        
        
    }
    
    func launchPicker(){
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
        
    }
    
    func shapeSelected(){
        showTabs()
        coordinator.shapeSelected()
        setupColorPanel()

    }
    
    
    func addText(){
        showTabs()
        coordinator.addText()
        
    }
    

    
    func dismissPanels(){
        if imagePanel.isInView{
            Utils.animatePanelsOut(imagePanel)
            
        }
        if gradientPanel.isInView{Utils.animatePanelsOut(gradientPanel)}
        if colorPanel.isInView{Utils.animatePanelsOut(colorPanel)}
    }

}





extension StudioVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        imagePanel.isInView = true
       
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if !imageLayerExists {
            showTabs()
            coordinator.imageOptionSelected()
            setupImageInteractiveView()
        }
        
        if let image = info[.originalImage] as? UIImage, let imageView = coordinator.baseView.currentSubview as? BackingImageView{
            let resizedImage = image.downSampleImage(size: imageView.bounds.size)
            print("The initial size was: \(image.byteSize) whiles resized image  size is: \(resizedImage!.byteSize)")
            //baseView.invalidateLayers()
            imageView.setImage(image: resizedImage != nil ? resizedImage! : image)
        }
        
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
            break
        default:
            break
        }
        
    }
    
   
}



