
import UIKit

class TwoButtonAlertController: UIViewController {
    
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var msgTextView: UITextView!
    @IBOutlet weak var CancelButton: UIButton!
    @IBOutlet weak var OkButton: UIButton!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    var alertTitle: String = ""
    var alertMessage: String = ""
    var alertCancelButtonTitle: String = "Cancel"
    var alertDefualtButtonTitle: String = "OK"
    var buttonAction: ((_ defualt: Bool) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareData()
    }
    override func viewWillAppear(_ animated: Bool) {
        animateView()
    }
    func prepareData(){
        CancelButton.setTitle(self.alertCancelButtonTitle, for: .normal)
        CancelButton.layer.borderWidth = 1
        CancelButton.layer.borderColor = UIColor(named: "Dark-Green")!.cgColor
        OkButton.setTitle(self.alertDefualtButtonTitle, for: .normal)
        titleLabel.text = self.alertTitle
        msgTextView.text = self.alertMessage
        let alertHeight = StringSize.estimateFrameForTitleText(self.alertMessage, width: 240, height: 1000, fontSize: 16).height + 150
        heightConstraint.constant = alertHeight
        self.view.layoutIfNeeded()
    }
    func animateView() {
        alertView.alpha = 0
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + 40
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.alertView.alpha = 1.0
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 40
        })
    }
    @IBAction func CancelButtonAction(_ sender: UIButton) {
        self.buttonAction?(false)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func OkButtonAction(_ sender: UIButton) {
        self.buttonAction?(true)
        self.dismiss(animated: true, completion: nil)
    }
    
}
