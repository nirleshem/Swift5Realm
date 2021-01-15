//
//  APIUser.swift
//  Swift5Realm
//
//  Created by Nir Leshem on 09/01/2021.
//

import Foundation
import ObjectMapper
import RealmSwift

struct APIUsersResponse: Decodable {
    var users: [APIUser]
    
    static func returnEmpty() -> Self {
        return .init(users: [])
    }
}

class APIUser: Mappable, Decodable, Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: APIUser, rhs: APIUser) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: Int?
    var name: String?
    var username: String?
    var email: String?
    var address: Address?
    var phone: String?
    var website: String?
    var company: Company?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        id           <- map["id"]
        name         <- map["name"]
        username     <- map["username"]
        email        <- map["email"]
        address      <- map["address"]
        phone        <- map["phone"]
        website      <- map["website"]
        company      <- map["company"]
    }
}

// MARK: - Address
class Address: Mappable, Decodable {
    var street: String?
    var suite: String?
    var city: String?
    var zipcode: String?
    var geo: Geo?
    
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        street       <- map["street"]
        suite        <- map["suite"]
        city         <- map["city"]
        zipcode      <- map["zipcode"]
        geo          <- map["geo"]
    }
}

// MARK: - Geo
class Geo: Mappable, Decodable {
    var lat: String?
    var lng: String?
    
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        lat      <- map["lat"]
        lng      <- map["lng"]
    }
}

// MARK: - Company
class Company: Mappable, Decodable {
    var name: String?
    var catchPhrase: String?
    var bs: String?
    
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        name           <- map["name"]
        catchPhrase    <- map["catchPhrase"]
        bs             <- map["bs"]
    }
}

