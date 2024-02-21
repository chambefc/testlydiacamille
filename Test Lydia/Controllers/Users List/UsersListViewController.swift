//
//  ViewController.swift
//  Test Lydia
//
//  Created by Camille Chambefort on 18/02/2024.
//

import UIKit
import Combine

private enum Constants {
    static let tableViewRowHeight: CGFloat = 108.0
}

/// Displays a list of all fetched users in a UITableView and loads more results when reaching the bottom of the TableView
final class UsersListViewController: UIViewController {
    
    // MARK: - UI Elements
    private var backgroundImageView: UIImageView!
    private var tableView: UITableView!
    private let refreshControl = UIRefreshControl()
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        return indicator
    }()

    // MARK: - Private properties
    private let viewModel: UserListViewModel
    private var subscriptions = Set<AnyCancellable>()
    private var dataSource: UITableViewDiffableDataSource<Int, User>!
    private var task: Task<Void, Error>?

    init(viewModel: UserListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
        prepareTableView()

        task = Task {
            await viewModel.viewDidLoad()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupSubscription()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        task?.cancel()
    }

    // Subscribes to changes on the viewModel's users property via Combine
    private func setupSubscription() {
        viewModel.$users
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] (users) in
                self?.createSnapshot(from: Array(users))
            })
            .store(in: &subscriptions)

        viewModel.$error
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard let error,
                      let view = self?.view else { return }
                NotificationBanner.display(text: error, in: view)
            }
            .store(in: &subscriptions)

        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                    self?.refreshControl.endRefreshing()
                }
            }
            .store(in: &subscriptions)
    }
    
    // Prepares tableView set up
    private func prepareTableView() {
        
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.reuseIdentifier)
        
        self.dataSource = UITableViewDiffableDataSource<Int, User>(tableView: self.tableView, cellProvider: { (tableView, indexPath, user) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.reuseIdentifier) as? UserTableViewCell
            cell?.setUser(user: user)
            return cell
        })
        
        tableView.dataSource = self.dataSource
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = Constants.tableViewRowHeight
        tableView.showsVerticalScrollIndicator = false
        tableView.refreshControl = refreshControl

        refreshControl.addTarget(self, action: #selector(refreshList), for: .valueChanged)
    }

    @objc
    func refreshList() {
        task = Task {
            await viewModel.refreshList()
        }
    }

    // Setting up all constraints and creating UI elements instances
    private func prepareUI() {
        
        self.title = viewModel.title
        
        self.navigationItem.rightBarButtonItem = .init(customView: activityIndicator)

        let backgroundImageView = UIImageView()
        backgroundImageView.image = Theme.Controller.backgroundImage
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false

        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
        ])
        self.tableView = tableView

        self.view.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: backgroundImageView, attribute: .top, relatedBy: .equal, toItem: self.tableView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: backgroundImageView, attribute: .bottom, relatedBy: .equal, toItem: self.tableView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: backgroundImageView, attribute: .leading, relatedBy: .equal, toItem: self.tableView, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: backgroundImageView, attribute: .trailing, relatedBy: .equal, toItem: self.tableView, attribute: .trailing, multiplier: 1, constant: 0)
        ])
        self.backgroundImageView = backgroundImageView
        // Allows to keep the collapse feature of the navigation bar
        backgroundImageView.layer.zPosition = tableView.layer.zPosition - 1

        self.view.layoutIfNeeded()
        
    }
    
    // Creates a Diffable snapshot and applies it to the datasource, updating the contents of the TableView
    private func createSnapshot(from users: [User]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, User>()
        
        snapshot.appendSections([0])
        snapshot.appendItems(users, toSection: 0)
        dataSource.apply(snapshot)
    }
    
}

extension UsersListViewController: UITableViewDelegate {
    
    // Sends the current state of the TableView's scroll to the viewmodel which could fetch more results if necessary
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        task = Task {
            await viewModel.loadMoreIfNeeded(scrollView: scrollView)
        }
    }
    
    // Displays the selected user's details in a UserDetailsViewController instance
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = viewModel.user(for: indexPath)
        let viewModel = UserDetailsViewModel(user: user)
        let vc = UserDetailsViewController()
        vc.viewModel = viewModel
        self.present(vc, animated: true, completion: nil)
    }
    
}
