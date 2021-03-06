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
        if UIDevice.idiom == .pad{closeButton.isHidden = true}
        addFilterButton.roundCorners()
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
//            stateControl.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -12),
//            stateControl.topAnchor.constraint(equalTo: topAnchor, constant: 12),
//            stateControl.widthAnchor.constraint(equalToConstant: 70),
//            stateControl.heightAnchor.constraint(equalToConstant: 30),
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
            stack.topAnchor.constraint(equalTo: pickFromGalleryButton.bottomAnchor, constant: 12),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            stack.heightAnchor.constraint(equalToConstant: 40),
            addFilterButton.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 12),
            addFilterButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            addFilterButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            addFilterButton.heightAnchor.constraint(equalToConstant: 40),
            modelable.topAnchor.constraint(equalTo: addFilterButton.bottomAnchor, constant: 24),
            modelable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            aspectSegment.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            aspectSegment.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            aspectSegment.topAnchor.constraint(equalTo: modelable.bottomAnchor, constant: 12),
            aspectSegment.heightAnchor.constraint(equalToConstant: 30)
            
        ])
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
//        subscribeTo(subscription: .canUndo, selector: #selector(canUndo(_:)))
//        subscribeTo(subscription: .canRedo, selector: #selector(canRedo(_:)))
    }
    
    
    
}
