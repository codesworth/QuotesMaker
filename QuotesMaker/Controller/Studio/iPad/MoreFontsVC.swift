//
//  FontsVC.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 19/05/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class MoreFontsVC: UIViewController {
    private var engine = FontEngine()
    private var fonts:[UIFont] = []
    var model:TextLayerModel!
    weak var delegate:TextModelDelegate?
    @IBOutlet weak var previewTextView: UITextView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        fonts = engine.getAvailableFonts()
        collectionView.register(UINib(nibName: "\(FontCells.self)", bundle: nil), forCellWithReuseIdentifier: "\(FontCells.self)")
        collectionView.delegate = self
        collectionView.dataSource = self
        if !__IS_IPAD{
            previewTextView.attributedText = model.outPutString()
        }
        // Do any additional setup after loading the view.
    }
    
    
    func updateFonts(with name:String){
        defer {collectionView.reloadData()}
        if name == ""{
            fonts = engine.getAvailableFonts()
        }else{
            fonts = engine.filterFonts(search: name)
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func donePressed(_ sender: Any) {
        if __IS_IPAD{
            removeFrom()
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
}



extension MoreFontsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fonts.count 
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(FontCells.self)", for: indexPath) as? FontCells{
            let font = fonts[indexPath.row]
            cell.configure(font: font)
            return cell
        }
        return FontCells()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return [100,70]
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let chosenFont = fonts[indexPath.row]
        model.font = chosenFont
        delegate?.didUpdateModel(model)
        if !__IS_IPAD{
            previewTextView.attributedText = model.outPutString()
        }
    }
}


extension MoreFontsVC:UISearchBarDelegate{
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        let text =  searchBar.text
        updateFonts(with: text ?? "")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        updateFonts(with: searchText)
    }
}







