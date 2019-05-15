//
//  PreviewVC.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 15/05/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class PreviewVC: UIViewController {

    var inputImage:UIImage?
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var filterView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = inputImage

        // Do any additional setup after loading the view.
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
    }
    
    @IBAction func saveToPhotos(_ sender: Any) {
    }
    
}
