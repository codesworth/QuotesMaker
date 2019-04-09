//
//  PickerNavController.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 09/04/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class PickerNavController: UINavigationController {
    
//    class func runProxy(){
//        let appearance = UINavigationBar
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photos"
        navigationBar.tintColor = .primary
        navigationBar.barStyle = .black
        navigationBar.barTintColor = .white
        self.navigationItem.leftBarButtonItem =  UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(removeSelf))
        // Do any additional setup after loading the view.
    }
    
    @objc func removeSelf(){
        guard let _ = parent else {return}
        removeFrom()
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
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
