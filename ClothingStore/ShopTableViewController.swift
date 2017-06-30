//
//  ShopTableViewController.swift
//  ClothingStore
//
//  Created by James Walsh on 6/29/17.
//  Copyright © 2017 New York University. All rights reserved.
//

import UIKit

class ShopTableViewController: UITableViewController {
    let menuController = MenuController()
    var shopItems = [ShopItem]()
    let category = "entrees"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Clothing"
        menuController.fetchMenuItems(categoryName: category)
        { (shopItems) in
            if let shopItems = shopItems {
                self.updateUI(with: shopItems)
            }
        }
    }

    func updateUI(with shopItems: [ShopItem]) {
        DispatchQueue.main.async {
            self.shopItems = shopItems
            self.tableView.reloadData()
        }
    }

/*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
*/
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(shopItems.count)
        return shopItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"MenuCellIdentifier", for: indexPath)
        configure(cell: cell, forItemAt: indexPath)
        return cell
    }
    
    func configure(cell: UITableViewCell, forItemAt indexPath:IndexPath) {
        let shopItem = shopItems[indexPath.row]
        cell.textLabel?.text = shopItem.name
        cell.detailTextLabel?.text = String(format: "$%.2f", shopItem.price)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShopDetailSegue" {
            let ShopItemDetailViewController = segue.destination
                as! ShopItemDetailViewController
            let index = tableView.indexPathForSelectedRow!.row
            ShopItemDetailViewController.shopItem = shopItems[index]
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
