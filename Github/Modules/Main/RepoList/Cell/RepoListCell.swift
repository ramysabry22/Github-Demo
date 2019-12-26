//
//  RepoListCell.swift
//  Github
//
//  Created by Ramy Ayman Sabry on 12/25/19.
//  Copyright © 2019 Ramy Ayman Sabry. All rights reserved.
//

import UIKit

class RepoListCell: UITableViewCell, RepoListCellView {

    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var repoOwnerNameLabel: UILabel!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    
    
    func displayData(repoName: String, repoOwnerName: String, repoDescription: String, profileImageStringURl: String?, stringBackgroundColor: String)
    {
        repoNameLabel.text = repoName
        repoOwnerNameLabel.text = repoOwnerName
        descriptionTextView.text = repoDescription
        backgroundColor = UIColor(hexString: stringBackgroundColor)
        
        if profileImageStringURl != nil
        {
            guard let url = URL(string: profileImageStringURl!) else { return }
            userImage.kf.indicatorType = .activity
            userImage.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { (result) in
                switch result {
                case .success(let image):
                    self.userImage.image = image.image
                case .failure(_):
                    self.userImage.image = UIImage(named: "UserProfileICON")?.imageFlippedForRightToLeftLayoutDirection()
                    return
                }
            }
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
