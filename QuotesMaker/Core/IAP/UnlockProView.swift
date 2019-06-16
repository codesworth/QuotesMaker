//
//  UnlockProView.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 16/06/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit
import StoreKit


class UnlockProView: UIView {
    
    var product:SKProduct?{
        didSet{
            guard let prod = product else {return}
            titleLable.text = prod.localizedTitle
            let text = "Unlock \(priceFormatter.string(from: prod.price) ?? "$0.00")"
            purchaseButton.setTitle(text, for: .normal)
            purchaseButton.addTarget(self, action: #selector(purchase(_:)), for: .touchUpInside)
        }
    }
    
    lazy var overlay:UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.darkText.withAlphaComponent(0.6)
        return view
    }()
    
    lazy var presentationView:MaterialView = {
        let view = MaterialView(frame: .zero)
        view.backgroundColor = .white
        return view
        
    }()
    
    func setDetail(string:String){
        detailLable.text = string
    }
    
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
        button.backgroundColor = #colorLiteral(red: 0.3565862775, green: 0.8337638974, blue: 0.8115196824, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.roundCorners(5.0)
        return button
    }()
    
    lazy var cancelButton: UIButton = { [unowned self] by in
        let button = UIButton(frame: .zero)
        button.backgroundColor = .white
        button.borderlize(#colorLiteral(red: 0.3565862775, green: 0.8337638974, blue: 0.8115196824, alpha: 1), 1)
        button.setTitleColor(#colorLiteral(red: 0.3565862775, green: 0.8337638974, blue: 0.8115196824, alpha: 1), for: .normal)
        button.setTitle("Cancel", for: .normal)
        button.addTarget(self, action: #selector(cancel(_:)), for: .touchUpInside)
        button.roundCorners(5.0)
        return button
    }(())
    
    @objc func purchase(_ sender:UIButton){
        guard let product = product else {return}
        Store.main.buyProduct(product: product)
        cancel(sender)
    }
    
    
    @objc func cancel(_ sender:UIButton){
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.2, options: .curveEaseOut, animations: {
            self.frame.origin.y += UIScreen.main.bounds.height
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
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
        initialize()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
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
            $0.height |=| 450
        }
        imageView.layout{
            $0.centerX == presentationView.centerXAnchor
            $0.top == presentationView.topAnchor + 20
            $0.width |=| 100
            $0.height |=| 100
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
            $0.bottom == presentationView.bottomAnchor - 20
            $0.height |=| 45
        }
        
        purchaseButton.layout{
            $0.leading == presentationView.leadingAnchor + 20
            $0.trailing == presentationView.trailingAnchor - 20
            $0.bottom == cancelButton.topAnchor - 20
            $0.height |=| 45
        }
    }
    
     let priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.formatterBehavior = .behavior10_4
        formatter.numberStyle = .currency
        return formatter
    }()
}
