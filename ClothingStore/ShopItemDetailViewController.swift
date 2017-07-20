//
//  ShopItemDetailViewController.swift
//  ClothingStore
//
//  Created by James Walsh on 7/20/17.
//  Copyright © 2017 New York University. All rights reserved.
//

import Foundation
import UIKit

class ShopItemDetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    
    var shopItem: ShopItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        // Do any additional setup after loading the view.
    }
    
    func updateUI() {
        titleLabel.text = shopItem.name
        priceLabel.text = String(format: "$%.2f", shopItem.price)
        descriptionLabel.text = shopItem.description
        addToCartButton.layer.cornerRadius = 5.0
        MenuController.shared.fetchImage(url: shopItem.imageURL) {
            (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    /*
     override func didReceiveMemoryWarning() {
     super.didReceiveMemoryWarning()
     // Dispose of any resources that can be recreated.
     }
     
     
     
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
