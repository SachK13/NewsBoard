//
//  HomeViewController.swift
//  NewsBoard
//
//  Created by Sachin on 24/09/22.
//

import UIKit
import SafariServices

class HomeViewController: UIViewController {

    var viewModel = NewsListViewModel()
    
    private lazy var headerView: HeaderView = {
        let view = HeaderView(fontSize: 32)
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.tableFooterView = UIView(frame: .zero)
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: viewModel.reuseID)
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        setupView()
        fetchNews()
    }
    
    func fetchNews() {
        viewModel.getNews { _ in
            self.tableView.reloadData()
        }
    }
    
    func setupView() {
        view.addSubview(headerView)
        view.addSubview(tableView)
        setupConstraints()
    }
    
    func setupConstraints() {
        // HeaderView
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
        
        // TableView
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.reuseID) as? NewsTableViewCell
        let news = viewModel.newsVM[indexPath.row]
        cell?.newsVM = news
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = viewModel.newsVM[indexPath.row]
        guard let newsUrl = URL(string: news.url) else {
            return
        }
        
        let safariConfig = SFSafariViewController.Configuration()
        let safariViewController = SFSafariViewController(url: newsUrl, configuration: safariConfig)
        safariViewController.modalPresentationStyle = .fullScreen
        present(safariViewController, animated: true)
    }
    
}
