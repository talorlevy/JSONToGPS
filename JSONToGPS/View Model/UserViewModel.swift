//
//  UserViewModel.swift
//  JSONToGPS
//
//  Created by Talor Levy on 2/17/23.
//

import Foundation

class UserViewModel {
    
    var usersArray: [UserModel] = []
    
    func fetchUsersData(completion: @escaping() -> Void) {
        NetworkManager.sharedInstance.fetchData(urlString: Constant.url.users.rawValue) {  [weak self] (result: Result<[UserModel], Error>) in
            switch result {
            case .success(let users):
                self?.usersArray = users
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
