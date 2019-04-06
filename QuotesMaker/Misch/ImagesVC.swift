//
//  ImagesVC.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 27/02/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit
import SafariServices

class ImagesVC: UIViewController {
    

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var baseView: UIImageView!
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
    
    func lauchWebView(){
        
        guard let url = URL(string: "https://jberkey78.github.io/floq-beta") else{return}
        let controller:SFSafariViewController
        if #available(iOS 11.0, *) {
            let config = SFSafariViewController.Configuration()
            config.barCollapsingEnabled = true
            config.entersReaderIfAvailable = true
            controller = SFSafariViewController(url: url, configuration: config)
        } else {
            // Fallback on earlier versions
            controller = SFSafariViewController(url: url)
        }
        
        if #available(iOS 10.0, *) {
            controller.preferredControlTintColor = .white
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 10.0, *) {
            controller.preferredBarTintColor = .seafoamBlue
        } else {
            // Fallback on earlier versions
        }
        present(controller, animated: true, completion: nil)
        //        if UIApplication.shared.canOpenURL(url){
        //            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        //        }
    }

    @IBAction func addImageButt(_ sender: Any) {
        //makeImaheFromView()
        switch operationIndex {
        case 0:
            //imageTapped()
            lauchWebView()
            break
//        case 1:
//            filterLayer = CALayer()
//            filterLayer.frame = baseView.bounds
//            baseView.layer.addSublayer(filterLayer)
//            filterLayer.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 0.4).cgColor
//            break
//        case 2:
//            textlayer = CATextLayer()
//            textlayer.frame = baseView.bounds
//            textlayer.alignmentMode = .center
//            textlayer.string = NSAttributedString(string: "Hello Warpi Image", attributes: [.font : UIFont.systemFont(ofSize: 20, weight: .bold),.foregroundColor:UIColor.red.cgColor])
//            baseView.layer.addSublayer(textlayer)
//            break
        default:
            turnLayerIntoImage()
            break
        }
         //operationIndex += 1
    }
    
    func turnLayerIntoImage(){
        let layer = baseView.layer
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(size: baseView.bounds.size)
            DispatchQueue.main.async {
                let image = renderer.image { (context) in
                    layer.render(in: context.cgContext)
                }
                self.imageView.image = image
                print("Image Orientation is:\(image.imageOrientation)")
            }
        } else {
            // Fallback on earlier versions
        }
        
        
        
    }
    
    func makeImaheFromView(){
        UIGraphicsBeginImageContextWithOptions(baseView.bounds.size, baseView.isOpaque, UIScreen.main.scale)
        baseView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        imageView.image = image
    }
}



extension ImagesVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
//            imageLayer = CALayer()
//            imageLayer.frame = baseView.bounds
//            baseView.layer.addSublayer(imageLayer)
//            imageLayer.contents = image.cgImage
//            imageLayer.masksToBounds = true
//            print("Image Orientation is:\(image.imageOrientation)")
            baseView.image = image
            generateLow(image: image)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func generateLow(image:UIImage){
        print("Original image size is: \(image.jpegData(compressionQuality: 1))")
        
        let elysium = Elysium(source: image)
        if let finalImage = elysium.makeScaledImage(.average){
           print("New image size is: \(finalImage.jpegData(compressionQuality: 1))")
            imageView.image = finalImage
        }else{
            print("Error geerating image")
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
