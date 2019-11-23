//
//  CollectionViewDelegates.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 07/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

extension TextDesignableInputView:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fonts.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard indexPath.row < fonts.count else {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MoreFontCells.self)", for: indexPath) as! MoreFontCells
            return cell
        }
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(FontCells.self)", for: indexPath) as? FontCells{
            let font = fonts[indexPath.row]
            cell.configure(font: font)
            return cell
        }
        return FontCells()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return [80,70]
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.row < fonts.count else {
            Subscription.main.post(suscription: .moreFonts, object: nil)
            return
        }
        chosenFont = fonts[indexPath.row].fontName
        let newFont = UIFont(name: chosenFont, size: CGFloat(fontSizeStepper.value))!
        model.font = newFont
        delegate?.didUpdateModel(model,true)
    }
    
}
