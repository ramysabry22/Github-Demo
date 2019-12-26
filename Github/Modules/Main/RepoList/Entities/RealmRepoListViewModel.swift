
import Foundation
import RealmSwift


open class RealmRepoListViewModel: Object
{
    @objc dynamic var name: String = ""
    @objc dynamic var repoDescription: String = ""
    @objc dynamic var backgroundColor: String = ""
    @objc dynamic var htmlStringURL: String = ""
    @objc dynamic var owner: RealmOwnerViewModel? = nil
    
    convenience init(RepoModel: RepoListModel)
    {
        self.init()
        self.name = RepoModel.full_name
        self.repoDescription = RepoModel.description
        self.owner = RealmOwnerViewModel(ownerModel: RepoModel.owner)
        self.htmlStringURL = RepoModel.html_url
        
        if RepoModel.fork == nil || RepoModel.fork == false {
            self.backgroundColor = "CCFFC8"
        }
        else {
            self.backgroundColor = "ffffff"
        }
    }
}


open class RealmOwnerViewModel: Object
{
    @objc dynamic var ownerName: String = ""
    @objc dynamic var avatarImageStringURL: String = ""
    @objc dynamic var htmlStringURL: String = ""
    
    convenience init(ownerModel: OwnerModel)
    {
        self.init()
        self.ownerName = ownerModel.login
        self.avatarImageStringURL = ownerModel.avatar_url
        self.htmlStringURL = ownerModel.html_url
    }
}
