//
//  Layout.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 20/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import Foundation


extension ImagePanel{
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        pickFromInternetButton.roundCorners()
        pickFromGalleryButton.roundCorners(5)
        subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        scrollView.subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        contentView.subviews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            header.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            closeButton.widthAnchor.constraint(equalToConstant: 35),
            closeButton.heightAnchor.constraint(equalToConstant: 35),
            stateControl.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -12),
            stateControl.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            stateControl.widthAnchor.constraint(equalToConstant: 70),
            stateControl.heightAnchor.constraint(equalToConstant: 30),
            scrollView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 12),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 12),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: height),
            pickFromGalleryButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            pickFromGalleryButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            pickFromGalleryButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            //pickFromGalleryButton.widthAnchor.constraint(equalToConstant: 120),
            pickFromGalleryButton.heightAnchor.constraint(equalToConstant: 40),
            pickFromInternetButton.topAnchor.constraint(equalTo: pickFromGalleryButton.bottomAnchor, constant: 12),
            pickFromInternetButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            pickFromInternetButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            pickFromInternetButton.heightAnchor.constraint(equalToConstant: 40),
            //            testActionsSegment.topAnchor.constraint(equalTo: pickFromInternetButton.bottomAnchor, constant: 12),
            //            testActionsSegment.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            //            testActionsSegment.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            //            testActionsSegment.heightAnchor.constraint(equalToConstant: 30)
            
            ])
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        subscribeTo(subscription: .canUndo, selector: #selector(canUndo(_:)))
        subscribeTo(subscription: .canRedo, selector: #selector(canRedo(_:)))
    }
    
    
    
}
