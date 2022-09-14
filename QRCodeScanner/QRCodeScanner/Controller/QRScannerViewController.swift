//
//  QRScannerViewController.swift
//  QRCodeScanner
//
//  Created by Sejal Khanna on 21/08/21.
//

import UIKit
import AVFoundation

class QRScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    var companyDataArray = [SuggestedTransactionModel?]()
    var companiesTransactions = [Transaction]()
    var suggestedContact = [SuggestedContact]()
    
    var name = ""
    var amount = ""
    var currency = ""
    
    var qrcode = UIView()
    
    let imagePicker = UIImagePickerController()
    let loaderAnimation = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height:40))
    
    @IBOutlet weak var ScannerLineWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var scannerLine: UIView!
    @IBOutlet weak var ScannerLineTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var uploadImageView: UIImageView!
    @IBOutlet weak var scannerView: QRScannerViewReader! {
        didSet {
            scannerView.delegate = self
        }
    }
    
    //    MARK:- LifeCycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getTransaction()
        self.view.showBlurLoader()
        
        self.loadingAnimation()
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        qrcode.layer.borderColor = UIColor.blue.cgColor
        
        // tableView Delegates
        tableView.delegate = self
        tableView.dataSource = self
        
        // register cell
        let nib = UINib(nibName: "PaymentCell", bundle: nil)
        let nib1 = UINib(nibName: "RecentsCell", bundle: nil)
        
        self.tableView.register(nib, forCellReuseIdentifier: "PaymentCell")
        self.tableView.register(nib1, forCellReuseIdentifier: "RecentsCell")
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        
        let tempImageView = UIImageView(image: UIImage(named: "TableView Background")!.alpha(0.5))
        tempImageView.frame = self.tableView.frame
        self.tableView.backgroundView = tempImageView;
        tempImageView.contentMode = .scaleAspectFill
        
        let label = UILabel()
        label.textAlignment = .center
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 46)
        counterLabel = label
    }
    override func viewWillLayoutSubviews() {
        ScannerLineWidthConstraint.constant = view.frame.width*0.50 - 5
        self.gradientView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !scannerView.isRunning {
            scannerView.startScanning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if !scannerView.isRunning {
            scannerView.stopScanning()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    @IBAction func loadImageButtonTapped(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
        uploadImageView.image = image
    }
    // MARK: - Animations
    
    func loadingAnimation(){
        
        if ScannerLineTopConstraint.constant == scannerView.frame.height*0.25{
            UIView.animate(withDuration: 1) { [self] in
                ScannerLineTopConstraint.constant =  scannerView.frame.height*0.75 - scannerLine.frame.height
                self.view.layoutIfNeeded()
            } completion: { _ in
                self.loadingAnimation()
            }
        } else {
            UIView.animate(withDuration: 1) { [self] in
                ScannerLineTopConstraint.constant = scannerView.frame.height*0.25
                self.view.layoutIfNeeded()
            } completion: { _ in
                self.loadingAnimation()
            }
        }
    }
    
    func gradientView(){
        let gradient = CAGradientLayer()
        gradient.frame = scannerLine.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.systemBlue.cgColor]
        scannerLine.layer.insertSublayer(gradient, at: 0)
    }
    
    // MARK:- Flash Mode
    func flashButton() {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        guard device.hasTorch else { return }
        do {
            try device.lockForConfiguration()
            if (device.torchMode == AVCaptureDevice.TorchMode.on) {
                device.torchMode = AVCaptureDevice.TorchMode.off
            } else {
                do {
                    try device.setTorchModeOn(level: 1.0)
                } catch {
                    print(error)
                }
            }
            device.unlockForConfiguration()
        } catch {
            print(error)
        }
    }
    
    @IBAction func flashButtonPressed(_ sender: Any) {
        flashButton()
    }
}
// MARK:- Extensions

extension QRScannerViewController: QRScannerViewDelegate {
    func qrScanningDidFail() {
        print("Scanning Failed")
    }
    // Mark - Scanner delegate methods
    func cameraView() -> UIView
    {
        return self.view
    }
    
    func delegateViewController() -> UIViewController
    {
        return self
    }
    
    func scanCompleted(withCode code: String)
    {
        print(code)
    }
    
    func qrScanningDidStop() {
    }
    
    func qrScanningSucceededWithCode(_ str: String?){
        let url = URL(string: "upi://pay?pa=dhruvmangal007@okhdfcbank&pn=Dhruv%20Mangal&am=2467.49&cu=INR&aid=uGICAgICevMWHYg")
        
        name = (url?.queryParameters?["pa"])!
        amount =  (url?.queryParameters?["am"])!
        currency = (url?.queryParameters?["cu"])!
        
        MoveToNextScreen()
        
        print("url")
        print("QRCode scanned")
    }
    
    func MoveToNextScreen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyBoard.instantiateViewController(withIdentifier: "PopUpViewController") as! PopUpViewController
        
        destinationVC.Name = name
        destinationVC.Amount = amount
        destinationVC.Currency = currency
        destinationVC.modalPresentationStyle = .fullScreen
        destinationVC.modalTransitionStyle = .flipHorizontal
        
        self.present(destinationVC, animated: true, completion: nil)
    }
}


// MARK:- TableView Functions
extension QRScannerViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if companiesTransactions.count >= 2{
                return 2
            }else{
                return companiesTransactions.count
            }
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentCell", for: indexPath) as! PaymentCell
            cell.setData(data: self.companiesTransactions[indexPath.row])
            cell.selectionStyle = .none
            
            return cell
        }else{
            let rcell = tableView.dequeueReusableCell(withIdentifier: "RecentsCell", for: indexPath) as! RecentsCell
            rcell.selectionStyle = .none
            return rcell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 2
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat{
        if indexPath.section == 0 {
            return CGFloat(80)
        }else {
            return CGFloat(150)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                   section: Int) -> String? {
        if section == 0{
            return "Suggested"
        }else {
            return "Recent"
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as? UITableViewHeaderFooterView
        header?.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        header?.textLabel?.textColor = .white
        header!.textLabel!.text = "\(header!.textLabel!.text!.capitalizingFirstLetter())"
    }
}
