
import UIKit


extension RepoListViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return presenter?.getRowsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: GithubViews.Cells.RepoListCell, for: indexPath) as! RepoListCell
        
        presenter?.configureRepoListCell(cell: cell, sectionIndex: indexPath.section, rowIndex: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath])
    {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.3) {
            self.presenter?.paginateFetchingRepoData(currentIndex: indexPaths.last?.row ?? 0)
        }
    }

    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        let editAction = UITableViewRowAction(style: .default, title: "View Details", handler: { (action, indexPath) in
            
            self.presenter?.selectedRepoForDetails(section: indexPath.section, row: indexPath.row)
        })
        
        editAction.backgroundColor = UIColor.blue
        return [editAction]
    }
    
    
    
    
}
