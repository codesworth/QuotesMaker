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
    var filters = Filters.CustomFilters.allCases
    
    lazy var imageView:UIImageView = {
        let imv = UIImageView(frame: .zero)
        imv.clipsToBounds = true
        imv.contentMode = .scaleAspectFit
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
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupImageView()
    }
    
    func setupImageView(){
        let width = imageContainerView.frame.width
        let height = imageContainerView.frame.height
        
        let newWidth:CGFloat
        let newHeight:CGFloat
        if canvas.ratio > 1{
            newWidth = (canvas.size.width > width) ? width - 30 : canvas.size.width
            newHeight = (canvas.size.width > width) ? canvas.size.height * (width / canvas.size.width) : canvas.size.height
            //originX = (imageContainerView.bounds.maxX - width) / 2
            //originY = (imageContainerView.bounds.maxY - height) / 2
        }else if canvas.ratio < 1{
            newHeight = (canvas.size.height > height) ? height - 30 : canvas.size.height
            newWidth = (canvas.size.height > height) ? canvas.size.width * (height / canvas.size.height) : canvas.size.width
            //originX = (imageContainerView.bounds.maxX - width) / 2
            //originY = 0
        }else{
            newWidth = imageContainerView.frame.size.min - 30
            newHeight = imageContainerView.frame.size.min - 30
            //originX = (imageContainerView.bounds.maxX - width) / 2
            //originY = (imageContainerView.bounds.maxY - height) / 2
        }
         //imageView.frame.size = [originX,originY, newWidth,newHeight]
        imageContainerView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layout{
            $0.centerX == imageContainerView.centerXAnchor
            $0.centerY == imageContainerView.centerYAnchor
            $0.width |=| newWidth
            $0.height |=| newHeight
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
        return filters.count//filterEngine.availableFilters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(FilterCollectionCell.self)", for: indexPath) as! FilterCollectionCell
        let filter = filters[indexPath.row]//filterEngine.availableFilters[indexPath.row]
        cell.configureView(name: filter.rawValue, image: inputImage, size: canvas.size)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return [140,180]
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let name = filters[indexPath.row]//filterEngine.availableFilters[indexPath.row]
        if let image = filterEngine.imageFor(name.rawValue){
            imageView.image = image
            //imageView.contentMode =
        }else{
            imageView.contentMode = .scaleAspectFit
            //imageView.image = inputImage
        }
    }
}
