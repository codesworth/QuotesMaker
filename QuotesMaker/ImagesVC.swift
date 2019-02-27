//
//  ImagesVC.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 27/02/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class ImagesVC: UIViewController {
    

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var baseView: UIView!
    var imageLayer:CALayer!
    var textlayer:CATextLayer!
    var filterLayer:CALayer!
    var operationIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func imageTapped(){
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func addImageButt(_ sender: Any) {
        switch operationIndex {
        case 0:
            imageTapped()
            break
        case 1:
            filterLayer = CALayer()
            filterLayer.frame = baseView.bounds
            baseView.layer.addSublayer(filterLayer)
            filterLayer.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 0.4).cgColor
            break
        case 2:
            textlayer = CATextLayer()
            textlayer.frame = baseView.bounds
            textlayer.alignmentMode = .center
            textlayer.string = NSAttributedString(string: "Hello Warpi Image", attributes: [.font : UIFont.systemFont(ofSize: 20, weight: .bold),.foregroundColor:UIColor.red.cgColor])
            baseView.layer.addSublayer(textlayer)
            break
        default:
            turnLayerIntoImage()
            break
        }
         operationIndex += 1
    }
    
    func turnLayerIntoImage(){
        let layer = baseView.layer
        let renderer = UIGraphicsImageRenderer(size: baseView.bounds.size)
        DispatchQueue.main.async {
            let image = renderer.image { (context) in
                layer.render(in: context.cgContext)
            }
            self.imageView.image = image
        }
        
        
    }
}



extension ImagesVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            imageLayer = CALayer()
            imageLayer.frame = baseView.bounds
            baseView.layer.addSublayer(imageLayer)
            imageLayer.contents = image.cgImage
            imageLayer.masksToBounds = true
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
