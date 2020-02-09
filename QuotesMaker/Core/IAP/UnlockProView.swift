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
            purchaseButton.isHidden = false
            activityController.isHidden = true
            indicatorLable.isHidden = true
            detailLable.isHidden = false
            restoreButton.isHidden = false
            purchaseButton.addTarget(self, action: #selector(purchase(_:)), for: .touchUpInside)
        }
    }
    
    lazy var restoreButton:UIButton = { [unowned self] by in
        let button = UIButton(frame: .zero)
        button.backgroundColor = #colorLiteral(red: 0.1297397017, green: 0.1362194717, blue: 0.1622923017, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Restore", for: .normal)
        button.roundCorners(5.0)
        button.addTarget(self, action: #selector(restorePurchase(_:)), for: .touchUpInside)
        return button
    }(())
    
    lazy var activityController:UIActivityIndicatorView = {
        let indicator  = UIActivityIndicatorView(frame: .zero)
        indicator.style = .whiteLarge
        indicator.hidesWhenStopped = true
        indicator.tintColor = .seafoamBlue
        //indicator.backgroundColor = .seafoamBlue
        indicator.color = .seafoamBlue
        return indicator
    }()
    
    lazy var indicatorLable:BasicLabel = {
        let label = BasicLabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .darkText
        label.textAlignment = .center
        label.text = "Connecting to iTunes Store"
        return label
    }()
    
    lazy var overlay:UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.darkText.withAlphaComponent(0.6)
        return view
    }()
    
    lazy var presentationView:MaterialView = {
        let view = MaterialView(frame: .zero)
        view.backgroundColor = .secondaryDark
        return view
        
    }()
    
    func setDetail(string:String){
        detailLable.text = string
    }
    
    lazy var imageView: UIImageView = {
        let imgv = UIImageView(frame: .zero)
        imgv.contentMode = .scaleAspectFit
        imgv.clipsToBounds = true
        imgv.roundCorners(4)
        imgv.image = #imageLiteral(resourceName: "applogo")
        return imgv
    }()
    
    lazy var titleLable: BasicLabel = {
        let label = BasicLabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Quote Studio Pro"
        return label
    }()
    
    lazy var detailLable: BasicLabel = {
        let label = BasicLabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var purchaseButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = #colorLiteral(red: 0.1297397017, green: 0.1362194717, blue: 0.1622923017, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.roundCorners(5.0)
        return button
    }()
    
    lazy var cancelButton: UIButton = { [unowned self] by in
        let button = UIButton(frame: .zero)
        button.backgroundColor = .primaryDark
        button.borderlize(#colorLiteral(red: 0.1297397017, green: 0.1362194717, blue: 0.1622923017, alpha: 1), 1)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.setTitle("Cancel", for: .normal)
        button.addTarget(self, action: #selector(cancel(_:)), for: .touchUpInside)
        button.roundCorners(5.0)
        return button
    }(())
    
    @objc func purchase(_ sender:UIButton){
        guard let product = product else {return}
        subscribeTo(subscription: .purchaseNotification, selector: #selector(purchased(_:)))
        subscribeTo(subscription: .failedPurchase, selector: #selector(failedTransaction(_:)))
        Store.main.buyProduct(product: product)
        activityController.isHidden = false
        activityController.startAnimating()
        purchaseButton.isHidden = true
        restoreButton.isHidden = true
        cancelButton.isHidden = true
        detailLable.isHidden = true
        indicatorLable.text = "Communicating with iTunes"
        indicatorLable.isHidden = false
        //cancel(sender)
    }
    
    @objc func failedTransaction(_ notification:Notification){
        guard let error = notification.userInfo?[.info] as? NSError else {return}
        print("Purchase Error with sig: ", error.localizedDescription)
        self.detailLable.isHidden = false
        self.activityController.isHidden = true
        self.indicatorLable.isHidden = true
        self.detailLable.textColor = .red
        self.detailLable.text = error.localizedDescription
        cancelButton.isHidden = false
        
    }
    
    @objc func restorePurchase(_ sender:UIButton){
        sender.isHidden = true
        subscribeTo(subscription: .purchaseNotification, selector: #selector(purchased(_:)))
        subscribeTo(subscription: .failedPurchase, selector: #selector(failedTransaction(_:)))
        Store.main.restorePurchase()
        activityController.isHidden = false
        activityController.startAnimating()
        purchaseButton.isHidden = true
        cancelButton.isHidden = true
        detailLable.isHidden = true
        indicatorLable.text = "Communicating with iTunes"
        indicatorLable.isHidden = false
    }
    
    @objc func purchased(_ notification:Notification){
        
        animateout()
    }
    
    
    @objc func cancel(_ sender:UIButton){
        animateout()
    }
    
    func animateout(){
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
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        activityController.startAnimating()
        if Store.main.hasProduct{
            self.product = Store.main.studioProProduct
        }else{
            Store.main.requestProProduct { (success,products, error ) in
                AsyncOnMainThread {
                    if success{
                        if let product = products?.first {
                            self.product = product
                        }else{
                            self.detailLable.isHidden = false
                            self.activityController.isHidden = true
                            self.indicatorLable.isHidden = true
                            self.detailLable.textColor = .red
                            self.detailLable.text = "Unable to connect to iTunes store"
                        }
                    }else{
                        self.detailLable.isHidden = false
                        self.activityController.isHidden = true
                        self.indicatorLable.isHidden = true
                        self.detailLable.textColor = .red
                        self.detailLable.text = error?.localizedDescription
                    }
                }
            }
        }
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
        presentationView.addSubview(indicatorLable)
        presentationView.addSubview(activityController)
        presentationView.addSubview(restoreButton)
        detailLable.isHidden = true
        purchaseButton.isHidden = true
        restoreButton.isHidden = true
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
            $0.height |=| 400
        }
        imageView.layout{
            $0.centerX == presentationView.centerXAnchor
            $0.top == presentationView.topAnchor + 20
            $0.width |=| 100
            $0.height |=| 100
        }
        restoreButton.layout{
            $0.top == presentationView.topAnchor + 20
            $0.trailing == presentationView.trailingAnchor - 8
            $0.height |=| 30
            $0.width |=| 100
        }
        titleLable.layout{
            $0.centerX == presentationView.centerXAnchor
            $0.top == imageView.bottomAnchor + 20
            
        }
        detailLable.layout{
            $0.leading == leadingAnchor + 16
            $0.trailing == trailingAnchor - 16
            $0.top == titleLable.bottomAnchor + 20
            
        }
        
        activityController.layout{
            $0.top == titleLable.bottomAnchor + 16
            $0.centerX == presentationView.centerXAnchor
            $0.width |=| 50
            $0.height |=| 50
        }
        
        indicatorLable.layout{
            $0.centerX == centerXAnchor
            $0.top == activityController.bottomAnchor + 16
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
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        unsubscribe()
    }
    
    func show(){
        self.alpha = 0
        DispatchQueue.main.async { //[unowned self] in
            UIApplication.shared.keyWindow?.addSubview(self)
            UIView.animate(withDuration: 0.5, animations: {
                self.alpha = 1
            }, completion: nil)
        }
        
    }
}
