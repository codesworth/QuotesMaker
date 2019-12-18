//
//  iPadStudioVC.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 03/04/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class iPadStudioVC: UIViewController {
    
   
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    
    init(model:StudioModel? = nil, canvas:Canvas) {
        self.canvas = canvas
        self.coordinator = EditingCoordinator(model: model, canvas: canvas)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    var canvas:Canvas!
    let coordinator:EditingCoordinator!
    lazy var taskbarContainer:UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    lazy var controlPanelContainer:UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .groupTableViewBackground
        return view
    }()
    lazy var panelController:StackPanelVC = {
        let controller = UIStoryboard.init(name: "iPadMain", bundle: nil).instantiateViewController(withIdentifier: "\(StackPanelVC.self)") as! StackPanelVC
        return controller
    }()
    let taskbar = StudioTaskBarController.onlyInstance()
    
    
    var layerStack:LayerStack = LayerStack(frame:.zero, dataSource: [])
    
    
    lazy var editor:StudioEditorView = {
        let editor = StudioEditorView(frame: .zero)
        editor.clipsToBounds = true
        return editor
    }()
    
    var studioHeight:CGFloat = 130
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondaryDark
        view.addSubview(editor)
        self.view.addSubview(controlPanelContainer)
        view.addSubview(taskbarContainer)
        view.addSubview(layerStack)
        layerStack.delegate = coordinator
        add(panelController, to: controlPanelContainer)
        add(taskbar, to: taskbarContainer)
        iPadLayout()
        coordinator.controller = self
        let mods  = Persistence.main.fetchAllModels()
        print("Models are: \(mods)")
        coordinator.delegate = self
        editor.addCanvas(coordinator.baseView)
        subscribeTo(subscription: .moreFonts, selector: #selector(launchMoreFonts(_:)))
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coordinator.unsubscribe()
    }
    
    
    @objc func launchMoreFonts(_ notifcation:Notification){
        if let fonts = UIStoryboard.storyboard.instantiateViewController(withIdentifier: "\(MoreFontsVC.self)") as? MoreFontsVC {
            fonts.delegate = coordinator
            fonts.model = coordinator.getCurrentModel() as? TextLayerModel ?? TextLayerModel()
            add(fonts, to: controlPanelContainer)
            fonts.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate(fonts.view.pinAllSides())
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension iPadStudioVC:EditingCoordinatorDelegate{
    
    func launchImagePicker() {
        let picker = UIImagePickerController()
        picker.delegate = coordinator
        //let nav = PickerNavController(rootViewController: picker)
        add(picker, to: controlPanelContainer)
        picker.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(picker.view.pinAllSides())
    }
    
    func launchImageFilter(image:UIImage){
        let vc = ImageFilterVC(image: image, size: canvas.size)
        vc.delegate = coordinator
        add(vc, to: controlPanelContainer)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(vc.view.pinAllSides())
    }
    
    func beginCroppingImage() {
        if let current = coordinator.baseView.currentSubview as? BackingImageView{
//           let view = UIView(frame: [0,0,500,500])
//            self.view.addSubview(view)
//            view.backgroundColor = .magenta
//            view.center = self.view.center
//            view.clipsToBounds = true
            guard let image = current.image else {
                //view.removeFromSuperview()
                return
            }
            guard let cropper = PhotoTweaksViewController(image: image) else {return}
            cropper.delegate = coordinator
            cropper.autoSaveToLibray = false
            cropper.maxRotationAngle = CGFloat(Double.pi / 4)
            //add(cropper,to: view)
            cropper.modalPresentationStyle = .fullScreen
            present(cropper, animated: true, completion: nil)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        iPadLayout()
    }
    

}
