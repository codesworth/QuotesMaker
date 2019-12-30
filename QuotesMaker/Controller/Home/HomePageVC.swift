//
//  HomePageVC.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 29/04/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class HomePageVC: UIViewController {
    
    @IBOutlet weak var header: UIView!
    @IBOutlet weak var recentCollectionVIew: UICollectionView!
    @IBOutlet weak var templatesCollection: UICollectionView!
    @IBOutlet weak var dimensionsProjectCollection: UICollectionView!
    
    public private (set) var allModels:[StudioModel] = []
    public private (set) var sizes:[Canvas] = []
    public private (set) var templates:[StudioModel] = []
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recentCollectionVIew.showsHorizontalScrollIndicator = false
        dimensionsProjectCollection.showsHorizontalScrollIndicator = false
        templatesCollection.showsHorizontalScrollIndicator = false
        setup()
        makeSizes()
        
    }
    
    func makeSizes(){
        sizes = Canvas.AspectRatios.allCases.compactMap{Canvas(aspect: $0)}
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        header.layer.cornerRadius = __IS_IPAD ? 40 : 30
        refreshRecent()
        refreshTemplate()
        subscribeTo(subscription: .refreshRecent, selector: #selector(refreshRecent))
        subscribeTo(subscription: .refreshTemplates, selector: #selector(refreshTemplate))
    }
    
    @objc func refreshRecent(){
        allModels = Persistence.main.fetchAllModels(from: FileManager.modelDir)
        
        dispatch_queue_main_t.main.async { [weak self] in
            self?.recentCollectionVIew.reloadData()
            
        }
    }
    
    @objc func refreshTemplate(){
        templates = Persistence.main.fetchAllModels(from: FileManager.templatesDir)
        dispatch_queue_main_t.main.async { [weak self] in
            self?.templatesCollection.reloadData()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unsubscribe()
    }
    
    func setup(){
        
        recentCollectionVIew.register(UINib(nibName: "\(TemplateCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(TemplateCell.self)")
        recentCollectionVIew.delegate = self
        recentCollectionVIew.dataSource = self
        dimensionsProjectCollection.register(UINib(nibName: "\(TemplateCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(TemplateCell.self)")
        dimensionsProjectCollection.delegate = self
        dimensionsProjectCollection.dataSource = self
        templatesCollection.register(UINib(nibName: "\(TemplateCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(TemplateCell.self)")
        recentCollectionVIew.roundCorners()
        templatesCollection.delegate = self
        templatesCollection.dataSource = self
        dimensionsProjectCollection.roundCorners()                                                           
    }
    
    
    @IBAction func showAllRecents(_ sender: UIButton) {
        if let allRecentsVc = AllProjectsVC.wakeFromInterfaceBuilder(){
            allRecentsVc.allModels = allModels
            allRecentsVc.content = .recent
            allRecentsVc.delegate = self
            self.present(allRecentsVc, animated: true, completion: nil)
        }
    }
    
    @IBAction func showAllTemplates(_ sender: UIButton) {
    }
    
    
    @IBAction func ipadSettingsPressed(_ sender: UIButton) {
        if let settings = UIStoryboard.storyboard.instantiateViewController(withIdentifier: "iPadSettingsTab") as? UINavigationController{
            settings.modalPresentationStyle = .popover
            let presentation = settings.popoverPresentationController
            presentation?.permittedArrowDirections = .any
            presentation?.sourceView = sender
            presentation?.sourceRect = sender.bounds

            present(settings, animated: true, completion: nil)
        }
    }
    
}


extension HomePageVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == recentCollectionVIew{
            if allModels.isEmpty{
                let view = RecentEmptyView(frame: recentCollectionVIew.frame)
                recentCollectionVIew.backgroundView = view
            }else{
                recentCollectionVIew.backgroundView = nil
            }
            return allModels.count
        }else if collectionView == templatesCollection{
            return templates.count
        }
        return sizes.count
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(TemplateCell.self)", for: indexPath) as! TemplateCell
        if collectionView == recentCollectionVIew || collectionView == templatesCollection{
            let mod = (collectionView == recentCollectionVIew) ? allModels[indexPath.row] : templates[indexPath.row]
            let canvas = Canvas(aspect: mod.canvasType)
            cell.configureViewAndIamge(name: mod.name, size: canvas.size)
            return cell
        }else {
            let canvas = sizes[indexPath.row]
            cell.configureView(canvas)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.idiom == .phone{
            return [120]
        }
        return [200]
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionViewItemSelected(collectionView: collectionView, indexPath: indexPath)
    }
    
    @discardableResult func collectionViewItemSelected(collectionView:UICollectionView, indexPath:IndexPath)->UIViewController{
        let studio:UIViewController
        if collectionView ==  recentCollectionVIew || collectionView == templatesCollection{
            let model = (collectionView == recentCollectionVIew) ? allModels[indexPath.row] : templates[indexPath.row]
            
            if UIDevice.idiom == .phone{
                studio = StudioVC(model: model, canvas:Canvas(aspect: model.canvasType), isTemplate: collectionView == templatesCollection)
            }else{
              studio = iPadStudioVC(model: model, canvas:Canvas(aspect: model.canvasType),isTemplate: collectionView == templatesCollection)
            }
            studio.modalPresentationStyle = .fullScreen
            present(studio, animated: true, completion: nil)
            return studio
        }else{
            let canvas = sizes[indexPath.row]
            let studio:UIViewController
            if UIDevice.idiom == .phone{
                studio = StudioVC(canvas:canvas)
            }else{
                studio = iPadStudioVC(canvas: canvas)
            }
            studio.modalPresentationStyle = .fullScreen
            present(studio, animated: true, completion: nil)
            return studio
        }
    }
}


extension HomePageVC:ProjectsDelegate{
    
    func didSelect(project: StudioModel, isTemplate:Bool) {
        let studio:UIViewController
        
        if UIDevice.idiom == .phone{
            studio = StudioVC(model: project, canvas:Canvas(aspect: project.canvasType), isTemplate: isTemplate)
        }else{
          studio = iPadStudioVC(model: project, canvas:Canvas(aspect: project.canvasType),isTemplate: isTemplate)
        }
        studio.modalPresentationStyle = .fullScreen
        present(studio, animated: true, completion: nil)
    }
}


