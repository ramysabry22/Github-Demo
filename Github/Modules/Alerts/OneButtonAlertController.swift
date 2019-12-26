
import UIKit

class OneButtonAlertController: UIViewController {
    
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var OkButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var msgTextView: UITextView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    var alertTitle: String = ""
    var alertMessage: String = ""
    var alertCancelButtonTitle: String = "OK"
    var buttonAction: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        animateView()
    }
    func prepareData(){
        OkButton.setTitle(self.alertCancelButtonTitle, for: .normal)
        titleLabel.text = self.alertTitle
        msgTextView.text = self.alertMessage
        let alertHeight = StringSize.estimateFrameForTitleText(self.alertMessage, width: 240, height: 1000, fontSize: 16).height + 106
        heightConstraint.constant = alertHeight
        self.view.layoutIfNeeded()
    }
    
    @IBAction func OkButtonAction(_ sender: UIButton) {
        buttonAction?()
        self.dismiss(animated: true, completion: nil)
    }
    func animateView() {
        alertView.alpha = 0
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + 40
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.alertView.alpha = 1.0
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 40
        })
    }
    
}
