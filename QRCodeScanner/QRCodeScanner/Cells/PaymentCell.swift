//
//  PaymentCell.swift
//  QRCodeScanner
//
//  Created by Sejal Khanna on 31/08/21.
//

import Foundation
import UIKit

class PaymentCell: UITableViewCell {
    
    @IBOutlet weak var iconImage:UIImageView!
    @IBOutlet weak var providerlbl:UILabel!
    @IBOutlet weak var amountPaid:UILabel!
    @IBOutlet weak var balancelbl:UILabel!
    @IBOutlet weak var companyIconView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        companyIconView.layer.cornerRadius = companyIconView.frame.width/2
//        companyIconView.layer.borderColor = UIColor.gray.cgColor
        companyIconView.layer.borderWidth = 0.5
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(data: Transaction){
        providerlbl.text = data.name
        amountPaid.text = "$\(String(data.amount))"
        balancelbl.text = "$\(String(data.cashback))"
        iconImage.imagFromServerURL(urlString: "https://dev.onebanc.ai/getpicture/\(data.pictureid)", PlaceHolderImage: #imageLiteral(resourceName: "Screenshot 2021-08-26 at 3.38.13 PM"))
    }
}


