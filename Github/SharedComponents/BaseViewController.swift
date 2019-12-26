
import UIKit
import SVProgressHUD


class BaseViewController: UIViewController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuraSharedComponents()
       
    }
    
    
    
    func showLoadingIndicator(){
        SVProgressHUD.show()
    }
    
    func hideLoadingIndicator(){
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
    
    func showOneButtonAlert(title: String, message: String, buttonTitle: String, callback: @escaping () -> Void)
    {
        let storyboard = UIStoryboard(name: GithubViews.StoryBoards.alerts, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: GithubViews.ViewControllers.oneButtonAlert) as! OneButtonAlertController
        controller.alertTitle = title
        controller.alertMessage = message
        controller.alertCancelButtonTitle = buttonTitle
        controller.buttonAction = callback
        present(controller, animated: true, completion: nil)
    }

    func showTwoButtonAlert(title: String, message: String, cancelButtonTitle: String, defaultButtonTitle: String, callback: @escaping (_ defualt: Bool) -> ())
        {
            let storyboard = UIStoryboard(name: GithubViews.StoryBoards.alerts, bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: GithubViews.ViewControllers.twoButtonsAlert) as! TwoButtonAlertController
            controller.providesPresentationContextTransitionStyle = true
            controller.definesPresentationContext = true
            controller.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            controller.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            controller.alertTitle = title
            controller.alertMessage = message
            controller.alertCancelButtonTitle = cancelButtonTitle
            controller.alertDefualtButtonTitle = defaultButtonTitle
            controller.buttonAction = callback
            present(controller, animated: true, completion: nil)
        }
    
    
    func showActionSheetAlert(showInView: UIButton, message: String, defualtButtonTitle: String, optionalButtonTitle: String, ActionButton: @escaping (_ defualtTapped: Bool) -> Void)
    {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.actionSheet)
        
        alert.addAction(UIAlertAction(title: defualtButtonTitle, style: UIAlertAction.Style.cancel, handler: { (action) in
            ActionButton(true)
        }))
        
        alert.addAction(UIAlertAction(title: optionalButtonTitle, style: UIAlertAction.Style.default, handler: { (action) in
            ActionButton(false)
        }))
        
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = showInView
            popoverController.sourceRect = showInView.bounds
            
            self.present(alert, animated: true, completion: {
            })
            return
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    func configuraSharedComponents()
    {
        SVProgressHUD.setupView()
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.isNavigationBarHidden = false
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    
    
    
    func scheduleLocalNotification(title: String, subTitle: String, body: String, timeInterval: TimeInterval)
    {
        UNUserNotificationCenter.current().getNotificationSettings { (notificationSettings) in
            switch notificationSettings.authorizationStatus
            {
            case .notDetermined:
                print("Notification Permission notDetermined")
                break
                
            case .authorized:
                self.startLocalNotification(title: title, subTitle: subTitle, body: body, timeInterval: timeInterval)
                
            case .denied:
                print("Notification Permission denied")
                break
                
            case .provisional:
                print("Notification Permission provisional")
                break
                
            @unknown default:
                break
            }
        }
    }
    
    
    
    private func startLocalNotification(title: String, subTitle: String, body: String, timeInterval: TimeInterval)
    {
        // Create Notification Content
        let notificationContent = UNMutableNotificationContent()

        // Configure Notification Content
        notificationContent.title = "New Repositories Here!"
        notificationContent.body = "Check new repositories added today"

        // Add Trigger
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)

        // Create Notification Request
        let notificationRequest = UNNotificationRequest(identifier: "cocoacasts_local_notification", content: notificationContent, trigger: notificationTrigger)

        // Add Request to User Notification Center
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if let error = error {
                print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
            }
        }
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}


