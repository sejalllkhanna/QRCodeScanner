//
//  CollectionViewCell.swift
//  QRCodeScanner
//
//  Created by Sejal Khanna on 31/08/21.
//

import Foundation
import UIKit

class CollectionViewCell: UICollectionViewCell{
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var profileUserName: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var recentView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        profilePicture.isHidden = false
        recentView.layer.cornerRadius = recentView.frame.height/2
        recentView.layer.borderWidth = 0.5
        recentView.layer.borderColor = UIColor.black.cgColor
        profileUserName.isHidden = true
        
    }
    func userData(userData: SuggestedContact){
        userName.text = userData.name
        if userData.pictureURL == ""{
            profileUserName.text = userData.name.getAcronyms(separator: "").uppercased()
            profileUserName.isHidden = false
            profilePicture.image = UIImage()
        } else {
            profilePicture.imageFromServerURL(urlString: "https://dev.onebanc.ai/images/\(userData.pictureURL)", PlaceHolderImage: #imageLiteral(resourceName: "Screenshot 2021-08-26 at 3.38.13 PM"))
            profileUserName.isHidden = true
        }
    }
}

