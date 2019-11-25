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
    private var imageViewConstraints: [NSLayoutConstraint] = []
    
    private var canvas:Canvas?
    lazy var imageView:UIImageView = {
        let view = UIImageView(frame: .zero)
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.idiom == .phone{
            width = 100
            height = 100
        }
        containerView.addSubview(imageView)
        imageView.roundCorners()
        
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        if UIDevice.idiom == .phone{
                   width = 100
                   height = 100
               }
    }
    
    func layoutImageView(size:CGSize){
        imageView.removeConstraints(imageViewConstraints)
        let ratio = size.width/size.height
        let newSize:CGSize = (size.width > size.height) ? [width,height * (1/ratio)] : [width * ratio,height]
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageViewConstraints.removeAll()
        imageViewConstraints = [
            imageView.widthAnchor.constraint(equalToConstant: newSize.width),
            imageView.heightAnchor.constraint(equalToConstant: newSize.height),
            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -8),
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(imageViewConstraints)
        
//        imageView.layout{
//            $0.width |=| newSize.width
//            $0.height |=| newSize.height
//            $0.bottom == titleLabel.topAnchor - 8
//            $0.centerX == containerView.centerXAnchor
//        }
    }
    
    
    func configureView(_ canvas:Canvas){
        self.canvas = canvas
        layoutImageView(size: canvas.size)
        titleLabel.text = canvas.name
        imageView.backgroundColor = .secondaryDark
        
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
