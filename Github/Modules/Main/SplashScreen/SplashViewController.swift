

import UIKit

class SplashViewController: BaseViewController, SplashViewProtocol {
    
    var presenter: SplashPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.startTimer()
    }
    
    
}
