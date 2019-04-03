//
//  iPadStudioVC.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 03/04/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class iPadStudioVC: UIViewController {
    
    lazy var studioPanel: EditorPanel = {
        let panel = EditorPanel(frame: .zero)
        panel.backgroundColor = .seafoamBlue
        return panel
    }()
    lazy var controlPanelContainer:UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .groupTableViewBackground
        return view
    }()
    lazy var panelController:ControlPanelTable = {
        let controller = ControlPanelTable(current: nil)
        return controller
    }()
    
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
        view.backgroundColor = .white
        view.addSubview(editor)
        self.view.addSubview(controlPanelContainer)
        view.addSubview(studioPanel)
        view.addSubview(layerStack)
        
        iPadLayout()
        add(panelController, to: controlPanelContainer)
        // Do any additional setup after loading the view.
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
