//
//  QMBaseVC.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 28/02/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class QMBaseVC: UIViewController {
    
    lazy var baseView:UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        return view
    }()
    
    lazy var createButton:CreateButton = {
       let button = CreateButton()
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(baseView)
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupViews()
    }
    
    func setupViews(){
        
        baseView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            baseView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            baseView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            baseView.widthAnchor.constraint(equalToConstant: .fixedWidth),
            baseView.heightAnchor.constraint(equalToConstant: .fixedWidth)
        ])
        createButton.frame = CGRect(origin: .zero, size: Dimensions.sizedRectForScale(rectSize: baseView.bounds.size, scale: 0.5))
        createButton.center = baseView.center
        view.addSubview(createButton)
    }

}
