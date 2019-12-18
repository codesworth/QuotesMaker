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
    var filters = Filters.availableFilters
    private let ctx = CIContext()
    
    lazy var imageView:UIImageView = {
        let imv = UIImageView(frame: .zero)
        imv.clipsToBounds = true
        imv.contentMode = .scaleAspectFit
        return imv
    }()
    
    
    var inputImage:UIImage!
    var optimImage:UIImage?
    var canvas:Canvas!
    @IBOutlet weak var imageContainerView: UIView!
    
    @IBOutlet weak var filterView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterEngine.purge()
        
        optimImageMake()
        imageView.image = inputImage
        if !__IS_IPAD{
            filterView.register(UINib(nibName: "FilterCell", bundle: nil), forCellWithReuseIdentifier: "\(FilterCollectionCell.self)")
        }
        filterView.delegate = self
        filterView.dataSource = self
        // Do any additional setup after loading the view.
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupImageView()
    }
    
    func optimImageMake(){
        optimImage = ImageProcess.main.resizeImage(inputImage, for: computeSizeForColletionCell())
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
    
    func computeSizeForColletionCell()->CGSize{
        if __IS_IPAD{
            return [140,180]
        }
        return [140]
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
        let image  = imageView.image
        let alert = UIActivityViewController(activityItems: [image as Any], applicationActivities: [])
        if __IS_IPAD{
            alert.modalPresentationStyle = .currentContext
            let presentation = alert.popoverPresentationController
            presentation?.permittedArrowDirections = .any
            presentation?.sourceView = sender
            presentation?.sourceRect = sender.frame
        }
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
        cell.containerView.backgroundColor = .clear
        cell.configureView(name: filter, image: inputImage, size: canvas.size,contentMode: .scaleAspectFill)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return computeSizeForColletionCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let name = filters[indexPath.row]//filterEngine.availableFilters[indexPath.row]
        if let image = filterEngine.applyFilter(name: name, image: inputImage){
            imageView.image = image
            //imageView.contentMode =
        }else{
            imageView.contentMode = .scaleAspectFit
            //imageView.image = inputImage
        }
    }
}
