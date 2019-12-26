//
//  RepoListModel.swift
//  Github
//
//  Created by Ramy Ayman Sabry on 12/25/19.
//  Copyright © 2019 Ramy Ayman Sabry. All rights reserved.
//

import Foundation


struct RepoListModel: Codable
{
    let id: Int
    let node_id, name, full_name: String
    let `private`: Bool
    let owner: OwnerModel
    let html_url: String
    let description: String
    let fork: Bool?
    let url, forks_url: String
    let keys_url, collaborators_url: String
    let teams_url, hooks_url: String
    let issue_events_url: String
    let events_url: String
    let labels_url, releases_url: String
    let deployments_url: String
    let created_at, updated_at, pushed_at: String
    let git_url, ssh_url: String
    let clone_url: String
    let svn_url: String
    let homepage: String?
    let size, stargazers_count, watchers_count: Int
    let language: String?
    let has_issues, has_projects, has_downloads, has_wiki: Bool
    let has_pages: Bool
    let forks_count: Int
    let archived, disabled: Bool
    let open_issues_count: Int
    let license: LicenseModel?
    let forks, open_issues, watchers: Int
    let default_branch: String
}

struct LicenseModel: Codable
{
    let key, name, spdx_id: String
    let url: String?
    let node_id: String?
}

struct OwnerModel: Codable
{
    let login: String
    let avatar_url: String
    let gravatar_id: String
    let url, html_url, followers_url: String
    let following_url, gists_url, starred_url: String
    let subscriptions_url, organizations_url, repos_url: String
    let events_url: String
    let received_events_url: String
    let type: String
    let site_admin: Bool
}
