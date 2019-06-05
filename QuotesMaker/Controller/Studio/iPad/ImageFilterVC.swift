//
//  ImageFilterVC.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 25/05/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

protocol ImageFilterDelegate:class {
    func apply(_ filter:String)
    func donePressed()
}

class ImageFilterVC: UIViewController {
    
    private var image:UIImage!
    private var size:CGSize = .zero
    
    weak var delegate:ImageFilterDelegate?
    
    let filters = Filters.availableFilters
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        let view =  UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.register(UINib(nibName: "FilterCell", bundle: nil), forCellWithReuseIdentifier: "\(FilterCollectionCell.self)")
        return view
    }()
    
    lazy var navbar:UINavigationBar = {
        let bar  = UINavigationBar(frame: .zero)
        let item = UINavigationItem(title: "Filters")
        let rightButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissButtonPressed))
        item.rightBarButtonItem = rightButton
        bar.items = [item]
        return bar
    }()
    
    init(image:UIImage,size:CGSize) {
        self.image = image
        self.size = size
        super.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(navbar)
        navbar.layout{
            $0.top == view.topAnchor
            $0.leading == view.leadingAnchor
            $0.trailing == view.trailingAnchor
            $0.height |=| 60
        }
        
        view.addSubview(collectionView)
        collectionView.layout{
            $0.top == navbar.bottomAnchor + 8
            $0.leading == view.leadingAnchor + 8
            $0.trailing == view.trailingAnchor - 8
            $0.bottom == view.bottomAnchor - 8
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @objc func dismissButtonPressed(){
        if UIDevice.idiom == .phone{
            self.dismiss(animated: true, completion: nil)
        }else{
            self.removeFrom()
        }
        FilterEngine.globalInstance.purge()
        delegate?.donePressed()
    }
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension ImageFilterVC:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(FilterCollectionCell.self)", for: indexPath) as! FilterCollectionCell
        let filter = filters[indexPath.row]
        cell.borderlize(.black, 1)
        
        cell.configureView(name: filter, image: image, size: size,contentMode:.scaleAspectFill)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let inSize = (view.frame.width / 2) -
        //print("The size ids: \(inSize)")
        return [150,170]
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filter = filters[indexPath.row]
        //let image = FilterEngine.globalInstance.imageFor(filter.rawValue)
        delegate?.apply(filter)
    }
}
