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
        case text = "Text"
        case layout = "Style"
    }
    
    var currentView:BaseView.BaseSubView?
    
    init(current:BaseView.BaseSubView?){
        currentView = current
        super.init(nibName: nil, bundle: .main)
        updatepanels()
    }
    
    func updatepanels(){
        if let _ = currentView as? RectView{
            panels = SourcePanels.allCases.filter{$0 != .text && $0 != .img}
        }else if let _ = currentView as? BackingImageView{
            panels = SourcePanels.allCases.filter{$0 != .fill && $0 != .gradient}
        }else if let _ = currentView as? BackingTextView{
            panels = [.text]
        }else{
            panels = SourcePanels.allCases
        }
    
        self.delegate = self
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
        let cell = PanelContainerCell(type: type)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type = panels[indexPath.section]
        switch type {
        case .fill:
            return 250
        case .gradient:
            return 560
        case .img:
            return 250
        case .layout:
            return 600
        case .text:
            return 600
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
        case .text:
            return "Text"
        case .layout:
            return "Styling"
        }
    }
    
    
}
