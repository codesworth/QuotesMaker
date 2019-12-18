//
//  RecentEmptyView.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 30/11/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


class RecentEmptyView:UIView{
    
    
    lazy var lable:UILabel = {
        let lable = BasicLabel(frame: .zero, font: UIFont.systemFont(ofSize: 18, weight: .thin))
        lable.text =
        """
        No Recent Projects
        Start A New Project
        """
        lable.textColor = .white
        return lable
    }()
    
    lazy var imageView:UIImageView = {
        let imagev = UIImageView(image: UIImage(named:"pen_white"))
        imagev.contentMode = .scaleAspectFill
        return imagev
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(lable)
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(5)
        backgroundColor = .secondaryDark
        lable.layout{
            $0.top == topAnchor + 8
            $0.centerX == centerXAnchor
        }
        
        imageView.layout{
            $0.top == lable.bottomAnchor + 16
            $0.centerX == centerXAnchor
            $0.height |=| 100
            $0.width |=| 100
        }
    }
}
