//
//  Subviews.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 07/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


extension TextDesignableInputView{
    
    func setConstraints(){
        let scrollCon = [scrollView.topAnchor.constraint(equalTo: topAnchor),
                         scrollView.leftAnchor.constraint(equalTo: leftAnchor),
                         scrollView.rightAnchor.constraint(equalTo: rightAnchor),
                         scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
                         contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                         contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
                         contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                         contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
                         contentView.widthAnchor.constraint(equalTo: widthAnchor),
                         contentView.heightAnchor.constraint(equalToConstant: 950)]
        let contents1 = [titleLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                         titleLable.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                         headlineline.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 4),
                         headlineline.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 48),
                         headlineline.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -48),
                         headlineline.heightAnchor.constraint(equalToConstant: 1),
                         
                         aligmentSegment.topAnchor.constraint(equalTo: headlineline.bottomAnchor, constant: 12),
                         aligmentSegment.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                         aligmentSegment.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                         aligmentSegment.heightAnchor.constraint(equalToConstant: 30),
            

                         fontCollectionview.topAnchor.constraint(equalTo: aligmentSegment.bottomAnchor, constant: 12),
                         fontCollectionview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                         fontCollectionview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                         fontCollectionview.heightAnchor.constraint(equalToConstant: 80),
                         firstline.topAnchor.constraint(equalTo: fontCollectionview.bottomAnchor, constant: 8),
                         firstline.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
                         firstline.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
                         firstline.heightAnchor.constraint(equalToConstant: 1),
                         fontSizeLable.topAnchor.constraint(equalTo: firstline.bottomAnchor, constant: 8),
                         fontSizeLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
                         fontColorLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
                         fontColorLable.topAnchor.constraint(equalTo: firstline.bottomAnchor, constant: 12),
                         fontSizeStepper.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
                         fontSizeStepper.topAnchor.constraint(equalTo: fontSizeLable.bottomAnchor, constant: 8),]
        
        let content2 = [colorSlider.topAnchor.constraint(equalTo: fontColorLable.bottomAnchor, constant: 8),
                        colorSlider.leadingAnchor.constraint(equalTo: fontSizeStepper.trailingAnchor, constant: 30),
                        colorSlider.heightAnchor.constraint(equalToConstant: 20),
                        colorSlider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
                        secondline.topAnchor.constraint(equalTo: colorSlider.bottomAnchor, constant: 24),
                        secondline.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
                        secondline.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
                        secondline.heightAnchor.constraint(equalToConstant: 1),
                        strokeLabel.topAnchor.constraint(equalTo: secondline.bottomAnchor, constant: 12),
                        strokeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                        strokeWidthLabel.topAnchor.constraint(equalTo: strokeLabel.bottomAnchor, constant: 8),
                        strokeWidthLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                        strokeColorLabel.topAnchor.constraint(equalTo: strokeLabel.bottomAnchor, constant: 8),
                        strokeColorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                        strokeWidthStepper.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
                        strokeWidthStepper.topAnchor.constraint(equalTo: strokeWidthLabel.bottomAnchor, constant: 8),
                        strokeColorSlider.topAnchor.constraint(equalTo: strokeColorLabel.bottomAnchor, constant: 8),
                        strokeColorSlider.leadingAnchor.constraint(equalTo: strokeWidthStepper.trailingAnchor, constant: 30),
                        strokeColorSlider.heightAnchor.constraint(equalToConstant: 20),
                        strokeColorSlider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
                        thirdline.topAnchor.constraint(equalTo: strokeColorSlider.bottomAnchor, constant: 24),
                        thirdline.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
                        thirdline.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
                        thirdline.heightAnchor.constraint(equalToConstant: 1),
                        strikeLabel.topAnchor.constraint(equalTo: thirdline.bottomAnchor, constant: 8),
                        strikeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                        strikeStyleLabel.topAnchor.constraint(equalTo: strikeLabel.bottomAnchor, constant: 8),
                        strikeStyleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                        strikeColorLabel.topAnchor.constraint(equalTo: strikeLabel.bottomAnchor, constant: 8),
                        strikeColorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                        strikeThroughStyleStepper.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
                        strikeThroughStyleStepper.topAnchor.constraint(equalTo: strikeStyleLabel.bottomAnchor, constant: 8),
                        strikeThroghColorSlider.topAnchor.constraint(equalTo: strikeColorLabel.bottomAnchor, constant: 8),
                        strikeThroghColorSlider.leadingAnchor.constraint(equalTo: strikeThroughStyleStepper.trailingAnchor, constant: 30),
                        strikeThroghColorSlider.heightAnchor.constraint(equalToConstant: 20),
                        strikeThroghColorSlider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant:-12),]
       let content3 = [
            
        
            fourthline.topAnchor.constraint(equalTo: strikeThroghColorSlider.bottomAnchor, constant: 24),
            fourthline.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            fourthline.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            fourthline.heightAnchor.constraint(equalToConstant: 1),
            underlinelable.topAnchor.constraint(equalTo: fourthline.bottomAnchor, constant: 8),
            underlinelable.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            underlineStylelable.topAnchor.constraint(equalTo: underlinelable.bottomAnchor, constant: 8),
            underlineStylelable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            underlineColorlable.topAnchor.constraint(equalTo: underlinelable.bottomAnchor, constant: 8),
            underlineColorlable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            underlineStyleStepper.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            underlineStyleStepper.topAnchor.constraint(equalTo: underlineStylelable.bottomAnchor, constant: 8),
            underlineColorSlider.topAnchor.constraint(equalTo: underlineColorlable.bottomAnchor, constant: 8),
            underlineColorSlider.leadingAnchor.constraint(equalTo: underlineStyleStepper.trailingAnchor, constant: 30),
            underlineColorSlider.heightAnchor.constraint(equalToConstant: 20),
            underlineColorSlider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant:-12),
            fifthline.topAnchor.constraint(equalTo: underlineColorSlider.bottomAnchor, constant: 24),
            fifthline.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            fifthline.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            fifthline.heightAnchor.constraint(equalToConstant: 1),
            obliqLabel.topAnchor.constraint(equalTo: fifthline.bottomAnchor, constant: 8),
            obliqLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            obliqStyleLabel.topAnchor.constraint(equalTo: obliqLabel.bottomAnchor, constant: 8),
            obliqStyleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            obliqueStepper.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            obliqueStepper.topAnchor.constraint(equalTo: obliqStyleLabel.bottomAnchor, constant: 8),
            sixthline.topAnchor.constraint(equalTo: obliqueStepper.bottomAnchor, constant: 24),
            sixthline.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            sixthline.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            sixthline.heightAnchor.constraint(equalToConstant: 1),
            shadowView.topAnchor.constraint(equalTo: sixthline.bottomAnchor, constant: 16),
            shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            shadowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            shadowView.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        NSLayoutConstraint.activate(scrollCon)
        NSLayoutConstraint.activate(contents1)
        NSLayoutConstraint.activate(content2)
        NSLayoutConstraint.activate(content3)
    }
}
