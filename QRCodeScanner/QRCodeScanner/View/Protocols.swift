//
//  Protocols.swift
//  QRCodeScanner
//
//  Created by Sejal Khanna on 30/08/21.
//

import Foundation
import UIKit
protocol QRScannerViewDelegate: AnyObject {
    func qrScanningDidFail()
    func qrScanningSucceededWithCode(_ str: String?)
    func qrScanningDidStop()
    func cameraView() -> UIView
    func delegateViewController() -> UIViewController
    func scanCompleted(withCode code: String)
}
