

import Foundation

class SplashPresenter: SplashPresenterProtocol, SplashInteractorOutputProtocol {
    
    weak var view: SplashViewProtocol?
    private let interactor: SplashInteractorInputProtocol?
    private let router: SplashRouterProtocol?
    
    private var screenTimer: Timer?

    init(view: SplashViewProtocol, interactor: SplashInteractorInputProtocol, router: SplashRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    
    
    
    // MARK:- Timer
    //
    func startTimer()
    {
        screenTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (finished) in
            self.navigateToRepoList()
        })
    }
    
    
    
    // MARK:- Navigation
    private func navigateToRepoList()
    {
        router?.navigateToRepoListScreen()
    }
    
    
    
}
