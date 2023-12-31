//
//  ViewController.swift
//  HomeWorkIOS
//
//  Created by Герман Яренко on 22.11.23.
//51805360

import UIKit
import WebKit

class ViewController: UIViewController {
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView(frame: view.bounds)
        webView.navigationDelegate = self
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://oauth.vk.com/authorize?client_id=51797989&redirect_uri=https://oauth.vk.com/blank.html&display=mobile&scope=262150&response_type=token")
        webView.load(URLRequest(url: url!))
        
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(webView)
    }
    
    private func tap() {
        
        let tabFriends = UINavigationController(rootViewController: FriendsViewController())
        tabFriends.tabBarItem.title = "Friends"
        
        let tabGroups = UINavigationController(rootViewController: GroupsViewController())
        tabGroups.tabBarItem.title = "Groups"
        
        let tabPhotos = UINavigationController(rootViewController: PhotosViewController(
            collectionViewLayout: UICollectionViewFlowLayout()))
        tabPhotos.tabBarItem.title = "Photos"
        
        let tabs = [tabFriends, tabGroups, tabPhotos]
        
        let tabController = UITabBarController()
        tabController.viewControllers = tabs
        
        func goTabController() {
            navigationController?.pushViewController(tabController, animated: true)
            navigationController?.isNavigationBarHidden = true
        }
        goTabController()
    }
    
}


extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        let params = fragment.components(separatedBy: "&").map { $0.components(separatedBy: "=" ) }.reduce([String: String]()) { result, param in
            var dict = result
            let key = param[0]
            let value = param[1]
            dict[key] = value
            return dict
        }
        NetworkService.token = params["access_token"]!
//        print(NetworkService.token)
        //        NetworkService.userID = params["user_id"]!
        decisionHandler(.cancel)
        webView.removeFromSuperview()
        tap()
    }
    
}
