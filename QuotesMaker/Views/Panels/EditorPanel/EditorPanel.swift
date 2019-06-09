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
    
    private let screenHeight = UIScreen.main.bounds.height
    
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.alwaysBounceHorizontal = true
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var handle:UIImageView = {[unowned self] by in
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFit
        view.image = #imageLiteral(resourceName: "handle")
        view.isUserInteractionEnabled = true
        return view
    }(())
    
    
    @objc func didPan(_ recognizer:UIPanGestureRecognizer){
        guard let view = recognizer.view else {return}
        
        let translation = recognizer.translation(in: view)
        let finalPoint = view.frame.origin + translation
        frame.origin.y = max(finalPoint.y, 150)
        
        if recognizer.state == .ended{
            if  frame.origin.y < screenHeight - 100{
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.2, options: .curveEaseOut, animations: {
                    self.frame.origin.y = self.screenHeight - 150
                    self.handle.rotate(CGFloat.pi)
                }, completion: nil)
            }else {
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.2, options: .curveEaseOut, animations: {
                    self.frame.origin.y = self.screenHeight - 60
                    self.handle.rotate(0)
                }, completion: nil)
            }
        }
        recognizer.setTranslation(.zero, in: view)
    }
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
        clipsToBounds = true
        let pan = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        addGestureRecognizer(pan)
        addSubview(collectionView)
        addSubview(handle)
        collectionView.register(UINib(nibName: "\(PanelCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(PanelCell.self)")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //let width:CGFloat = CGFloat(processes.count  * 100) + 100
        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
//            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            collectionView.heightAnchor.constraint(equalToConstant: 80)
//        ])
        collectionView.layout{
            $0.leading == leadingAnchor + 12
            $0.top == topAnchor + 30
            $0.height |=| 80
            $0.trailing == trailingAnchor
        }
        handle.layout{
            $0.centerX == centerXAnchor
            $0.top == topAnchor
            $0.height |=| 20
            $0.width |=| 60
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


extension CGFloat{
    
    func maXInView()->CGFloat{
        let height = UIScreen.main.bounds.height * 0.8
        return (self > height) ? height : self
    }
    
    func minInview()->CGFloat{
        let height = UIScreen.main.bounds.height * 0.2
        return (self > height) ? height : self
    }
}
