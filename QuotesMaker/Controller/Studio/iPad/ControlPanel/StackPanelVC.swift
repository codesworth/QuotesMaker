//
//  StackPanelVC.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 16/04/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class StackPanelVC: UIViewController {

    @IBOutlet weak var fillStack: UIStackView!
    @IBOutlet weak var gradientStack: UIStackView!
    @IBOutlet weak var imagetack: UIStackView!
    @IBOutlet weak var styleStack: UIStackView!
    @IBOutlet weak var stackHeight: NSLayoutConstraint!
    @IBOutlet weak var textStack: UIStackView!
    @IBOutlet weak var fillControl: ControlProxy!
    @IBOutlet weak var gradientcontrol: ControlProxy!
    @IBOutlet weak var imagecontrol: ControlProxy!
    @IBOutlet weak var stylecontrol: ControlProxy!
    @IBOutlet weak var textcontrol: ControlProxy!
    @IBOutlet weak var fillPanel:ColorSliderPanel!
    @IBOutlet weak var gradientPanel:GradientPanel!
    @IBOutlet weak var imagePanel:ImagePanel!
    @IBOutlet weak var stylePanel:StylingPanel!
    @IBOutlet weak var textPanel:TextDesignableInputView!

    @IBOutlet weak var parentStack: UIStackView!
    @IBOutlet weak var container: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientPanel.scrollView.isScrollEnabled = false
        imagePanel.scrollView.isScrollEnabled = false
        stylePanel.scrollView.isScrollEnabled = false
        textPanel.scrollView.isScrollEnabled = false
        fillControl.roundCorners(5)
        gradientcontrol.roundCorners(5)
        imagecontrol.roundCorners(5)
        stylePanel.roundCorners(5)
        textPanel.roundCorners(5)
        fillStack.isHidden = true
        fillPanel.isHidden = fillControl.panelHidden
        gradientPanel.isHidden = gradientcontrol.panelHidden
        gradientStack.isHidden = true
        imagetack.isHidden = true
        imagePanel.isHidden = imagecontrol.panelHidden
        styleStack.isHidden = stylecontrol.panelHidden
        stylePanel.isHidden = stylecontrol.panelHidden
        textStack.isHidden = true
        textPanel.isHidden = textcontrol.panelHidden
        // Do any additional setup after loading the view.
    }
    
    
    func panelForCurrent(_ type:ViewType, model:LayerModel){
        switch current {
        case <#pattern#>:
            <#code#>
        default:
            <#code#>
        }
    }
    
    func switchToShape(_ model:LayerModel){
        guard let model = model as? ShapeModel else {return}
        //Set Solid, Gradient && Style
        //First hide all unwanted
        imagetack.isHidden = true
        textStack.isHidden = true
        fillStack.isHidden = false
        gradientStack.isHidden = false
        styleStack.isHidden = false
        
    }
    
    
    @IBAction func fillTapped(_ sender: ControlProxy) {
        fillControl.panelHidden = !fillControl.panelHidden
        fillPanel.isHidden = fillControl.panelHidden
    }
    
    @IBAction func gradientTapped(_ sender: ControlProxy) {
        gradientcontrol.panelHidden = !fillControl.panelHidden
        gradientPanel.isHidden = gradientcontrol.panelHidden
    }
    
    
    
    @IBAction func imageTapped(_ sender: ControlProxy) {
        imagecontrol.panelHidden = !fillControl.panelHidden
        imagePanel.isHidden = imagecontrol.panelHidden
    }
    
    @IBAction func styleTapped(_ sender: ControlProxy) {
        stylecontrol.panelHidden = !stylecontrol.panelHidden
        stylePanel.isHidden = stylecontrol.panelHidden
    }
    
    @IBAction func textTapped(_ sender: ControlProxy) {
        textcontrol.panelHidden = !textcontrol.panelHidden
        stylePanel.isHidden = true
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



