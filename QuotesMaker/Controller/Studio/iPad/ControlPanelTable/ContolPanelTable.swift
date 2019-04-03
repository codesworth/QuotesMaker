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
        case text = "Style"
        case layout = "Text"
    }
    
    var currentView:BaseView.BaseSubView?
    
    init(current:BaseView.BaseSubView?){
        currentView = current
    }
    
    func updatepanels(){
        if let _ = currentView as? RectView{
            panels = SourcePanels.allCases.filter{$0 != .text && $0 != .img}
        }else if let _ = currentView as? BackingImageView{
            panels = SourcePanels.allCases.filter{$0 != .fill && $0 != .gradient}
        }else{
            panels = [.text]
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var panels:[SourcePanels] = SourcePanels.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        <#code#>
    }
    
    
}
