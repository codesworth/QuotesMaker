//
//  LayoutProperty.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 27/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import Foundation


struct LayoutProperty<Anchor:LayoutAnchor> {
    fileprivate let anchor:Anchor
}

class LayoutProxy{
    
    lazy var leading = property(with: view.leadingAnchor)
    lazy var trailing = property(with: view.trailingAnchor)
    lazy var top = property(with: view.topAnchor)
    lazy var bottom = property(with: view.bottomAnchor)
    lazy var width = property(with: view.widthAnchor)
    lazy var height = property(with: view.heightAnchor)
    lazy var centerX = property(with: view.centerXAnchor)
    lazy var centerY = property(with: view.centerYAnchor)
    private let view: UIView
    
    init(view: UIView) {
        self.view = view
    }
    
    private func property<A: LayoutAnchor>(with anchor: A) -> LayoutProperty<A> {
        return LayoutProperty(anchor: anchor)
    }
    
    
    
}


extension LayoutProperty {
    
    
    @discardableResult
    func equal(to otherAnchor: Anchor, offsetBy constant: CGFloat = 0)->NSLayoutConstraint {
        let constraint = anchor.constraint(equalTo: otherAnchor,
                          constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func greaterThanOrEqual(to otherAnchor: Anchor,
                            offsetBy constant: CGFloat = 0)->NSLayoutConstraint {
        let constraint = anchor.constraint(greaterThanOrEqualTo: otherAnchor,
                          constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func lessThanOrEqual(to otherAnchor: Anchor,
                         offsetBy constant: CGFloat = 0)->NSLayoutConstraint {
        let constraint = anchor.constraint(lessThanOrEqualTo: otherAnchor,
                          constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func equal(to constant:CGFloat)->NSLayoutConstraint{
        
        let constraint = anchor.constraint(equalToConstant: constant)
        constraint.isActive = true
        return constraint
    }
    
    
}
