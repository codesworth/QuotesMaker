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
    @IBOutlet weak var textStack: UIStackView!
    @IBOutlet weak var fillControl: ControlProxy!
    @IBOutlet weak var gradientcontrol: ControlProxy!
    @IBOutlet weak var imagecontrol: ControlProxy!
    @IBOutlet weak var stylecontrol: ControlProxy!
    @IBOutlet weak var textcontrol: ControlProxy!

    @IBOutlet weak var parentStack: UIStackView!
    @IBOutlet weak var container: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func fillTapped(_ sender: ControlProxy) {
    }
    
    @IBAction func gradientTapped(_ sender: ControlProxy) {
    }
    
    @IBAction func imageTapped(_ sender: ControlProxy) {
    }
    
    @IBAction func styleTapped(_ sender: ControlProxy) {
    }
    
    @IBAction func textTapped(_ sender: ControlProxy) {
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



