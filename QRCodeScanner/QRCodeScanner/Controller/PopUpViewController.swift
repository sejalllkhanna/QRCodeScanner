//
//  PopUpViewController.swift
//  QRCodeScanner
//
//  Created by Sejal Khanna on 02/09/21.
//

import UIKit

class PopUpViewController: UIViewController {
    
    @IBAction func backButton(_ sender: Any) {
        //        self.navigationViewController.pop()
    }
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var currency: UILabel!
    
    var Name = ""
    var Amount = ""
    var Currency = ""
    
    override func viewDidLoad() {
        
        name.text = Name
        amount.text = Amount
        currency.text = Currency
        
    }
}
