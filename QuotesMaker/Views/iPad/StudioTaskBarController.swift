//
//  StudioTaskBarController.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 05/04/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class StudioTaskBarController: UIViewController {
    
    
    @IBOutlet weak var textControl: ControlProxy!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    class func onlyInstance()->StudioTaskBarController{
        let storyboard = UIStoryboard(name: "iPadMain", bundle: .main)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "\(StudioTaskBarController.self)") as? StudioTaskBarController else {fatalError("Could not cast StudioTaskBar")}
        return vc
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func addText(_ sender: ControlProxy) {
        
    }
    @IBAction func addImage(_ sender: ControlProxy) {
        
    }
    @IBAction func addShape(_ sender: ControlProxy) {
        
    }
    @IBAction func addFilter(_ sender: ControlProxy) {
        
    }
    @IBAction func preview(_ sender: ControlProxy) {
        
    }
    @IBAction func save(_ sender: ControlProxy) {
        
    }
    @IBAction func thrash(_ sender: ControlProxy) {
        
    }
    @IBAction func moveUp(_ sender: ControlProxy) {
        
    }
    
    @IBAction func moveDown(_ sender: ControlProxy) {
        
    }
    
    @IBAction func showLayers(_ sender: ControlProxy) {
        
    }
    
}
