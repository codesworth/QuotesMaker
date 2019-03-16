//
//  LayerStack.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 16/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

protocol StackTableDelegate:class {
    
    func didSelectView(with uid:UUID)
    func didDismiss()
}


class LayerStack: MaterialView {
    
    lazy var stackTable:UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.allowsMultipleSelection = false
        table.backgroundColor = .white
        table.register(UINib(nibName: "\(StackCellTableViewCell.self)", bundle: nil), forCellReuseIdentifier: "\(StackCellTableViewCell.self)")
        return table
    }()
    
    lazy var headerLable:BasicLabel = {
        let lab = BasicLabel(frame: .zero, font: .systemFont(ofSize: 18, weight: .medium))
        lab.textColor = .primary
        lab.text = "View Items"
        return lab
    }()
    
    lazy var doneButt:CloseButton = {
        let butt = CloseButton(type: .roundedRect)
        butt.addTarget(self, action: #selector(donePressed), for: .touchUpInside)
        
        return butt
    }()
    
    @objc func donePressed(){
        delegate?.didDismiss()
    }
    var dataSource:Alias.StackDataSource = []

    init(frame: CGRect, dataSource:Alias.StackDataSource) {
        super.init(frame: frame)
        self.dataSource = dataSource
        initialize()
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
        addSubview(headerLable)
        addSubview(doneButt)
        stackTable.delegate = self
        stackTable.dataSource = self
        subscribeTo(subscription: .layerChanged, selector: #selector(layerChanged(_:)))
    }

    @objc func layerChanged(_ notification:Notification){
        print(notification)
        if let data = notification.userInfo?[.info] as? Alias.StackDataSource{
            dataSource = data
        }
        stackTable.reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        //let tabCons = stackTable.pinAllSides()
        NSLayoutConstraint.activate([
            headerLable.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            headerLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            doneButt.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            doneButt.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            doneButt.widthAnchor.constraint(equalToConstant: 30),
            doneButt.heightAnchor.constraint(equalToConstant: 30),
            stackTable.topAnchor.constraint(equalTo: headerLable.bottomAnchor, constant:16),
            stackTable.leftAnchor.constraint(equalTo: leftAnchor),
            stackTable.rightAnchor.constraint(equalTo: rightAnchor),
            stackTable.bottomAnchor.constraint(equalTo:bottomAnchor, constant:-4)
        ])
    }
    
    

}




extension LayerStack:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataSource.isEmpty{
            let empty = UITextField(frame: tableView.frame)
            empty.text = "No Views Added"
            empty.textAlignment = .center
            empty.font = UIFont.systemFont(ofSize: 20, weight: .medium)
            empty.textColor = .primary
            tableView.backgroundView = empty
        }
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
        delegate?.didSelectView(with: view.uid)
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
