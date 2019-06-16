//
//  UnlockProView.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 16/06/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


class UnlockProView: UIView {
    
    lazy var overlay:UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).withAlphaComponent(0.6)
        return view
    }()
    
    lazy var presentationView:MaterialView = {
        let view = MaterialView(frame: .zero)
        view.backgroundColor = .white
        return view
        
    }()
    
    lazy var imageView: UIImageView = {
        let imgv = UIImageView(frame: .zero)
        imgv.contentMode = .scaleAspectFit
        imgv.clipsToBounds = true
        imgv.image = #imageLiteral(resourceName: "ig_square")
        return imgv
    }()
    
    lazy var titleLable: BasicLabel = {
        let label = BasicLabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .primary
        label.textAlignment = .center
        return label
    }()
    
    lazy var detailLable: BasicLabel = {
        let label = BasicLabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .darkText
        label.textAlignment = .center
        return label
    }()
    
    lazy var purchaseButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = #colorLiteral(red: 0.2407481968, green: 0.4886906147, blue: 0.9981510043, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = #colorLiteral(red: 0.2407481968, green: 0.4886906147, blue: 0.9981510043, alpha: 1).withAlphaComponent(0.5)
        button.setTitleColor(.white, for: .normal)

        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func initialize(){
        self.frame = UIScreen.main.bounds
        backgroundColor = .clear
        addSubview(overlay)
        addSubview(presentationView)
        presentationView.addSubview(imageView)
        presentationView.addSubview(titleLable)
        presentationView.addSubview(detailLable)
        presentationView.addSubview(purchaseButton)
        presentationView.addSubview(cancelButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setConstraints(){
        overlay.layout{
            $0.top == topAnchor
            $0.bottom == bottomAnchor
            $0.leading == leadingAnchor
            $0.trailing == trailingAnchor
        }
        
        presentationView.layout{
            $0.leading == leadingAnchor
            $0.trailing == trailingAnchor
            $0.bottom == bottomAnchor
            $0.height |=| 400
        }
        imageView.layout{
            $0.centerX == presentationView.centerXAnchor
            $0.top == presentationView.topAnchor + 20
            $0.width |=| 120
            $0.height |=| 120
        }
        titleLable.layout{
            $0.centerX == presentationView.centerXAnchor
            $0.top == imageView.bottomAnchor + 20
            
        }
        detailLable.layout{
            $0.centerX == presentationView.centerXAnchor
            $0.top == titleLable.bottomAnchor + 20
        }
        
        cancelButton.layout{
            $0.leading == presentationView.leadingAnchor + 20
            $0.trailing == presentationView.trailingAnchor - 20
            $0.bottom == presentationView.bottomAnchor
            $0.height |=| 40
        }
        
        purchaseButton.layout{
            $0.leading == presentationView.leadingAnchor + 20
            $0.trailing == presentationView.trailingAnchor - 20
            $0.bottom == cancelButton.topAnchor - 20
            $0.height |=| 40
        }
    }
}
