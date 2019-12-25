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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning ("Incomplete implementation, return the number of rows")
        return 3
    }
    
    @objc func switchChanged(_ sender:UISwitch){
        
        if sender.tag == 1{
            self.settings.saveiCloudSupport(sender.isOn)
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
            let proAdd = UnlockProView(frame: .zero)
            proAdd.setDetail(string:"Upgrade to Studio Pro to enable saving projects and iCloud Support")
            proAdd.show()
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
