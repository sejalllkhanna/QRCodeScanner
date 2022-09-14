//
//  CompanyManager.swift
//  QRCodeScanner
//
//  Created by Sejal Khanna on 28/08/21.
//

import Foundation
import  UIKit
extension QRScannerViewController {
    func getTransaction() {
        
        let url = URL(string: "https://dev.onebanc.ai/api/obapp.asmx/gettransaction?userId=1234567")
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print("Error while fetching data ")
                DispatchQueue.main.async {
                    self.view.removeBluerLoader()
                }
               
                return
            }
            if let tData = data {
                let decoder = JSONDecoder()
                do {
                    let transactionData = try decoder.decode(SuggestedTransactionModel.self, from: tData)
                    print(transactionData)
                    self.companiesTransactions = transactionData.transactions
                    DispatchQueue.main.async{
                        self.tableView.reloadData()
                        self.view.removeBluerLoader()
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.view.removeBluerLoader()
                    }
                    print("error")
                    return
                }
            }
        }
    task.resume()
    }
}
