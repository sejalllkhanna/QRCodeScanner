//
//  RecentsCell.swift
//  QRCodeScanner
//
//  Created by Sejal Khanna on 31/08/21.
//

import Foundation
import UIKit

class RecentsCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var suggestedContact = [SuggestedContact]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.getUserDetails()
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.delegate =  self
        collectionView.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return suggestedContact.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.userData(userData: suggestedContact[indexPath.row])
        return cell
    }
    
    
    func getUserDetails(){
        self.showBlurLoader()
        let url = URL(string: "https://dev.onebanc.ai/UIServices/upi.asmx/getSuggestedContacts?customerId=1234567")
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print("error while fetching data ")
                DispatchQueue.main.async {
                    self.removeBluerLoader()
                }
                return
            }
            if let uData = data {
                let decoder = JSONDecoder()
                do {
                    let userData = try decoder.decode(Welcome.self, from: uData)
                    print(userData)
                    self.suggestedContact = userData.suggestedContacts
                    DispatchQueue.main.async{
                        self.collectionView.reloadData()
                        self.removeBluerLoader()
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.removeBluerLoader()
                    }
                    print("error")
                }
            }
        }
        task.resume()
    }
}

