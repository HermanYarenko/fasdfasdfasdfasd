//
//  FriendsViewController.swift
//  HomeWorkIOS
//
//  Created by Герман Яренко on 22.11.23.


import UIKit

final class FriendsViewController: UITableViewController {
    
    private var friends = [Friend]()
    private var dataService = DataService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Friends"
        
        friends = dataService.getFriends()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: #selector(goToProfileViewController))
        
        tableView.register(FriendCell.self, forCellReuseIdentifier: Constants.Identifier.photoCellIdentifier)
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(updateList), for: .valueChanged)
        
        getFriends()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        updateColor()
        tableView.reloadData()
    }
    
    private func updateColor() {
        tableView.backgroundColor = Theme.currentTheme.backroundColor
        navigationController?.navigationBar.tintColor = Theme.currentTheme.textColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Theme.currentTheme.textColor]
        navigationController?.tabBarItem.setTitleTextAttributes([.foregroundColor: Theme.currentTheme.textColor as UIColor], for: .normal)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifier.photoCellIdentifier, for: indexPath) as? FriendCell else { return UITableViewCell()
        }
        cell.updateCell(model: friends[indexPath.row])
        cell.tap = { [weak self] fullName, photo in
            self?.navigationController?.pushViewController(ProfileViewController(isUserProfile: false, photo: photo, fullName: fullName), animated: true)
        }
        cell.backgroundColor = .clear
        return cell
    }
    
    func getFriends() {
        NetworkService().getFriends{ [weak self] result in
            switch result {
                case .success(let friends):
                    self?.friends = friends
                    self?.dataService.addFriends(friends: friends)
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .failure(_):
                    self?.friends = self?.dataService.getFriends() ?? []
                    DispatchQueue.main.async {
                        self?.showAlert()
                    }
            }
        }
    }
}


private extension FriendsViewController {
    func showAlert() {
//        let date = DateConverter.dateConvert(date: dataService.getFriendDate())
        let date = "oldDate (temp)"
        let alert  = UIAlertController(title: "Failed to retrieve data", message: "Data is current as of \(date)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default))
        present(alert, animated: true)
    }
    
    @objc func goToProfileViewController() {
        let animation = CATransition()
        animation.type = .fade
        animation.duration = 0.5
        navigationController?.view.layer.add(animation, forKey: nil)
        navigationController?.pushViewController(ProfileViewController(isUserProfile: true), animated: false)
    }
    
    @objc func updateList() {
        NetworkService().getFriends { [weak self] result in
            switch result {
                case .success(let friends):
                    self?.friends = friends
                    self?.dataService.addFriends(friends: friends)
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .failure(_):
                    self?.friends = self?.dataService.getFriends() ?? []
                    DispatchQueue.main.async {
                        self?.showAlert()
                    }
            }
            DispatchQueue.main.async {
                self?.refreshControl?.endRefreshing()
            }
        }
    }
}
