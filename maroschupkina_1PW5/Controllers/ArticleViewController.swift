//
//  ViewController.swift
//  maroschupkina_1PW5
//
//  Created by Marina Roshchupkina on 09.11.2021.
//

import UIKit

class ArticleViewController: UIViewController{
    
    var articleManager: ArticleManager = ArticleManager()
    var tableView: UITableView!
    
    override func viewDidLoad() {
        
        //articleManager.loadNews()
        super.viewDidLoad()
        setupTableView()
        setupArticleManager()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    
    
    private func setupTableView() {
        let rect = CGRect(x: 0, y: 15, width: view.frame.width, height: view.frame.height)
        
        tableView = UITableView(frame: rect)
        
        tableView.register(ArticleCell.self, forCellReuseIdentifier: "articleCell")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundColor = UIColor.white
        tableView.rowHeight = 300
        tableView.showsVerticalScrollIndicator = true
        tableView.translatesAutoresizingMaskIntoConstraints = false //
        //tableView.layer.cornerRadius = 35
        tableView.separatorColor = .white
        tableView.layer.masksToBounds = true
        self.view.addSubview(tableView)
        self.title = "NEWS"
    }
    func setupArticleManager() {
        articleManager.observer = self
        DispatchQueue.global().async {
            self.articleManager.loadNews()
        }
    }
}
extension ArticleViewController: ArticleManagerObserver {
    func updateArticles() {
        DispatchQueue.main.sync {
            tableView?.reloadData()
        }
    }
}

extension ArticleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  articleManager.Articles.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
}
extension ArticleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ArticleCell()
        cell.titleLabel?.text = articleManager.Articles[indexPath.row].title
        cell.descriptionLabel?.text = articleManager.Articles[indexPath.row].announce
        DispatchQueue.global().async {
            let image = self.articleManager.Articles[indexPath.row].loadImage()
            DispatchQueue.main.sync {
                cell.setImage(image: image)
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == tableView.numberOfSections - 1 &&
            indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            articleManager.loadMore()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webView = WebViewController()
        webView.url = articleManager.Articles[indexPath.row].articleUrl
        self.navigationController?.pushViewController(webView, animated: true)
    }
    
    
    private func share(article: ArticleModel?) {
        let textToShare = article?.articleUrl?.absoluteString
        
        if let myWebsite = article?.articleUrl {
            let objectsToShare = [textToShare, myWebsite] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            activityVC.popoverPresentationController?.sourceView = tableView
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal,
                                        title: "share") { [weak self] (action, view, completionHandler) in
            self?.share(article: self?.articleManager.Articles[indexPath.row])
            completionHandler(true)
        }
        action.backgroundColor = .black
        action.image = UIImage(systemName: "arrowshape.turn.up.right")
        return UISwipeActionsConfiguration(actions: [action])
    }
}

