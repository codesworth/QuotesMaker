//
//  HomeVC.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 24/02/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit



class HomeVC:UIViewController{
    
    
    lazy var imageView:UIImageView = {
        let v = UIImageView(frame: .zero)
        v.contentMode = .scaleAspectFill
        v.isUserInteractionEnabled = true
        return v
    }()
    
    lazy var filterButton:UIButton = {
        let but = UIButton(frame: .zero)
        but.setTitle("Add Filter", for: .normal)
        but.setTitleColor(.magenta, for: .normal)
        but.backgroundColor = .clear
        return but
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        view.addSubview(filterButton)
        filterButton.addTarget(self, action: #selector(filter), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        tap.numberOfTapsRequired = 1
        imageView.addGestureRecognizer(tap)
    }
    
    @objc func filter(){
        
    }
    
    @objc func imageTapped(_ tap:UITapGestureRecognizer){
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupView(){
       imageView.translatesAutoresizingMaskIntoConstraints = false
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: .photoDimension),
            imageView.heightAnchor.constraint(equalToConstant: .photoDimension),
            filterButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            filterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            filterButton.heightAnchor.constraint(equalToConstant: 40),
            filterButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}

extension CGFloat{
    
    static var photoDimension:CGFloat{
        return UIScreen.main.bounds.width * 0.9
    }
}
