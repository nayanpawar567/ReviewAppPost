//
//  ModelReviewApp.swift
//  ReviewApp
//
//  Created by Nayan Pawar on 02/03/23.
//

import Foundation
//
//  BaseModel-1.swift
//  RatingApp
//
//  Created by Nayan Pawar on 02/03/23.
//

import Foundation


// MARK: - Basemodel
struct BaseModel: Codable {
    let code: Int?
    let data: [Datum]?
    let avgRatting: Double?

    enum CodingKeys: String, CodingKey {
        case code, data
        case avgRatting = "avg_ratting"
    }
}

// MARK: - Datum
struct Datum: Codable {
    let rattingID, ratting: Int?
    let review: String?
    let reviewReply: String?
    let created: String?
    let id: Int?
    let firstName, lastName: String?
    let profileImageURL: String?
    let following: String?

    enum CodingKeys: String, CodingKey {
        case rattingID = "ratting_id"
        case ratting, review
        case reviewReply = "review_reply"
        case created, id
        case firstName = "first_name"
        case lastName = "last_name"
        case profileImageURL = "profile_image_url"
        case following
    }
}
