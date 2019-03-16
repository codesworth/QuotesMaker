//
//  LayerStack.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 16/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

protocol StackTableDelegate:class {
    
    func didSelectView(with tag:Int)
}


class LayerStack: UIView {
    
    lazy var stackTable:UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.allowsMultipleSelection = false
        table.backgroundColor = .lightGray
        table.register(UINib(nibName: "\(StackCellTableViewCell.self)", bundle: nil), forCellReuseIdentifier: "\(StackCellTableViewCell.self)")
        return table
    }()
    
    var dataSource:Alias.StackDataSource = []

    init(frame: CGRect, dataSource:Alias.StackDataSource) {
        super.init(frame: frame)
        self.dataSource = dataSource
    }
    
    weak var delegate:StackTableDelegate?
    
    
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: "\(StackCellTableViewCell.self)", for: indexPath) as? StackCellTableViewCell{
            let view = dataSource[indexPath.row]
           cell.configure(id: view.id)
            return cell
        }
        
        return StackCellTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let view = dataSource[indexPath.row]
        delegate?.didSelectView(with: view.id_tag)
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
