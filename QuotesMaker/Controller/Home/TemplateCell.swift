//
//  TemplateCell.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 29/04/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class TemplateCell: UICollectionViewCell {
    private var width:CGFloat = 200
    private var height:CGFloat = 160
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    lazy var imageView:UIImageView = {
        let view = UIImageView(frame: .zero)
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.idiom == .phone{
            width = 120
            height = 100
        }
        containerView.addSubview(imageView)
        
        // Initialization code
    }
    
    func layoutImageView(size:CGSize){
        let ratio = size.width/size.height
        let newSize:CGSize = (size.width > size.height) ? [width,height * (1/ratio)] : [width * ratio,height]
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layout{
            $0.width |=| newSize.width
            $0.height |=| newSize.height
            $0.centerY == containerView.centerYAnchor
            $0.centerX == containerView.centerXAnchor
        }
    }
    
    
    func configureView(name:String, icon:String,size:CGSize){
        layoutImageView(size: size)
        titleLabel.text = name
        imageView.image = UIImage(named: icon)
    }
    
    func configureViewAndIamge(name:String?,size:CGSize){
        layoutImageView(size: size)
        //print(src.path)
        titleLabel.text = name
        imageView.image = Persistence.main.getThumbImageFor(name: name!)
        //let image = UIImage(contentsOfFile: src.path)
        //imageVIew.image = image
//        let exist = FileManager.default.fileExists(atPath: src.path)
//        print("The path is: \(src.path)")
//        print(exist)
//        do {
//
//            let data = try Data(contentsOf: src)
//            let image = UIImage(data: data)
//            imageVIew.image = image
//        } catch let err {
//            print(err.localizedDescription)
//        }
//
    }

}
