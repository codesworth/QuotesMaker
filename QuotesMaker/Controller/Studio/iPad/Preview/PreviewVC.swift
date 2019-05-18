//
//  PreviewVC.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 15/05/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class PreviewVC: UIViewController {
    
    var filterEngine = FilterEngine.globalInstance
    
    lazy var imageView:UIImageView = {
        let imv = UIImageView(frame: .zero)
        imv.clipsToBounds = true
        imv.contentMode = .center
        return imv
    }()
    
    var inputImage:UIImage!
    var canvas:Canvas!
    @IBOutlet weak var imageContainerView: UIView!
    
    @IBOutlet weak var filterView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = inputImage
        filterView.delegate = self
        filterView.dataSource = self
        // Do any additional setup after loading the view.
        setupImageView()
    }
    
    
    func setupImageView(){
        //let maxSide = imageContainerView.frame.size.max
        imageView.frame.size = canvas.size
        imageContainerView.addSubview(imageView)
        imageView.center = imageContainerView.center
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func shareImage(_ sender: UIButton) {
        let image  = inputImage
        let alert = UIActivityViewController(activityItems: [image as Any], applicationActivities: [])
        alert.modalPresentationStyle = .currentContext
        let presentation = alert.popoverPresentationController
        presentation?.permittedArrowDirections = .any
        presentation?.sourceView = sender
        presentation?.sourceRect = sender.frame
        present(alert, animated: true){}
    }
    
    @IBAction func saveToPhotos(_ sender: Any) {
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        filterEngine.purge()
    }
}


extension PreviewVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterEngine.availableFilters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(FilterCollectionCell.self)", for: indexPath) as! FilterCollectionCell
        let filter = filterEngine.availableFilters[indexPath.row]
        cell.configureView(name: filter, image: inputImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return [140,180]
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let name = filterEngine.availableFilters[indexPath.row]
        if let image = filterEngine.imageFor(name){
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
        }else{
            imageView.contentMode = .scaleAspectFit
            imageView.image = inputImage
        }
    }
}
