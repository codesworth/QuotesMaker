//
//  LayerStack.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 16/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class LayerStack: UIView {
    
    lazy var stackTable:UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.allowsMultipleSelection = false
        table.backgroundColor = .lightGray
        return table
    }()
    
    var dataSource:[UIView] = []

    init(frame: CGRect, dataSource:[UIView]) {
        super.init(frame: frame)
        self.dataSource = dataSource
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initialize(){
        backgroundColor = .white
        addSubview(stackTable)
        stackTable.delegate = self
        stackTable.dataSource = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        let tabCons = stackTable.pinAllSides()
        NSLayoutConstraint.activate(tabCons)
    }

}


extension LayerStack:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}


extension UIView{
    
    func pinAllSides()->[NSLayoutConstraint]{
        guard let superview = superview else {fatalError("Pinning must be done in a superview")}
        return [
            topAnchor.constraint(equalTo: superview.topAnchor),
            leftAnchor.constraint(equalTo: superview.leftAnchor),
            rightAnchor.constraint(equalTo: superview.rightAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ]
    }
}
