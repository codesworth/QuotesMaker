//
//  AllProjectsVC.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 23/12/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

protocol ProjectsDelegate:class {
    func didSelect(project:StudioModel, isTemplate:Bool)
}


class AllProjectsVC: UIViewController {
    
    enum ContentType{
        case recent, template
    }
    
    
    
    @IBOutlet weak var headerLable: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var content:ContentType!
    var allModels:[StudioModel] = []
    weak var delegate:ProjectsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()

    }
    
    @IBAction func donePressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //refreshRecent()
        //subscribeTo(subscription: .refreshRecent, selector: #selector(refreshRecent))
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    @objc func refreshRecent(){
        allModels = Persistence.main.fetchAllModels()
        dispatch_queue_main_t.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    

    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unsubscribe()
    }
    
    func setup(){
        headerLable.text = (content == .template) ? "All Templates" : "All Projects"
          
        
        collectionView.register(UINib(nibName: "\(TemplateCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(TemplateCell.self)")
        
       
    }

}


extension AllProjectsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if allModels.isEmpty{
            let view = RecentEmptyView(frame: collectionView.frame)
            collectionView.backgroundView = view
        }else{
            collectionView.backgroundView = nil
        }
        return allModels.count
        
       
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(TemplateCell.self)", for: indexPath) as! TemplateCell
        
        let mod = allModels[indexPath.row]
        let canvas = Canvas(aspect: mod.canvasType)
        cell.configureViewAndIamge(name: mod.name, size: canvas.size)
        //cell.configure(font: .systemFont(ofSize: 35, weight: .bold))
        //cell.backgroundColor = [UIColor.white, UIColor.green, UIColor.blue, UIColor.magenta].randomElement()
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.idiom == .phone{
            return [120]
        }
        return [200]
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: nil)
        let model = allModels[indexPath.row]
        delegate?.didSelect(project: model, isTemplate: content == .template)
    }
    
    @discardableResult func collectionViewItemSelected(collectionView:UICollectionView, indexPath:IndexPath)->UIViewController{
        //let studio:UIViewController
        return UIViewController()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}



extension AllProjectsVC{
    
    class func wakeFromInterfaceBuilder()->AllProjectsVC?{
        if let controller = UIStoryboard.storyboard.instantiateViewController(withIdentifier: "\(AllProjectsVC.self)") as? AllProjectsVC{
            return controller
        }
        return nil
    }
}
