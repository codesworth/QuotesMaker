//
//  HomePageVC.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 29/04/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class HomePageVC: UIViewController {
    
    @IBOutlet weak var recentCollectionVIew: UICollectionView!
    @IBOutlet weak var templatesCollection: UICollectionView!
    @IBOutlet weak var dimensionsProjectCollection: UICollectionView!
    
    private var allModels:[StudioModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        //Persistence.main.getThumbImageFor(name:"")
        //print("These are stored modles: \(allModels)")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        allModels = Persistence.main.fetchAllModels()
        recentCollectionVIew.reloadData()
    }
    
    func setup(){
        recentCollectionVIew.register(UINib(nibName: "\(TemplateCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(TemplateCell.self)")
        recentCollectionVIew.delegate = self
        recentCollectionVIew.dataSource = self
        dimensionsProjectCollection.register(UINib(nibName: "\(TemplateCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(TemplateCell.self)")
        dimensionsProjectCollection.delegate = self
        dimensionsProjectCollection.dataSource = self
        //recentCollectionVIew.register(UINib(nibName: "\(TemplateCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(TemplateCell.self)")
    }

}


extension HomePageVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == recentCollectionVIew{
            return allModels.count
        }
        return 4
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(TemplateCell.self)", for: indexPath) as! TemplateCell
        if collectionView == recentCollectionVIew{
            let mod = allModels[indexPath.row]
            cell.configureViewAndIamge(name: mod.name)
            return cell
        }
        cell.configureView(name: "Instagram")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return [200]
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView ==  recentCollectionVIew{
            let model = allModels[indexPath.row]
            let studio = iPadStudioVC(model: model)
            present(studio, animated: true, completion: nil)
        }else{
            
            let studio = iPadStudioVC()
            present(studio, animated: true, completion: nil)
        }
    }
}