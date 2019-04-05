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
    
    let constraintIds = NSLayoutConstraint.makeIdentifiers()
    var visible:Bool = false
    
    typealias SwapIndice = (initial:Int,final:Int)
    lazy var stackTable:UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.allowsMultipleSelection = false
        table.backgroundColor = .clear
        table.isEditing = true
        table.allowsSelectionDuringEditing = true
        table.register(UINib(nibName: "\(StackCell.self)", bundle: nil), forCellReuseIdentifier: "\(StackCell.self)")
        return table
    }()
    
    
    
    lazy var headerLable:BasicLabel = {
        let lab = BasicLabel(frame: .zero, font: .systemFont(ofSize: 18, weight: .medium))
        lab.textColor = .primary
        lab.text = "Layers"
        return lab
    }()
    
    lazy var doneButt:CloseButton = {
        let butt = CloseButton(type: .roundedRect)
        butt.addTarget(self, action: #selector(donePressed), for: .touchUpInside)
        
        return butt
    }()
    
    @objc func donePressed(){
        if UIDevice.idiom == .phone{
            delegate?.didDismiss()
        }else{
            guard let superview = superview else {return}
            //superview.constraints.forEach{print($0.identifier ?? "No ID")}
            let constraint = superview.constraints.first{$0.identifier == constraintIds.leading}
            guard constraint != nil else {return}
            UIView.animate(withDuration: 4, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.2, options: .curveEaseOut, animations: {
                constraint?.constant = -Dimensions.iPadContext.layerStackWidth
            }, completion: nil)
        }
    }
    
    func toggle(){
        if visible{
            guard let superview = superview else {return}
            //superview.constraints.forEach{print($0.identifier ?? "No ID")}
            let constraint = superview.constraints.first{$0.identifier == constraintIds.leading}
            guard constraint != nil else {return}
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.2, options: .curveEaseOut, animations: {
                constraint?.constant = -Dimensions.iPadContext.layerStackWidth
            }, completion: {_ in self.visible = false})
        }else {
            guard let superview = superview else {return}
            //superview.constraints.forEach{print($0.identifier ?? "No ID")}
            let constraint = superview.constraints.first{$0.identifier == constraintIds.leading}
            guard constraint != nil else {return}
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.2, options: .curveEaseOut, animations: {
                constraint?.constant = 0
            }, completion: {_ in self.visible = true})
        }
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
        if UIDevice.idiom == .pad{visible = true}
        
    }

    @objc func layerChanged(_ notification:Notification){
        
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
            headerLable.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            headerLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
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
    
    
    deinit {
        unsubscribe()
    }
}




extension LayerStack:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if dataSource.isEmpty{
//            let empty = UILabel(frame: tableView.frame)
//            empty.text = "No Views Added"
//            empty.textAlignment = .center
//            empty.font = UIFont.systemFont(ofSize: 20, weight: .medium)
//            empty.textColor = .primary
//            tableView.backgroundView = empty
//            
//        }
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "\(StackCell.self)", for: indexPath) as? StackCell{
            let view = dataSource[indexPath.row]
           cell.configure(id: view.id)
            return cell
        }
        
        return StackCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let view = dataSource[indexPath.row]
        delegate?.didSelectView(with: view.uid)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        moveFrom(sourceIndexPath.row, to: destinationIndexPath.row)
        tableView.reloadData()
        let swap:SwapIndice = (sourceIndexPath.row,destinationIndexPath.row)
        Subscription.main.post(suscription: .layerReArranged, object:swap)
    }
    
    func moveFrom(_ c_index:Int, to index:Int){
        dataSource.swapAt(c_index, index)
    }
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
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
