//
//  NetworkService.swift
//  HomeWorkIOS
//
//  Created by Герман Яренко on 22.11.23.
//


import Foundation

final class NetworkService {
    
    enum NetworkError: Error {
        case dataError
    }
    
    private let session = URLSession.shared
    
    static var token = ""
    //    static var userID = ""
    
    func getFriends(completion: @escaping (Result<[Friend], Error>) -> Void) {
        guard let url = URL(string: "https://api.vk.com/method/friends.get?access_token=\(NetworkService.token)&fields=photo_200_orig,online&v=5.199") else { return }
        
        session.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                completion(.failure(NetworkError.dataError))
                return
            }
            if let error = error {
                completion(.failure(error))
                return }
            do {
                let friends = try JSONDecoder().decode(FriendsModel.self, from: data).response.items
                completion(.success(friends))
            } catch { completion(.failure(error)) }
        }.resume()
    }
    
    func getGroups(completion: @escaping ([Group]) -> Void) {
        guard let url = URL(string: "https://api.vk.com/method/groups.get?access_token=\(NetworkService.token)&fields=description&v=5.199&extended=1") else { return }
        
        session.dataTask(with: url) { (data, _, error) in
            guard let data = data else { return }
            do {
                let groups = try JSONDecoder().decode(GroupsModel.self, from: data).response.items
                completion(groups ?? [])
            } catch { print(error) }
        }.resume()
    }
    
    func getPhotos(completion: @escaping ([Photo]) -> Void) {
        guard let url = URL(string: "https://api.vk.com/method/photos.get?access_token=\(NetworkService.token)&v=5.199&&album_id=profile") else { return }
        
        session.dataTask(with: url) { (data, _, error) in
            guard let data = data else { return }
            do {
                let photos = try JSONDecoder().decode(PhotosModel.self, from: data).response.items
                completion(photos ?? [])
            } catch { print(error) }
        }.resume()
    }
    
    func getProfileData(completion: @escaping (Profile?) -> Void) {
        guard let url = URL(string: "https://api.vk.com/method/account.getProfileInfo?access_token=\(NetworkService.token)&v=5.199") else { return }
        
        session.dataTask(with: url) { (data, _, error) in
            guard let data = data else { return }
            do {
                let person = try JSONDecoder().decode(ProfileModel.self, from: data).response
                completion(person)
            } catch { print(error) }
        }.resume()
    }
    
}
