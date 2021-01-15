//
//  MainTableViewController.swift
//  Swift5Realm
//
//  Created by Nir Leshem on 09/01/2021.
//

import UIKit
import RealmSwift
import Combine

class MainTableViewController: UITableViewController {

    enum Section {
        case main
    }

    //MARK: Data Source
    lazy var dataSource = UITableViewDiffableDataSource<Section, RealmUser>(tableView: tableView, cellProvider: { (tableView, indexPath, model) -> UITableViewCell? in
        if var cell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
            cell.textLabel?.text = self.realmUsers[indexPath.row].name
            cell.detailTextLabel?.text = self.realmUsers[indexPath.row].email
            return cell
        }
        return UITableViewCell()
    })
    
    var cancelablle: AnyCancellable?
    
    var realmUsers: Results<RealmUser>!
    
    var notificationToken: NotificationToken?
    
    var realm: Realm {
        return RealmService.shared.realm
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Diffable"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = dataSource
        tableView.delegate = self
        
        // also add filter of some soft.
        realmUsers = RealmService.shared.getAllRealmUsers()
        if realmUsers.count > 0 {
            updateSnapshot(users: Array(realmUsers))
        } else {
            getAPIUsers()
        }
        
        //Not working?
//        notificationToken = realm.observe({ [weak self] (notification, realm) in
//            print("zzz notificationToken OBSERVED!")
//            self?.tableView.reloadData()
//        })
        
        //Used to find the Finder location to see Realm Objects via Realm Studio.
//        print("zzz fileURL: \(Realm.Configuration.defaultConfiguration.fileURL)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        notificationToken?.invalidate()
    }
    
    //MARK: Update Snapshot
    func updateSnapshot(users: [RealmUser]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, RealmUser>()
        snapshot.appendSections([.main])
        snapshot.appendItems(users)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    //MARK: Get Users
    func getAPIUsers() {
//        cancelablle = NetworkingService.shared.getUsers()
<<<<<<< HEAD
//            .sink(receiveCompletion: { _ in }, receiveValue: { users in
//                users.forEach({
//                    let realmObject: RealmUser = .init($0)
//                    RealmService.shared.create(realmObject)
//                })
//                self.fetchAllRealmUsersAndUpdateSnapshot()
//            })
            
        
=======
//            .catch { _ in Just(APIUsersResponse.returnEmpty()) }
//            .map { $0.users }
//            .map { users in
//                users.forEach({
//                    let realmObject: RealmUser = .init($0)
//                    RealmService.shared.create(realmObject)
//                    print("zzz realmObject \(realmObject.name)")
//                })
//            }
            
            
>>>>>>> f42c770d6212e1533ea2b66f3448d1d0c26b4cec
        NetworkingService.shared.getUsers { result in
            switch result {
            case .success(let users):
                users.forEach({
                    let realmObject: RealmUser = .init($0)
                    RealmService.shared.create(realmObject)
                })
                self.fetchAllRealmUsersAndUpdateSnapshot()
            case .failure(let error):
                print("zzz ERROR \(error)")
            }
        }
    }
    
    private func fetchAllRealmUsersAndUpdateSnapshot() {
        realmUsers = RealmService.shared.getAllRealmUsers()
        updateSnapshot(users: Array(realmUsers))
    }
}

// MARK: - Table view data source
extension MainTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        print("\(String(describing: item.name))")
    }
}
