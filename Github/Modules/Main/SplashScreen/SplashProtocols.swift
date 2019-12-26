
import Foundation


protocol SplashViewProtocol: class
{
    var presenter: SplashPresenterProtocol? { get set }
    
}

protocol SplashPresenterProtocol: class
{
    var view: SplashViewProtocol? { get set }
    func startTimer()
}




protocol SplashRouterProtocol
{
    func navigateToRepoListScreen()
}




protocol SplashInteractorInputProtocol
{
    var presenter: SplashInteractorOutputProtocol? { get set }
   
}

protocol SplashInteractorOutputProtocol: class
{
  
}

