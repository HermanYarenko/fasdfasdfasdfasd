//
//  GroupModel.swift
//  HomeWorkIOS
//
//  Created by Герман Яренко on 22.11.23.
//
import UIKit

struct GroupsModel: Decodable {
    var response: Groups
}

struct Groups: Decodable {
    var items: [Group]?
}

struct Group: Decodable {
    var id: Int
    var name: String?
    var photo: String?
    var description: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo = "photo_50"
        case description
    }
}
