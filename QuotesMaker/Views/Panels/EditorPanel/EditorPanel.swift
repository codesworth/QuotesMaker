//
//  EditorPanel.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 03/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

protocol EditorPanelDelegate:class {
    
    func actionFromPanel(_ process:Processes)
}

class EditorPanel: UIView {
    
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.alwaysBounceHorizontal = true
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        return view
    }()
    
    var processes:[Processes] = Processes.getAllProcesses()
    weak var delegate:EditorPanelDelegate?
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    func commonInit(){
        addSubview(collectionView)
        collectionView.register(UINib(nibName: "\(PanelCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(PanelCell.self)")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width:CGFloat = CGFloat(processes.count  * 100) + 100
        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
//            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            collectionView.heightAnchor.constraint(equalToConstant: 80)
//        ])
        collectionView.layout{
            $0.bottom == bottomAnchor - 10
            $0.centerX == centerXAnchor
            $0.height |=| 80
            $0.width |=| width
        }
    }
}



extension EditorPanel:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return processes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(PanelCell.self)", for: indexPath) as? PanelCell{
            let process = processes[indexPath.row]
            cell.configureView(process)
            return cell
        }
        
        return PanelCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return [100,80]
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let process = processes[indexPath.row]
        delegate?.actionFromPanel(process)
    }
}
