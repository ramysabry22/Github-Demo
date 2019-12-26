

import UIKit


class RepoListRouter: RepoListRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController
    {
        let storyboard = UIStoryboard(name: GithubViews.StoryBoards.main, bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: GithubViews.ViewControllers.RepoList) as! RepoListViewController
        let interactor = RepoListInteractor()
        let router = RepoListRouter()
        let presenter = RepoListPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
    
    
    
    
}
