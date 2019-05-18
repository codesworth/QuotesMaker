//
//  StudioTaskBarController.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 05/04/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class StudioTaskBarController: UIViewController {
    
    
    @IBOutlet weak var contentViewWidth: NSLayoutConstraint!
    @IBOutlet weak var imageControl: ControlProxy!
    @IBOutlet weak var textControl: ControlProxy!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setContentWidth()
    }
    
    
    func setContentWidth(){
        let width = UIScreen.main.bounds.width
        contentViewWidth.constant = (width > 1150) ? width : 1150
    }
    
    
    class func onlyInstance()->StudioTaskBarController{
        let storyboard = UIStoryboard(name: "iPadMain", bundle: .main)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "\(StudioTaskBarController.self)") as? StudioTaskBarController else {fatalError("Could not cast StudioTaskBar")}
        return vc
    }
    
    var studio:iPadStudioVC?{
        guard let parent = parent as? iPadStudioVC else {return nil}
        return parent
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func backHome(_ sender: ControlProxy) {
       dismiss(animated: true, completion: nil)
    }
    @IBAction func addText(_ sender: ControlProxy) {
        studio?.coordinator.addText()
    }
    @IBAction func addImage(_ sender: ControlProxy) {
        studio?.coordinator.imageOptionSelected()
    }
    @IBAction func addShape(_ sender: ControlProxy) {
        studio?.coordinator.shapeSelected()
    }
    @IBAction func addFilter(_ sender: ControlProxy) {
        
    }
    @IBAction func preview(_ sender: ControlProxy) {
        guard let image  = studio?.coordinator.exportImage() else {return}
        if let vc = storyboard?.instantiateViewController(withIdentifier: "\(PreviewVC.self)") as? PreviewVC{
            vc.inputImage = image
            vc.canvas = studio?.canvas
            studio?.present(vc, animated: true, completion: nil)
        }
        
    }
    @IBAction func save(_ sender: ControlProxy) {
        studio?.coordinator.save()
    }
    @IBAction func thrash(_ sender: ControlProxy) {
        studio?.coordinator.deleteCurrent()
    }
    @IBAction func moveUp(_ sender: ControlProxy) {
        studio?.coordinator.moveSubiewForward()
    }
    
    @IBAction func moveDown(_ sender: ControlProxy) {
        studio?.coordinator.moveSubiewBackward()
    }
    
    @IBAction func showLayers(_ sender: ControlProxy) {
        studio?.layerStack.toggle()
    }
    
    @IBAction func exportItem(_ sender: ControlProxy) {
        guard let image  = studio?.coordinator.exportImage() else {return}
        let alert = UIActivityViewController(activityItems: [image], applicationActivities: [])
        alert.modalPresentationStyle = .currentContext
        let presentation = alert.popoverPresentationController
        presentation?.permittedArrowDirections = .any
        presentation?.sourceView = sender
        presentation?.sourceRect = sender.frame
        present(alert, animated: true){}
        
    }
    
    @IBAction func duplicateLayer(_ sender: ControlProxy) {
        studio?.coordinator.baseView.duplicateLayer()
    }
    
    @IBAction func undoPressed(_ sender: ControlProxy) {
        studio?.coordinator.stateUndo()
    }
    @IBAction func redoPressed(_ sender: ControlProxy) {
        studio?.coordinator.stateRedo()
    }
}
