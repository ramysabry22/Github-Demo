
import UIKit


class SplashRouter: SplashRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController
    {
        let storyboard = UIStoryboard(name: GithubViews.StoryBoards.main, bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: GithubViews.ViewControllers.splash) as! SplashViewController
        let interactor = SplashInteractor()
        let router = SplashRouter()
        let presenter = SplashPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
    
    
    func navigateToRepoListScreen()
    {
        let controller = RepoListRouter.createModule()
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.isNavigationBarHidden = false
        navigationController.modalPresentationStyle = .fullScreen
        viewController?.present(navigationController, animated: true, completion: nil)
    }
    
}
