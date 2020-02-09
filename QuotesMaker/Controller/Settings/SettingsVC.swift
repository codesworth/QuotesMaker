//
//  SettingsVC.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 23/12/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

class SettingsVC: UITableViewController {

    var settings = Settings()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    @objc func switchChanged(_ sender:UISwitch){
        
        if sender.tag == 1{
            self.settings.saveiCloudSupport(sender.isOn)
            if sender.isOn{
                Cloudstore.store.fetAvailableModel()
            }
        }else if sender.tag == 2{
            settings.saveProjectAlbumPhotos(sender.isOn)
        }
    }
    


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath)
            if let uiswitch = cell.viewWithTag(1) as? UISwitch{
                uiswitch.isEnabled = false
                uiswitch.isOn = false
                if Store.isPro(){
                    uiswitch.isEnabled = true
                    uiswitch.isOn = settings.icloudSupport
                }
                uiswitch.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
                
            }
            return cell
        }
        if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath)
            if let uiswitch = cell.viewWithTag(2) as? UISwitch{
                uiswitch.isOn = settings.projectAlbums
                uiswitch.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
            }
            return cell
        }
        return tableView.dequeueReusableCell(withIdentifier: "Cell3", for: indexPath)
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2{
            if Store.isPro(){
                let alert = UIAlertController(title: "Info", message: "You have already purchased Studio Pro", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
            let proAdd = UnlockProView(frame: .zero)
            proAdd.setDetail(string:"Upgrade to Studio Pro to enable saving projects and iCloud Support")
            proAdd.show()
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "DEVELOPED BY CODESWORTH"
    }

}
