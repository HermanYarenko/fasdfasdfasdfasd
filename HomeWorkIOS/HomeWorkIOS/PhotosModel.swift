//
//  PhotosModel.swift
//  HomeWorkIOS
//
//  Created by Герман Яренко on 22.11.23.
//

import UIKit

struct PhotosModel: Decodable {
    var response: Photos
}

struct Photos: Decodable {
    var items: [Photo]?
}

struct Photo: Decodable {
    var id: Int
    var text: String
    var sizes: [Size]
}

struct Size: Codable {
    var url: String
}
