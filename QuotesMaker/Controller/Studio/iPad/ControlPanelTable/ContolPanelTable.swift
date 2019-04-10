//
//  ContolPanelTable.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 03/04/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


class ControlPanelTable:CollapsibleTableSectionViewController{
    
    enum SourcePanels:String,CaseIterable{
       case img = "Image"
        case fill = "Fill"
        case gradient = "Gradient"
//        case text = "Text"
        case layout = "Style"
        
    }
    
    var currentView:BaseView.BaseSubView?{
        didSet{
            updatepanels()
        }
    }
    
    init(){
        super.init(nibName: nil, bundle: .main)
        self.delegate = self
        updatepanels()
        subscribeTo(subscription: .activatedLayer, selector: #selector(currentChanged(_:)))
        
    }
    
    var studio:iPadStudioVC?{
        return parent as? iPadStudioVC
    }
    
    @objc func currentChanged(_ notification:Notification){
        if let view = notification.userInfo?[.info] as? BaseView.BaseSubView{
            currentView = view
        }
        _tableView.reloadData()
    }
    
    
    
    func updatepanels(){
        if let _ = currentView as? RectView{
            panels = SourcePanels.allCases.filter{$0 != .img}
        }else if let _ = currentView as? BackingImageView{
            panels = [.img,.layout]
        }else if let _ = currentView as? BackingTextView{
            panels = []
        }else{
            panels = [.layout]
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var panels:[SourcePanels] = SourcePanels.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .groupTableViewBackground
    }
    
}


extension ControlPanelTable:CollapsibleTableSectionDelegate{
    
    func numberOfSections(_ tableView: UITableView) -> Int {
        return panels.count
    }
    
    func collapsibleTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func collapsibleTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = panels[indexPath.section]
        let cell = PanelContainerCell(panel: getPanel(type: type))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type = panels[indexPath.section]
        switch type {
        case .fill:
            return 170
        case .gradient:
            return 560
        case .img:
            return 200
        case .layout:
            return 670
//        case .text:
//            return 600
        default:
            return 400
        }
    }
    
    func collapsibleTableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let type = panels[section]
        switch type {
        case .fill:
            return "Fill Color"
        case .gradient:
            return "Gradient"
        case .img:
            return "Image Options"
//        case .text:
//            return "Text"
        case .layout:
            return "Styling"
        }
    }
    
    
}

extension ControlPanelTable{
    
    func setupGradientInteractiveView()->GradientPanel{
        let gradientPanel = GradientPanel(frame:.zero) //[0,0,standardWidth,560])
        gradientPanel.delegate = studio?.coordinator
        return gradientPanel
    
        //addSubview(gradientPanel)
//        subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
//        NSLayoutConstraint.activate(gradientPanel.pinAllSides())
    }
    
    func setupFillInteractiveView()->ColorSliderPanel{
        let panel = ColorSliderPanel(frame:.zero)
        panel.delegate =  studio?.coordinator
        return panel
        //addSubview(panel)
        
        //subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        //NSLayoutConstraint.activate(panel.pinAllSides())
    }
    
    func setupImageInteractiveView()->ImagePanel{
        let panel = ImagePanel(frame: .zero)//[0,0,standardWidth,400])
        panel.delegate =  studio?.coordinator
        return panel
        //addSubview(panel)
        //subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        //NSLayoutConstraint.activate(panel.pinAllSides())
    }
    
//    func setupTextInteractiveView()->{
//        let panel = TextDesignableInputView(frame:.zero,model: TextLayerModel()) //[0,0,standardWidth,600], model: TextLayerModel())
//        //panel.delegate =  studio?.coordinator
//        //addSubview(panel)
//        //subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
//        //NSLayoutConstraint.activate(panel.pinAllSides())
//    }
    
    func setupStyleInteractiveView()->StylingPanel{
        let panel = StylingPanel(frame:.zero) //[0,0,standardWidth,600])
        panel.header.isHidden = true
        panel.delegate =  studio?.coordinator
        return panel
        //addSubview(panel)
        //subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        //NSLayoutConstraint.activate(panel.pinAllSides())
    }
    
    func getPanel(type:SourcePanels)->UIView{
            switch type {
            case .fill:
                return setupFillInteractiveView()
            case .gradient:
                return setupGradientInteractiveView()
               
            case .img:
                return setupImageInteractiveView()
            case .layout:
                return setupStyleInteractiveView()
                
            }
        }
}
