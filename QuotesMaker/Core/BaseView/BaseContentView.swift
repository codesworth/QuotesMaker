//
//  File.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 21/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit



final class BaseContentView:UIView{
    
    var viewTags:(imgs:Int,txt:Int,blk:Int,grd:Int) = (0,0,0,0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func initialize(){
        backgroundColor = .cyan
        clipsToBounds = true
    }
    
    var current:BaseView.BaseSubView?
    
    override func willRemoveSubview(_ subview: UIView) {
        let subs = subviews.filter{$0 != subview}
        Subscription.main.post(suscription: .layerChanged, object: subs)
        
    }
    
    
    override func didAddSubview(_ subview: UIView) {
        super.didAddSubview(subview)
        if let view = subview as?  BackingImageView{
            viewTags.imgs += 1
            view.id_tag = viewTags.imgs
        }else if let view = subview as? BackingTextView{
            viewTags.txt += 1
            view.id_tag = viewTags.txt
        }else if let view = subview as? WrapperView{
            if let _ = view.superlayer as? BackingGradientlayer{
                viewTags.grd += 1
                view.grd_tag = viewTags.grd
            }
            else{
                viewTags.blk += 1
                view.blk_tag = viewTags.blk
                
            }
        }
        current = subview as? BaseView.BaseSubView
        Subscription.main.post(suscription: .layerChanged, object: subviews)
    }
}
