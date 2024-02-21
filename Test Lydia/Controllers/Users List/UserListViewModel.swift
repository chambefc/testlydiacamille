//
//  UsersListViewModel.swift
//  Test Lydia
//
//  Created by Camille Chambefort on 18/02/2024.
//

import UIKit
import Combine

// UsersListViewController's ViewModel
final class UserListViewModel {

    // MARK: - Published
    @Published var users = [User]()
    @Published var error: String?
    @Published var isLoading = false

    // MARK: - Public
    public let title = "USERS_LIST_TITLE".localized()

    // MARK: - Private
    // Prevents the ViewModel from fetching more data while a call is still currently being fetched

    private let repository: UserRepositoryType

    init(repository: UserRepositoryType) {
        self.repository = repository
    }

    // UIViewController Lifecycle
    func viewDidLoad() async {
        await getUsers(fromStart: true)
    }

    // Fetches 10 more users (could also be the initializing call)
    func getUsers(fromStart: Bool = false) async {
        isLoading = true
        do {
            if fromStart {
                self.users.removeAll()
            }
            let newUsers = try await repository
                .getUsers(
                    limit: 10,
                    fromStart: fromStart
                )
                .filter({ !self.users.contains($0) })
            self.users.append(contentsOf: newUsers)
        } catch {
            self.error = "NETWORK_ERROR_UNAVAILABLE_SERVICE".localized()
        }
        self.isLoading = false
    }
    
    // Checks if the Controller actually needs more results to display
    func loadMoreIfNeeded(scrollView: UIScrollView) async {
        if isLoading || !ReachabilityManager.shared.isNetworkReachable {
            return
        }
        let offsetY = await scrollView.contentOffset.y
        let contentHeight = await scrollView.contentSize.height
        
        if await offsetY > contentHeight - scrollView.frame.size.height {
            await getUsers()
        }
    }

    func refreshList() async {
        if !ReachabilityManager.shared.isNetworkReachable {
            isLoading = false
            return
        }
        await getUsers(fromStart: true)
    }

    // Returns the selected indexPath's user for display
    func user(for indexPath: IndexPath) -> User {
        return self.users[indexPath.row]
    }

}
