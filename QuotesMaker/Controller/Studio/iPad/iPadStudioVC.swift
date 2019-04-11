//
//  iPadStudioVC.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 03/04/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class iPadStudioVC: UIViewController {
    
   
    
//    lazy var studioPanel: EditorPanel = {
//        let panel = EditorPanel(frame: .zero)
//        panel.backgroundColor = .seafoamBlue
//        return panel
//    }()
    let coordinator = EditingCoordinator()
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
    lazy var panelController:ControlPanelTable = {
        let controller = ControlPanelTable()
        return controller
    }()
    let taskbar = StudioTaskBarController.onlyInstance()
    
    lazy var layerStack:LayerStack = { [unowned self] by in
        let stack = LayerStack(frame:.zero, dataSource: [])
        stack.backgroundColor = .groupTableViewBackground
        return stack
    }(())
    
    lazy var editor:StudioEditorView = {
        let editor = StudioEditorView(frame: .zero)
        editor.clipsToBounds = true
        return editor
    }()
    
    var studioHeight:CGFloat = 130
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coordinator.delegate = self
        view.backgroundColor = .white
        view.addSubview(editor)
        self.view.addSubview(controlPanelContainer)
        view.addSubview(taskbarContainer)
        view.addSubview(layerStack)
        add(panelController, to: controlPanelContainer)
        add(taskbar, to: taskbarContainer)
        editor.addCanvas(coordinator.baseView)
        iPadLayout()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
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
        let picker = AssetGridViewController()
        picker.delegate = coordinator
        let nav = PickerNavController(rootViewController: picker)
        add(nav, to: controlPanelContainer)
        nav.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(nav.view.pinAllSides())
    }
    
    func beginCroppingImage() {
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        iPadLayout()
    }
    

}
